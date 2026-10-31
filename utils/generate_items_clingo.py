"""
Generate item pairs as ASP facts, classified by the *same* ASP encoding that
compute_mus.py uses.

The legacy utils/generate_items.py reconstructs a feature vector from bin
midpoints and classifies it with sklearn. That can disagree with the ASP's
prediction/2 (built from bin-index traversal), and when it does, a pair may end
up with ASP-pred(1) > ASP-pred(2) — in which case NO MUS exists. This generator
sidesteps the mismatch by letting clingo both choose the bins and compute the
prediction, then keeping only pairs with prediction(1) <= prediction(2). With
that invariant, selecting all features makes the MUS query UNSAT, so a MUS is
guaranteed to exist for every generated pair.

For each pair we run one randomized clingo solve over:
    random_forest.lp          (bin-domain choice rules + tree structure)
    <traversal + voting rules> (lifted from encoding.lp)
    item(1). item(2).
    :- prediction(1,C1), prediction(2,C2), C1 > C2.   % enforce pred(1) <= pred(2)
Randomization (random sign selection + per-pair seed) yields varied items.

Usage:
    python utils/generate_items_clingo.py <model_dir_or_rf.lp> [--n_pairs N] [--seed S]
    python utils/generate_items_clingo.py model/breast+cancer+wisconsin+diagnostic --n_pairs 100
"""

import argparse
import json
import os
import re

import clingo

# Traversal + soft/majority voting rules, copied verbatim from encoding.lp so
# that clingo computes prediction/2 exactly as compute_mus.py will.
REASONING_RULES = """
le(I,F,B) :- bin(I,F,B).
le(I,F,B+1) :- le(I,F,B), bin_max(F,K), B < K.
next_node(I,T,0) :- item(I), tree(T).
next_node(I,T,N2) :- next_node(I,T,N1), node(T,N1,F,B), le(I,F,B), left_node(T,N1,N2).
next_node(I,T,N2) :- next_node(I,T,N1), node(T,N1,F,B), not le(I,F,B), right_node(T,N1,N2).
class(I,T,C) :- next_node(I,T,N), leaf_class(T,N,C).
vote(I,C,V) :- item(I), class_idx(C), V = #count{T : class(I,T,C)}.
max_votes(I,M) :- item(I), M = #max{V : vote(I,_,V)}.
prediction(I,C) :- max_votes(I,M), C = #min{C2 : vote(I,C2,M)}.
"""


def resolve_paths(arg):
    """Accept either a model directory or a path to random_forest.lp."""
    if os.path.isdir(arg):
        model_dir = os.path.abspath(arg)
        rf_lp = os.path.join(model_dir, "random_forest.lp")
    else:
        rf_lp = os.path.abspath(arg)
        model_dir = os.path.dirname(rf_lp)
    if not os.path.exists(rf_lp):
        raise FileNotFoundError(f"random_forest.lp not found at {rf_lp}")
    return model_dir, rf_lp


def load_feature_names(model_dir, dataset_name=None):
    """Best-effort real feature names from the dataset config; fallback f0,f1,..."""
    dataset_name = dataset_name or os.path.basename(model_dir)
    repo_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    dataset_dir = os.path.join(repo_root, "data", dataset_name)
    config_path = os.path.join(dataset_dir, "config.json")
    if not os.path.exists(config_path):
        return None
    with open(config_path) as f:
        config = json.load(f)
    if not config.get("header_row"):
        return None
    with open(os.path.join(dataset_dir, config["csv_file"])) as f:
        header = f.readline().strip().split(config.get("separator", ","))
    feature_columns = sorted(
        set(range(len(header))) - set(config["ignore_columns"]) - {config["target_column"]}
    )
    return [header[i].strip() for i in feature_columns]


def load_split_points(model_dir):
    """For bin-interval comments; returns {feat_idx: sorted thresholds} or {}."""
    path = os.path.join(model_dir, "split_points.json")
    if not os.path.exists(path):
        return {}
    with open(path) as f:
        raw = json.load(f)
    return {int(k): sorted(float(t) for t in v) for k, v in raw.items()}


def bin_interval(split_points, feat_idx, b):
    pts = split_points.get(feat_idx)
    if not pts:
        return ""
    if b == 0:
        return f"<= {pts[0]:g}"
    if b >= len(pts):
        return f"> {pts[-1]:g}"
    return f"({pts[b - 1]:g}, {pts[b]:g}]"


