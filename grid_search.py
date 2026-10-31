"""
Train-only grid search for selecting the best random forest per dataset.

For every (trees, depth) combination this trains a random forest with sklearn
(via learn_random_forest.py) and flags, per dataset, two winners: the model with
the highest macro-F1 and the one with the highest weighted-F1 (which may be the
same model). Scores are those learn_random_forest.py records, under hard
(majority) voting unless the config sets "voting": "soft". Ties go to the
smaller model: fewer trees, then lower depth. It does NOT run the ASP / pairs / benchmark pipeline and ignores
bins entirely — it only trains models and compares them.

Every trained model is saved under <models-root>/<dataset>/t<trees>_d<depth>/
(random_forest.pkl + model_statistics.txt; --models-root defaults to models/);
none are discarded. A standalone performance table for every trained model is
written to models/grid_search_performance.txt, and the weighted-F1 winners to
models/best_models.txt.

NOTE: per the project guidelines (CLAUDE.md), the user runs this command; it is
not executed automatically.

The sweep (datasets, trees, depth) is read from grid_search_config.json at the
repo root by default; any CLI flag overrides the corresponding config value.

Usage:
    python grid_search.py                    # use grid_search_config.json
    python grid_search.py --trees 10 20 30 --depth 3 5 7
    python grid_search.py --datasets breast+cancer+wisconsin+diagnostic wine+quality
    python grid_search.py --all-datasets     # every data/<dataset> with a config.json
    python grid_search.py --config my_config.json
    python grid_search.py --models-root /tmp/grid   # keep the grid out of models/
"""

import argparse
import datetime
import json
import os
import re
import subprocess
import sys

BASE_DIR = os.path.dirname(os.path.abspath(__file__))

# Config file holding the default sweep (datasets, trees, depth). Sits at the
# repo root in the same flat-JSON style as the data/<dataset>/config.json files.
DEFAULT_CONFIG = os.path.join(BASE_DIR, "grid_search_config.json")

# Built-in fallback grid, used only for keys absent from the config file (or if
# the config file is missing). CLI flags override the config, which overrides
# these.
BUILTIN_TREES = [10, 50, 100]
BUILTIN_DEPTH = [3, 5]
BUILTIN_DATASETS = ["breast+cancer+wisconsin+diagnostic"]


def load_config(path):
    """Load the grid-search config JSON (datasets, trees, depth). Returns an empty
    dict if the file is absent, so built-in defaults apply."""
    if not os.path.exists(path):
        return {}
    with open(path) as f:
        return json.load(f)


def discover_datasets():
    """Return every dataset folder name under data/ that has a config.json,
    sorted alphabetically. Used by --all-datasets."""
    data_root = os.path.join(BASE_DIR, "data")
    if not os.path.isdir(data_root):
        return []
    return sorted(
        name for name in os.listdir(data_root)
        if os.path.isfile(os.path.join(data_root, name, "config.json")))


def run_step(cmd, label):
    """Run a subprocess; return True on success, False on failure.

    Captures output so the log stays readable; on failure the tail of stderr is
    surfaced so the cause is visible.
    """
    proc = subprocess.run(cmd, capture_output=True, text=True)
    if proc.returncode != 0:
        print(f"    [FAILED] {label} (exit {proc.returncode})")
        tail = (proc.stderr or proc.stdout).strip().splitlines()[-5:]
        for line in tail:
            print(f"      | {line}")
        return False
    return True


