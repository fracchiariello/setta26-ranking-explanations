"""
Run the explanation experiments over every model and every pair.

For each model (models/<dataset>/t<trees>_d<depth>/) and each pair
(pairs/pair_*.lp) the script computes, via the clingo | wasp --mus pipeline:

  * the FIRST explanation        (wasp -n 1) — its size and the time to find it
  * the SET of ALL explanations  (wasp -n 0) — how many, their min/max/avg size,
                                                and the time to enumerate them all

An explanation (AXp) is a MUS of the `selected/1` features: a subset-minimal set
of features that, when fixed to item-1's values, forces the prediction order to
hold — i.e. a minimal abductive explanation of the pair's classification.

Each timing can be repeated (--repeats) and reported as mean ± stdev; a per-run
timeout guards both the first-AXp and the all-AXps computation.

Results are printed and teed to:
    results/explanations_<timestamp>.txt   (human-readable tables)
    results/explanations_<timestamp>.json  (machine-readable, with the AXp sets)

Usage:
    python run_explanations.py
    python run_explanations.py --datasets breast+cancer glioma
    python run_explanations.py --pairs 5 --repeats 3
    python run_explanations.py --pair-files models/breast+cancer/t10_d3/pairs/pair_0.lp
    python run_explanations.py --first-only --timeout-first 120
    python run_explanations.py --models-dir models --pairs 5

Requires clingo and wasp on PATH (wasp falls back to the bundled build path).
"""

import argparse
import datetime
import glob
import json
import math
import os
import re
import shutil
import subprocess
import threading
import time

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
WASP_BIN = shutil.which("wasp") or os.path.join(
    os.path.expanduser("~"), "Downloads", "alviano-wasp-4332268", "build", "release", "wasp"
)
ENCODING_LP = os.path.join(BASE_DIR, "encoding.lp")
MODELS_DIR_DEFAULT = os.path.join(BASE_DIR, "models")

TIMEOUT_FIRST_DEFAULT = 300          # seconds for the first-AXp run (5 min)
TIMEOUT_ALL_MULTIPLIER = 5           # all-AXps timeout = this * first-AXp timeout
CONFIG_RE = re.compile(r"^t\d+_d\d+$")


# --------------------------------------------------------------------------- #
# Model / pair discovery
# --------------------------------------------------------------------------- #
def discover_models(models_dir, datasets=None):
    """Return [(dataset, config, model_dir), ...] for every model that has a
    random_forest.lp. A model dir is models_dir/<dataset>/t<trees>_d<depth>/.

    If `datasets` is given, only those dataset folders are considered.
    Results are sorted by (dataset, config) for stable, reproducible runs.
    """
    found = []
    for rf_lp in glob.glob(os.path.join(models_dir, "*", "*", "random_forest.lp")):
        model_dir = os.path.dirname(rf_lp)
        config = os.path.basename(model_dir)
        dataset = os.path.basename(os.path.dirname(model_dir))
        if not CONFIG_RE.match(config):
            continue
        if datasets and dataset not in datasets:
            continue
        found.append((dataset, config, model_dir))
    return sorted(found)


def find_pairs(model_dir, max_pairs):
    """Return up to max_pairs pair .lp paths (numerically ordered) for a model.

    Looks in model_dir/pairs/ first, then model_dir/, then a single pair.lp.
    """
    for subdir in (os.path.join(model_dir, "pairs"), model_dir):
        paths = glob.glob(os.path.join(subdir, "pair_*.lp"))
        if paths:
            paths.sort(key=lambda p: int(re.search(r"pair_(\d+)\.lp$", p).group(1)))
            return paths[:max_pairs]
    p = os.path.join(model_dir, "pair.lp")
    return [p] if os.path.exists(p) else []


def normalize_paths(paths):
    """Return absolute, normalized paths for stable pair-file filtering."""
    return {os.path.abspath(p) for p in (paths or [])}


# --------------------------------------------------------------------------- #
# clingo | wasp --mus pipeline
# --------------------------------------------------------------------------- #
def add_debug_wrappers(program, feat_indices):
    """Wrap every candidate feature in a __debug__ assumption so wasp can find
    the minimal unsatisfiable sets of `selected/1` atoms (the AXps)."""
    lines = [program.strip(), ""]
    for f in feat_indices:
        lines.append(f"selected({f}) :- __debug__(selected({f})).")
        lines.append(f"{{__debug__(selected({f}))}}.")
    lines.append("#show __debug__/1.")
    return "\n".join(lines)