def solve_pair(rf_program, seed):
    """One randomized solve; return (bins1, bins2, c1, c2) or None if UNSAT.

    bins_k maps feat_idx -> bin for item k; c1,c2 are predicted classes.
    """
    ctl = clingo.Control()
    # Randomize the search so successive seeds yield different models.
    ctl.configuration.solver.seed = seed
    ctl.configuration.solver.sign_def = "rnd"
    ctl.configuration.solve.models = 1

    ctl.add("base", [], rf_program)
    ctl.ground([("base", [])])

    answer = {}

    def on_model(m):
        answer["bins1"] = {}
        answer["bins2"] = {}
        answer["pred"] = {}
        for sym in m.symbols(shown=True):
            if sym.name == "bin" and len(sym.arguments) == 3:
                i, f, b = (a.number for a in sym.arguments)
                if i == 1:
                    answer["bins1"][f] = b
                elif i == 2:
                    answer["bins2"][f] = b
            elif sym.name == "prediction":
                i, c = (a.number for a in sym.arguments)
                answer["pred"][i] = c

    ctl.solve(on_model=on_model)
    if not answer:
        return None
    return answer["bins1"], answer["bins2"], answer["pred"].get(1), answer["pred"].get(2)


def bins_to_facts(item_id, bins, feature_names, split_points):
    lines = [f"item({item_id})."]
    for feat_idx in sorted(bins):
        b = bins[feat_idx]
        name = feature_names[feat_idx] if feature_names else f"f{feat_idx}"
        interval = bin_interval(split_points, feat_idx, b)
        fact = f"bin({item_id},{feat_idx},{b})."
        comment = f"% {name} {interval}".rstrip()
        lines.append(f"{fact:<18}{comment}")
    return lines


def class_name(model_dir, c, dataset_name=None):
    dataset_name = dataset_name or os.path.basename(model_dir)
    repo_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    config_path = os.path.join(repo_root, "data", dataset_name, "config.json")
    if not os.path.exists(config_path):
        return ""
    with open(config_path) as f:
        mapping = json.load(f).get("label_mapping", {})
    idx_to_name = {v: k for k, v in mapping.items()}
    return f" ({idx_to_name[c]})" if c in idx_to_name else ""


def main():
    parser = argparse.ArgumentParser(
        description="Generate item pairs classified by the ASP encoding (clingo), "
                    "guaranteeing prediction(1) <= prediction(2) so a MUS exists."
    )
    parser.add_argument("model", help="Model directory or path to random_forest.lp")
    parser.add_argument("--n_pairs", type=int, default=5, help="Number of pairs (default: 5)")
    parser.add_argument("--seed", type=int, default=42, help="Base random seed (default: 42)")
    parser.add_argument("--dataset", default=None, metavar="NAME",
                        help="Dataset name under data/ for config lookup. Defaults to "
                             "the model directory name; set this when the model lives "
                             "in a directory not named after the dataset.")
    args = parser.parse_args()

    model_dir, rf_lp = resolve_paths(args.model)
    feature_names = load_feature_names(model_dir, args.dataset)
    split_points = load_split_points(model_dir)

    with open(rf_lp) as f:
        rf_facts = f.read()

    # Build the generation program once (as a string); reused every solve.
    base_program = "\n".join([
        rf_facts,
        REASONING_RULES,
        "item(1). item(2).",
        ":- prediction(1,C1), prediction(2,C2), C1 > C2.",
        "#show bin/3.",
        "#show prediction/2.",
    ])

    pairs_dir = os.path.join(model_dir, "pairs")
    os.makedirs(pairs_dir, exist_ok=True)

    written = 0
    attempt = 0
    # Use a distinct seed per accepted pair; retry with fresh seeds on failure.
    while written < args.n_pairs:
        seed = args.seed + attempt
        attempt += 1
        result = solve_pair(base_program, seed)
        if result is None:
            continue
        bins1, bins2, c1, c2 = result
        if c1 is None or c2 is None or c1 > c2:
            # Should not happen given the constraint, but guard anyway.
            continue

        lines = [f"% class_1={c1}{class_name(model_dir, c1, args.dataset)}, "
                 f"class_2={c2}{class_name(model_dir, c2, args.dataset)}", ""]
        lines += bins_to_facts(1, bins1, feature_names, split_points)
        lines.append("")
        lines += bins_to_facts(2, bins2, feature_names, split_points)

        out_path = os.path.join(pairs_dir, f"pair_{written}.lp")
        with open(out_path, "w") as f:
            f.write("\n".join(lines) + "\n")
        print(f"Written: {out_path}  (class_1={c1}, class_2={c2})")
        written += 1

    print(f"\nGenerated {written} pair(s) in {pairs_dir}")


if __name__ == "__main__":
    main()