def read_model_info(model_dir):
    """Parse train/test accuracy, total nodes, actual max depth, number of features
    used, and number of classes from model_statistics.txt (None for any missing).
    """
    info = dict.fromkeys([
        "train_acc", "test_acc", "total_nodes", "max_depth",
        "n_features", "used_features", "n_classes", "predicted_classes",
        "macro_f1", "weighted_f1", "qwk", "avg_split_points",
    ])
    stats = os.path.join(model_dir, "model_statistics.txt")
    if not os.path.exists(stats):
        return info
    text = open(stats).read()

    def grab(pattern, cast=float):
        m = re.search(pattern, text)
        return cast(m.group(1)) if m else None

    info["train_acc"] = grab(r"Train Accuracy:\s*([0-9.]+)")
    info["test_acc"] = grab(r"Test Accuracy:\s*([0-9.]+)")
    info["total_nodes"] = grab(r"Total nodes:\s*(\d+)", int)
    # Actual realized depth (the "Forest Size" line carries an "(avg: ...)" suffix,
    # distinguishing it from the configured --max-depth cap line above it).
    info["max_depth"] = grab(r"Max depth:\s*(\d+)\s*\(avg:", int)
    # Total features available to the model, vs. "Used (X/Y):" — X is the number
    # the forest actually splits on (used_features <= n_features).
    info["n_features"] = grab(r"Number of features:\s*(\d+)", int)
    info["used_features"] = grab(r"Used \((\d+)/\d+\):", int)
    info["n_classes"] = grab(r"Number of classes:\s*(\d+)", int)
    # Classes the model actually predicts on the test set (<= n_classes).
    info["predicted_classes"] = grab(r"Classes predicted:\s*(\d+)", int)
    # macro/weighted avg rows: "<label>  <prec>  <recall>  <f1>  <support>"; grab
    # the F1 (3rd float). The two-word labels disambiguate from per-class rows.
    info["macro_f1"] = grab(r"macro avg\s+[\d.]+\s+[\d.]+\s+([\d.]+)")
    info["weighted_f1"] = grab(r"weighted avg\s+[\d.]+\s+[\d.]+\s+([\d.]+)")
    # Quadratic Weighted Kappa (ordinal metric); can be negative, so allow a sign.
    info["qwk"] = grab(r"Quadratic Weighted Kappa:\s*(-?[\d.]+)")
    # Average distinct split-point thresholds per feature the forest splits on.
    info["avg_split_points"] = grab(r"Avg split points per feature:\s*([\d.]+)")
    return info