def run_mus(program, n_mus, timeout):
    """Run clingo | wasp --mus on `program`; return (wall_s, muses, timed_out).

    wall_s    : elapsed wall time in seconds (None on timeout)
    muses     : list of AXps, each a sorted list of feature indices. On timeout
                this holds whatever wasp streamed before being killed.
    timed_out : True if the wasp process was killed by the timeout.

    wasp's stdout is drained by a background thread so MUSes emitted before a
    timeout are not lost (communicate() would discard buffered output on kill).
    """
    clingo_cmd = ["clingo", "--output=smodels", "-"]
    wasp_cmd = ["stdbuf", "-oL", WASP_BIN, "--mus=__debug__", f"-n{n_mus}"]

    t0 = time.perf_counter()
    clingo_proc = subprocess.Popen(
        clingo_cmd, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE,
    )
    stdout_clingo, _ = clingo_proc.communicate(input=program.encode())

    wasp_proc = subprocess.Popen(
        wasp_cmd, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE,
    )

    muses = []

    def reader():
        for raw in wasp_proc.stdout:
            m = re.match(r"\[MUS #\d+\]:(.*)", raw.decode(errors="replace"))
            if m:
                feats = re.findall(r"__debug__\(selected\((\d+)\)\)", m.group(1))
                muses.append(sorted(int(f) for f in feats))

    reader_thread = threading.Thread(target=reader, daemon=True)
    wasp_proc.stdin.write(stdout_clingo)
    wasp_proc.stdin.close()
    reader_thread.start()

    try:
        wasp_proc.wait(timeout=timeout)
        wall = time.perf_counter() - t0
        timed_out = False
    except subprocess.TimeoutExpired:
        wasp_proc.kill()
        wall = None
        timed_out = True

    reader_thread.join(timeout=5)
    return wall, muses, timed_out


def repeat_run(program, n_mus, repeats, timeout):
    """Run run_mus `repeats` times; return (mean_s, std_s, muses, timed_out).

    `muses` is the AXp list from the last (completed) repetition — wasp's result
    is deterministic across repeats in practice. Stops at the first timeout and
    returns (None, None, partial_muses, True).
    """
    times = []
    last_muses = []
    for _ in range(repeats):
        t, m, timed_out = run_mus(program, n_mus, timeout)
        if timed_out:
            return None, None, m, True
        times.append(t)
        last_muses = m
    mean = sum(times) / len(times)
    std = math.sqrt(sum((t - mean) ** 2 for t in times) / len(times))
    return mean, std, last_muses, False


# --------------------------------------------------------------------------- #
# Formatting / stats
# --------------------------------------------------------------------------- #
def fmt_t(mean, std=None, repeats=1):
    if mean is None:
        return "TIMEOUT"
    if repeats > 1 and std is not None:
        return f"{mean*1000:.1f} ± {std*1000:.1f} ms"
    return f"{mean*1000:.1f} ms"


def size_stats(muses):
    """min, max, avg AXp size over a list of AXps ([] -> (0, 0, 0.0))."""
    if not muses:
        return 0, 0, 0.0
    sizes = [len(m) for m in muses]
    return min(sizes), max(sizes), sum(sizes) / len(sizes)


