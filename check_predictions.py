"""
Check that clingo and the trained sklearn forest agree on every prediction.

Usage:
    python check_predictions.py <random_forest.lp> [more .lp files] [--pkl model.pkl]

Every bin combination is labelled twice:

  - with clingo: the forest facts are combined with the traversal/vote rules
    and a probe item 0 whose bins are free; enumerating all answer sets yields
    the max-vote classes of every combination (ties give several predictions);
  - with the sklearn model (random_forest.pkl, auto-detected next to the input
    files or given via --pkl): bins are converted to feature values via
    split_points.json and per-tree votes are aggregated with the same
    tie-aware semantics.

The two predictions are printed side by side for every combination, with a
final agreement summary. Exit code is 1 if any combination disagrees.

Files defining the explanation encoding (items 3/4 and the class-order
constraint) are excluded automatically, so the same file list used with
compute_axp_bruteforce.py can be passed here.
"""

import argparse
import os
import sys

from compute_axp_bruteforce import (
    TRAVERSAL_RULES, PklLabeler, class_str, column_widths, format_combo,
    parse_feature_info, parse_model_atoms, run_clingo,
)


def main():
    parser = argparse.ArgumentParser(
        description="Check clingo vs pkl prediction agreement on every bin combination."
    )
    parser.add_argument("files", nargs="+", help="ASP files (at least random_forest.lp)")
    parser.add_argument("--pkl", help="Path to random_forest.pkl (default: auto-detect "
                                      "next to the input files; split_points.json must sit beside it)")
    args = parser.parse_args()

    contents = []
    for path in args.files:
        with open(path) as f:
            contents.append(f.read())

    feat_info = parse_feature_info("\n".join(contents))

    # Label every combination with clingo via the free probe item 0
    # (exclude the explanation encoding, recognizable by its traversal rules)
    label_program = "\n".join(c for c in contents if "next_node" not in c) + TRAVERSAL_RULES
    sat, models = run_clingo(label_program, all_models=True)
    if not sat:
        raise RuntimeError("labeling program is UNSAT — check the input files")

    table = []
    for m in models:
        bins, _, pred, topvote = parse_model_atoms(m, (0,))
        # pred[0]: resolved class (vote tie -> highest); topvote[0]: tie set.
        tv = topvote[0] or [pred[0]]
        table.append((bins[0], pred[0], sorted(tv)))
    feats = sorted(table[0][0].keys())
    table.sort(key=lambda r: tuple(r[0][f] for f in feats))

    # Locate the pkl model and label the same combinations
    pkl_path = args.pkl
    if pkl_path is None:
        for path in args.files:
            cand = os.path.join(os.path.dirname(os.path.abspath(path)), "random_forest.pkl")
            if os.path.exists(cand):
                pkl_path = cand
                break
    if not pkl_path or not os.path.exists(pkl_path):
        sys.exit("random_forest.pkl not found: pass it with --pkl")
    sp_path = os.path.join(os.path.dirname(os.path.abspath(pkl_path)), "split_points.json")
    if not os.path.exists(sp_path):
        sys.exit(f"split_points.json not found next to {pkl_path}")

    labeler = PklLabeler(pkl_path, sp_path)
    pkl_labels = labeler.labels([bins for bins, _, _ in table])

    print(f"Comparing clingo and {pkl_path}")
    print(f"{len(table)} bin combinations:\n")

    widths = column_widths(table, feats, feat_info)
    cls_w = max(len(class_str(res, tv)) for _, res, tv in table)
    disagreements = 0
    for (bins, res, tv), (p_res, p_tv) in zip(table, pkl_labels):
        combo = format_combo(bins, feats, feat_info, widths)
        agree = (res, tv) == (p_res, sorted(p_tv))
        disagreements += not agree
        verdict = "ok" if agree else "!! MISMATCH"
        print(f"  {combo}  clingo: {class_str(res, tv):<{cls_w}}  "
              f"pkl: {class_str(p_res, sorted(p_tv)):<{cls_w}}  {verdict}")

    if disagreements:
        print(f"\n{disagreements} of {len(table)} combinations DISAGREE.")
        sys.exit(1)
    print(f"\nclingo and pkl agree on all {len(table)} combinations.")


if __name__ == "__main__":
    main()