def grid_search_models(datasets, trees_grid, depth_grid, learn_params=None,
                       models_root=None):
    """Train-only grid search: for each dataset, sweep (trees, depth), train the
    random forest with sklearn. In the performance table, EVERY config tied at
    the dataset's max macro-F1 (and max weighted-F1) is flagged with a '*'. For
    the console summary / results tuple a single winner per metric is chosen
    among the tied configs: the smaller model (fewer trees, then lower depth).

    learn_params: optional {trainer_flag: value} of fixed learning knobs (e.g.
    {"--min-samples-leaf": 5}) applied to every model; unset knobs let the trainer
    use its own defaults.

    Every trained model is saved under <models_root>/<dataset>/t<trees>_d<depth>/
    (models_root defaults to models/); none are discarded.

    Returns (results, perf_rows):
      results   — list of (dataset, mf1_trees, mf1_depth, best_macro_f1,
                  wf1_trees, wf1_depth, best_weighted_f1, n_evaluated,
                  search_root) tuples; the best_* fields are None if no model
                  trained successfully for that dataset.
      perf_rows — list of (dataset, trees, depth, train_acc, test_acc, macro_f1,
                  weighted_f1, qwk, total_nodes, avg_split_points, max_depth,
                  n_features, used_features, n_classes, predicted_classes,
                  is_best_macro_f1, is_best_weighted_f1) for every trained model,
                  for writing a standalone performance table.
    """
    # Flatten the fixed learning knobs into trainer CLI args (["--flag", "val", ...]).
    learn_args = [str(x) for kv in (learn_params or {}).items() for x in kv]
    models_root = models_root or os.path.join(BASE_DIR, "models")

    results = []
    perf_rows = []
    for dataset in datasets:
        dataset_dir = os.path.join(BASE_DIR, "data", dataset)
        if not os.path.isdir(dataset_dir):
            print(f"\n[{dataset}] data dir not found — skipping dataset")
            results.append((dataset, None, None, None, None, None, None, 0, None))
            continue

        search_root = os.path.join(models_root, dataset)
        print(f"\n{'─'*88}")
        print(f"{dataset}  (train-only grid search over trees x depth)")

        def s(v):
            return str(v) if v is not None else "?"
        def f(v):
            return f"{v:.4f}" if v is not None else "?"

        n_eval = 0
        header_printed = False
        # (trees, depth, train_acc, test_acc, macro_f1, weighted_f1, qwk,
        #  total_nodes, avg_split_points, max_depth, n_features, used_features,
        #  n_classes, predicted_classes)
        dataset_rows = []
        for n_trees in trees_grid:
            for depth in depth_grid:
                cfg_dir = os.path.join(search_root, f"t{n_trees}_d{depth}")
                ok = run_step(
                    [sys.executable, os.path.join(BASE_DIR, "learn_random_forest.py"),
                     dataset_dir, "--n-estimators", str(n_trees),
                     "--max-depth", str(depth), "--output-dir", cfg_dir,
                     *learn_args],
                    "train")
                mi = read_model_info(cfg_dir) if ok else {}

                # Print the dataset-totals line + table header once, after the
                # first model so the dataset's feature/class counts are known.
                if not header_printed:
                    print(f"  dataset: features={s(mi.get('n_features'))}  "
                          f"classes={s(mi.get('n_classes'))}")
                    print(f"{'─'*88}")
                    print(f"    {'Trees':>5}  {'Depth':>5}  {'TestAcc':>8}  "
                          f"{'MacroF1':>8}  {'WtdF1':>8}  {'QWK':>8}  {'Nodes':>8}  "
                          f"{'AvgSplit':>8}  {'MaxD':>5}  {'UsedFeat':>8}  {'UsedCls':>7}")
                    print(f"    {'-'*5}  {'-'*5}  {'-'*8}  {'-'*8}  {'-'*8}  "
                          f"{'-'*8}  {'-'*8}  {'-'*8}  {'-'*5}  {'-'*8}  {'-'*7}")
                    header_printed = True

                if not ok:
                    print(f"    {n_trees:>5}  {depth:>5}  {'FAIL':>8}  {'-':>8}  "
                          f"{'-':>8}  {'-':>8}  {'-':>8}  {'-':>8}  {'-':>5}  "
                          f"{'-':>8}  {'-':>7}")
                    continue
                test_acc = mi["test_acc"]
                n_eval += 1
                dataset_rows.append(
                    (n_trees, depth, mi["train_acc"], test_acc, mi["macro_f1"],
                     mi["weighted_f1"], mi["qwk"], mi["total_nodes"],
                     mi["avg_split_points"], mi["max_depth"], mi["n_features"],
                     mi["used_features"], mi["n_classes"], mi["predicted_classes"]))

                print(f"    {n_trees:>5}  {depth:>5}  {f(test_acc):>8}  "
                      f"{f(mi['macro_f1']):>8}  {f(mi['weighted_f1']):>8}  "
                      f"{f(mi['qwk']):>8}  {s(mi['total_nodes']):>8}  "
                      f"{f(mi['avg_split_points']):>8}  {s(mi['max_depth']):>5}  "
                      f"{s(mi['used_features']):>8}  {s(mi['predicted_classes']):>7}")

        if n_eval:
            print(f"    models saved under: "
                  f"{os.path.relpath(search_root, BASE_DIR)}/t<trees>_d<depth>/")

        # Pick the best (trees, depth) by macro-F1 and by weighted-F1. On ties
        # (several configs share the max score) take the smaller model: fewer
        # trees, then lower depth.

        def tied_best(metric_index):
            """Return the set of every (trees, depth) tied at the max score for
            dataset_rows[*][metric_index] (empty if no scored rows). Used to star
            ALL best models in the performance table."""
            scored = [(row[metric_index], row[0], row[1]) for row in dataset_rows
                      if row[metric_index] is not None]
            if not scored:
                return set()
            best_score = max(s for s, _, _ in scored)
            return {(t, d) for s, t, d in scored if s == best_score}

        def pick_best(tied):
            """The smallest (trees, depth) among the tied-best configs; None if
            the set is empty."""
            return min(tied) if tied else None

        # All tied-best configs get a '*' in the table; the smallest of them is
        # the single winner used for the console summary and results tuple.
        tied_mf1 = tied_best(4)   # macro_f1 is dataset_rows index 4
        tied_wf1 = tied_best(5)   # weighted_f1 is dataset_rows index 5
        best_mf1_td = pick_best(tied_mf1)
        best_wf1_td = pick_best(tied_wf1)
        for (tr, dp, tr_acc, te_acc, mf1, wf1, qwk, nodes, asp, mx, nfeat, feats, cls, pcls) in dataset_rows:
            perf_rows.append(
                (dataset, tr, dp, tr_acc, te_acc, mf1, wf1, qwk, nodes, asp, mx,
                 nfeat, feats, cls, pcls,
                 (tr, dp) in tied_mf1, (tr, dp) in tied_wf1))
        # Look up the winning score for each metric (None if no winner).
        def score_of(td, metric_index):
            if td is None:
                return None
            for row in dataset_rows:
                if (row[0], row[1]) == td:
                    return row[metric_index]
            return None

        results.append((
            dataset,
            best_mf1_td[0] if best_mf1_td else None,
            best_mf1_td[1] if best_mf1_td else None,
            score_of(best_mf1_td, 4),
            best_wf1_td[0] if best_wf1_td else None,
            best_wf1_td[1] if best_wf1_td else None,
            score_of(best_wf1_td, 5),
            n_eval, search_root))
    return results, perf_rows