# --------------------------------------------------------------------------- #
# Main
# --------------------------------------------------------------------------- #
def main():
    parser = argparse.ArgumentParser(
        description="Compute the first explanation and all explanations (size + time) "
                    "for every model and every pair."
    )
    parser.add_argument("--models-dir", default=MODELS_DIR_DEFAULT,
                        help="Root holding <dataset>/t<trees>_d<depth>/ models "
                             f"(default: {MODELS_DIR_DEFAULT})")
    parser.add_argument("--datasets", nargs="+", default=None,
                        help="Restrict to these dataset folder names (default: all found)")
    parser.add_argument("--pairs", type=int, default=5,
                        help="Max pairs per model (default: 5)")
    parser.add_argument("--pair-files", nargs="+", default=None,
                        help="Restrict execution to these exact pair .lp files. "
                             "Useful for batch runs with one task per pair.")
    parser.add_argument("--repeats", type=int, default=1,
                        help="Repeat each timing N times, report mean ± stdev (default: 1)")
    parser.add_argument("--first-only", action="store_true",
                        help="Only compute the first explanation; skip the all-AXps enumeration")
    parser.add_argument("--timeout-first", type=int, default=TIMEOUT_FIRST_DEFAULT,
                        help=f"Timeout (s) for the first-AXp run (default: {TIMEOUT_FIRST_DEFAULT}). "
                             "On timeout the pair is skipped (all-AXps not attempted).")
    parser.add_argument("--timeout-all", type=int, default=None,
                        help=f"Timeout (s) for the all-AXps run "
                             f"(default: {TIMEOUT_ALL_MULTIPLIER}x --timeout-first).")
    parser.add_argument("--output", default=None,
                        help="Base output path (without extension). Default: "
                             "results/explanations_<timestamp>")
    args = parser.parse_args()

    timeout_all = args.timeout_all if args.timeout_all is not None \
        else TIMEOUT_ALL_MULTIPLIER * args.timeout_first

    models = discover_models(args.models_dir, args.datasets)
    if not models:
        raise SystemExit(f"No models found under {args.models_dir} "
                         "(expected <dataset>/t<trees>_d<depth>/random_forest.lp)")

    # Output files (tee print to stdout + .txt; structured results to .json).
    results_dir = os.path.join(BASE_DIR, "results")
    os.makedirs(results_dir, exist_ok=True)
    ts = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    base = args.output or os.path.join(results_dir, f"explanations_{ts}")
    txt_path, json_path = base + ".txt", base + ".json"

    out_file = open(txt_path, "w")
    import builtins
    _orig_print = builtins.print

    def _tee(*a, **kw):
        _orig_print(*a, **kw)
        kw2 = {k: v for k, v in kw.items() if k != "file"}
        _orig_print(*a, file=out_file, **kw2)
        out_file.flush()          # write each row immediately so the .txt can be tailed live

    builtins.print = _tee

    rep = args.repeats
    pair_file_filter = normalize_paths(args.pair_files)
    print("=" * 92)
    print("EXPLANATION EXPERIMENTS  (clingo | wasp --mus)")
    print(f"models dir:     {args.models_dir}")
    print(f"models:         {len(models)}   "
          f"({'specific pair files' if pair_file_filter else f'max {args.pairs} pairs each'})")
    print(f"wasp:           {WASP_BIN}")
    print(f"repeats:        {rep}")
    print(f"first only:     {args.first_only}")
    print(f"timeout first:  {args.timeout_first}s   timeout all: "
          f"{'n/a' if args.first_only else f'{timeout_all}s'}")
    print("=" * 92)

    pair_col = 10
    t_col = 22 if rep > 1 else 13
    records = []   # structured results for JSON

    for dataset, config, model_dir in models:
        rf_lp = os.path.join(model_dir, "random_forest.lp")
        if pair_file_filter:
            model_root = os.path.abspath(model_dir) + os.sep
            pairs = sorted(p for p in pair_file_filter
                           if p.startswith(model_root) and os.path.exists(p))
        else:
            pairs = find_pairs(model_dir, args.pairs)
        if not pairs:
            print(f"\n[{dataset}/{config}]  no pair files — skipping")
            continue

        with open(rf_lp) as f:
            rf_content = f.read()
        with open(ENCODING_LP) as f:
            enc_content = f.read()

        print(f"\n{'─'*110}")
        print(f"Model: {dataset}/{config}   ({len(pairs)} pairs)")
        print(f"{'─'*110}")
        print(f"  {'Pair':<{pair_col}}  {'Feats':>5}  "
              f"{'1st size':>8}  {'1st time':>{t_col}}  "
              f"{'#AXps':>6}  {'min':>4}  {'max':>4}  {'avg':>5}  {'All time':>{t_col}}")
        print(f"  {'-'*pair_col}  {'-'*5}  {'-'*8}  {'-'*t_col}  "
              f"{'-'*6}  {'-'*4}  {'-'*4}  {'-'*5}  {'-'*t_col}")

        for pair_path in pairs:
            pair_name = os.path.basename(pair_path)
            with open(pair_path) as f:
                pair_content = f.read()

            program_raw = rf_content + "\n" + enc_content + "\n" + pair_content
            feat_indices = sorted(set(int(f) for f in re.findall(
                r"bin\(\s*\d+\s*,\s*(\d+)\s*,\s*\d+\s*\)\.", program_raw)))
            n_feats = len(feat_indices)
            program = add_debug_wrappers(program_raw, feat_indices)

            # --- first explanation: size + time ---
            mf, sf, muses_first, to_first = repeat_run(
                program, n_mus=1, repeats=rep, timeout=args.timeout_first)
            first_size = len(muses_first[0]) if (not to_first and muses_first) else None
            first_axp = muses_first[0] if (not to_first and muses_first) else None

            rec = {
                "dataset": dataset, "config": config, "pair": pair_name,
                "n_features": n_feats,
                "first": {
                    "size": first_size, "axp": first_axp,
                    "time_mean_s": mf, "time_std_s": sf, "timeout": to_first,
                },
                "all": None,
            }

            if to_first:
                print(f"  {pair_name:<{pair_col}}  {n_feats:>5}  "
                      f"{'—':>8}  {'TIMEOUT':>{t_col}}  {'—':>6}  {'—':>4}  {'—':>4}  {'—':>5}  {'—':>{t_col}}")
                records.append(rec)
                continue

            s_first = fmt_t(mf, sf, rep)

            if args.first_only:
                print(f"  {pair_name:<{pair_col}}  {n_feats:>5}  "
                      f"{first_size:>8}  {s_first:>{t_col}}  {'—':>6}  {'—':>4}  {'—':>4}  {'—':>5}  {'—':>{t_col}}")
                records.append(rec)
                continue

            # --- set of all explanations: count, sizes, time ---
            ma, sa, muses_all, to_all = repeat_run(
                program, n_mus=0, repeats=rep, timeout=timeout_all)
            n_axps = len(muses_all)
            mn, mx, av = size_stats(muses_all)
            s_all = fmt_t(ma, sa, rep)
            n_str = f">={n_axps}" if to_all else str(n_axps)

            rec["all"] = {
                "count": n_axps, "count_partial": to_all,
                "min_size": mn, "max_size": mx, "avg_size": av,
                "time_mean_s": ma, "time_std_s": sa, "timeout": to_all,
                "axps": muses_all,
            }
            records.append(rec)

            print(f"  {pair_name:<{pair_col}}  {n_feats:>5}  "
                  f"{first_size:>8}  {s_first:>{t_col}}  "
                  f"{n_str:>6}  {mn:>4}  {mx:>4}  {av:>5.1f}  {s_all:>{t_col}}")

    # ── Per-model summary ──
    print(f"\n{'='*92}")
    print("SUMMARY  (per model, averaged over its non-timed-out pairs)")
    print(f"{'='*92}")
    print(f"  {'Model':<34}  {'Pairs':>5}  {'Avg 1st sz':>10}  "
          f"{'Avg 1st t':>13}  {'Avg #AXps':>9}  {'Avg all t':>13}")
    print(f"  {'-'*34}  {'-'*5}  {'-'*10}  {'-'*13}  {'-'*9}  {'-'*13}")

    by_model = {}
    for r in records:
        by_model.setdefault((r["dataset"], r["config"]), []).append(r)

    for (dataset, config), rs in by_model.items():
        first_sizes = [r["first"]["size"] for r in rs if r["first"]["size"] is not None]
        first_times = [r["first"]["time_mean_s"] for r in rs if r["first"]["time_mean_s"] is not None]
        all_counts = [r["all"]["count"] for r in rs if r["all"] is not None]
        all_times = [r["all"]["time_mean_s"] for r in rs
                     if r["all"] is not None and r["all"]["time_mean_s"] is not None]
        avg_fs = f"{sum(first_sizes)/len(first_sizes):.1f}" if first_sizes else "—"
        avg_ft = fmt_t(sum(first_times)/len(first_times)) if first_times else "TIMEOUT/—"
        avg_ac = f"{sum(all_counts)/len(all_counts):.1f}" if all_counts else "—"
        avg_at = fmt_t(sum(all_times)/len(all_times)) if all_times else "—"
        print(f"  {dataset+'/'+config:<34}  {len(rs):>5}  "
              f"{avg_fs:>10}  {avg_ft:>13}  {avg_ac:>9}  {avg_at:>13}")

    # ── Structured output ──
    with open(json_path, "w") as jf:
        json.dump({
            "generated": ts,
            "params": {
                "models_dir": args.models_dir, "datasets": args.datasets,
                "pair_files": args.pair_files,
                "pairs": args.pairs, "repeats": rep, "first_only": args.first_only,
                "timeout_first": args.timeout_first, "timeout_all": timeout_all,
            },
            "results": records,
        }, jf, indent=2)

    builtins.print = _orig_print
    out_file.close()
    print(f"\nResults saved to:\n  {txt_path}\n  {json_path}")


if __name__ == "__main__":
    main()