def write_performance_table(perf_rows, trees_grid, depth_grid):
    """Write a standalone plain-text performance table for every trained model to
    models/grid_search_performance.txt and return its path.

    perf_rows: list of (dataset, trees, depth, train_acc, test_acc, macro_f1,
    weighted_f1, qwk, total_nodes, avg_split_points, max_depth, n_features,
    used_features, n_classes, predicted_classes, is_best_macro_f1,
    is_best_weighted_f1). EVERY model tied at the dataset's max score is flagged:
    a '*' in the BestMF1 column marks all highest-macro-F1 models and a '*' in
    BestWF1 marks all highest-weighted-F1 models (a model may earn both). QWK is
    the Quadratic Weighted Kappa (ordinal metric); AvgSplit is the avg distinct
    split points per feature. NFeat/NCls are the dataset totals; UsedFeat/UsedCls
    are what the model actually splits on / predicts.
    """
    models_root = os.path.join(BASE_DIR, "models")
    os.makedirs(models_root, exist_ok=True)
    perf_path = os.path.join(models_root, "grid_search_performance.txt")

    ts = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    lines = []
    lines.append("=" * 78)
    lines.append("GRID SEARCH — MODEL PERFORMANCE (train-only: trees x depth)")
    lines.append(f"Generated: {ts}")
    lines.append(f"Trees grid: {trees_grid}    Depth grid: {depth_grid}")
    lines.append("=" * 78)
    lines.append("")

    def fmt_acc(v):
        return f"{v:.4f}" if v is not None else "?"

    def s(v):
        return str(v) if v is not None else "?"

    header = (f"{'Dataset':<34}  {'Trees':>5}  {'Depth':>5}  "
              f"{'TrainAcc':>8}  {'TestAcc':>8}  {'MacroF1':>8}  {'WtdF1':>8}  "
              f"{'QWK':>8}  {'Nodes':>8}  {'AvgSplit':>8}  {'MaxD':>5}  {'NFeat':>5}  "
              f"{'UsedFeat':>8}  {'NCls':>4}  {'UsedCls':>7}  {'BestMF1':>7}  {'BestWF1':>7}")
    sep = (f"{'-'*34}  {'-'*5}  {'-'*5}  {'-'*8}  {'-'*8}  {'-'*8}  {'-'*8}  "
           f"{'-'*8}  {'-'*8}  {'-'*8}  {'-'*5}  {'-'*5}  {'-'*8}  {'-'*4}  "
           f"{'-'*7}  {'-'*7}  {'-'*7}")
    lines.append(header)
    lines.append(sep)
    for (dataset, trees, depth, train_acc, test_acc, macro_f1, weighted_f1, qwk,
         total_nodes, avg_split_points, max_depth, n_features, used_features,
         n_classes, predicted_classes, is_best_mf1, is_best_wf1) in perf_rows:
        lines.append(
            f"{dataset:<34}  {trees:>5}  {depth:>5}  "
            f"{fmt_acc(train_acc):>8}  {fmt_acc(test_acc):>8}  "
            f"{fmt_acc(macro_f1):>8}  {fmt_acc(weighted_f1):>8}  {fmt_acc(qwk):>8}  "
            f"{s(total_nodes):>8}  {fmt_acc(avg_split_points):>8}  {s(max_depth):>5}  "
            f"{s(n_features):>5}  {s(used_features):>8}  {s(n_classes):>4}  "
            f"{s(predicted_classes):>7}  {'*' if is_best_mf1 else '':>7}  "
            f"{'*' if is_best_wf1 else '':>7}")
    if not perf_rows:
        lines.append("(no models trained successfully)")

    with open(perf_path, "w") as f:
        f.write("\n".join(lines) + "\n")
    return perf_path


def write_best_models(best_models, voting):
    """Write the weighted-F1 winner of every dataset to models/best_models.txt."""
    path = os.path.join(BASE_DIR, "models", "best_models.txt")
    lines = ["Best random-forest models selected from models/grid_search_performance.txt",
             f"Metric: highest Weighted-F1 ({voting} voting) only; ties: fewer trees, "
             "then lower depth.", "",
             f"{'Dataset':<24} {'Config':>8} {'WtdF1':>8}",
             f"{'-'*24} {'-'*8} {'-'*8}"]
    for dataset, _, _, _, wft, wfd, wf1, _, _ in best_models:
        if wft is not None:
            lines.append(f"{dataset:<24} {f't{wft}_d{wfd}':>8} {wf1:>8.4f}")
    with open(path, "w") as f:
        f.write("\n".join(lines) + "\n")
    return path


def main():
    parser = argparse.ArgumentParser(
        description="Train-only grid search flagging the best random forest by "
                    "macro-F1 and by weighted-F1 per dataset."
    )
    # Defaults are None so we can tell whether the user passed a flag; unset
    # values fall back to the config file, then to the built-in grid.
    parser.add_argument("--config", default=DEFAULT_CONFIG,
                        help="Path to the grid-search config JSON "
                             "(default: grid_search_config.json at the repo root)")
    parser.add_argument("--trees", type=int, nargs="+", default=None,
                        help="Numbers of trees to sweep (overrides config)")
    parser.add_argument("--depth", type=int, nargs="+", default=None,
                        help="Tree depths to sweep (overrides config)")
    parser.add_argument("--datasets", nargs="+", default=None,
                        help="Dataset folder names (overrides config)")
    parser.add_argument("--all-datasets", action="store_true",
                        help="Sweep every dataset under data/ that has a "
                             "config.json (overrides --datasets and the config).")
    # Fixed learning knobs applied to every trained model (not swept). Passed
    # straight through to learn_random_forest.py. None => config => trainer default.
    parser.add_argument("--min-samples-split", type=int, default=None,
                        help="Min samples to split a node (trainer default: 5)")
    parser.add_argument("--min-samples-leaf", type=int, default=None,
                        help="Min samples in a leaf (trainer default: 2)")
    parser.add_argument("--ccp-alpha", type=float, default=None,
                        help="Cost-complexity pruning parameter (trainer default: 0.0)")
    parser.add_argument("--criterion", choices=["gini", "entropy", "log_loss"], default=None,
                        help="Split quality criterion (trainer default: gini)")
    parser.add_argument("--voting", choices=["hard", "soft"], default=None,
                        help="Voting rule the models are scored with (trainer default: hard)")
    parser.add_argument("--models-root", default=None,
                        help="Where to save the trained models (default: models/)")
    parser.add_argument("--test-size", type=float, default=None,
                        help="Test set fraction (trainer default: 0.2)")
    parser.add_argument("--random-state", type=int, default=None,
                        help="Random seed (trainer default: 42)")
    args = parser.parse_args()

    # Precedence: --all-datasets > --datasets flag > config file value > built-in.
    cfg = load_config(args.config)
    if args.trees is None:
        args.trees = cfg.get("trees", BUILTIN_TREES)
    if args.depth is None:
        args.depth = cfg.get("depth", BUILTIN_DEPTH)
    if args.all_datasets:
        args.datasets = discover_datasets()
        if not args.datasets:
            parser.error("--all-datasets found no dataset with a config.json under data/")
    elif args.datasets is None:
        args.datasets = cfg.get("datasets", BUILTIN_DATASETS)

    # Resolve the fixed learning knobs the same way: CLI flag > config > unset.
    # Only the params actually set become trainer flags; unset ones let the
    # trainer apply its own defaults.
    learn_params = {}
    for name, flag in [("min_samples_split", "--min-samples-split"),
                       ("min_samples_leaf", "--min-samples-leaf"),
                       ("ccp_alpha", "--ccp-alpha"),
                       ("criterion", "--criterion"),
                       ("voting", "--voting"),
                       ("test_size", "--test-size"),
                       ("random_state", "--random-state")]:
        val = getattr(args, name)
        if val is None:
            val = cfg.get(name)
        if val is not None:
            learn_params[flag] = val

    print("=" * 88)
    print("GRID SEARCH — BEST MODEL PER DATASET  (train-only: trees x depth)")
    print(f"trees:          {args.trees}")
    print(f"depth:          {args.depth}")
    print(f"datasets:       {args.datasets}")
    if learn_params:
        print(f"learn params:   "
              f"{' '.join(f'{k}={v}' for k, v in learn_params.items())}")
    print(f"models/dataset: {len(args.trees) * len(args.depth)}")
    print("=" * 88)

    best_models, perf_rows = grid_search_models(
        args.datasets, args.trees, args.depth, learn_params, args.models_root)

    print(f"\n{'='*92}")
    print("BEST MODEL PER DATASET  (by macro-F1 and by weighted-F1)")
    print(f"{'='*92}")
    print(f"  {'Dataset':<34}  {'Metric':>7}  {'Trees':>5}  {'Depth':>5}  "
          f"{'Score':>8}  {'Evald':>5}  {'Best model dir'}")
    print(f"  {'-'*34}  {'-'*7}  {'-'*5}  {'-'*5}  {'-'*8}  {'-'*5}  {'-'*14}")
    for (dataset, mft, mfd, mf1, wft, wfd, wf1, n_eval, search_root) in best_models:
        for metric, t, d, score in (("MacroF1", mft, mfd, mf1),
                                     ("WtdF1", wft, wfd, wf1)):
            if t is None:
                print(f"  {dataset:<34}  {metric:>7}  {'—':>5}  {'—':>5}  "
                      f"{'—':>8}  {n_eval:>5}  —")
            else:
                best_dir = os.path.relpath(
                    os.path.join(search_root, f"t{t}_d{d}"), BASE_DIR)
                print(f"  {dataset:<34}  {metric:>7}  {t:>5}  {d:>5}  "
                      f"{score:>8.4f}  {n_eval:>5}  {best_dir}")

    perf_path = write_performance_table(perf_rows, args.trees, args.depth)
    print(f"\nPerformance table saved to: "
          f"{os.path.relpath(perf_path, BASE_DIR)}")
    best_path = write_best_models(best_models, learn_params.get("--voting", "hard"))
    print(f"Best models saved to: {os.path.relpath(best_path, BASE_DIR)}")


if __name__ == "__main__":
    main()
