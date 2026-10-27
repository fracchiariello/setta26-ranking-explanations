"""
Coarsen per-feature split points down to a target number of bins.

Reads split_points_original.json (the pristine thresholds extracted from the
model by discretization.py) and writes a reduced split_points.json in which
every feature has at most --bins bins, i.e. at most (--bins - 1) thresholds.

Selection is percentile-based: among the sorted distinct thresholds of a
feature, we keep those lying closest to evenly spaced percentile positions.
A feature that already has few enough thresholds is left untouched.

Each dropped threshold's tree-index list is merged into the nearest surviving
threshold, so no tree reference is lost (the JSON value stays the union of all
trees whose split snapped to that boundary).

Format (unchanged):  {feat_idx: {threshold: [tree_indices]}}

Usage:
    python utils/merge_split_points.py <model_dir> --bins N
    python utils/merge_split_points.py model/breast+cancer+wisconsin+diagnostic --bins 8
"""

import argparse
import json
import os
from bisect import bisect_left


def select_percentile_thresholds(thresholds, n_keep):
    """Return n_keep thresholds chosen at evenly spaced percentile positions.

    thresholds: sorted list of distinct float thresholds.
    n_keep:     how many to keep (>= 0). If >= len(thresholds), keep all.

    The kept thresholds are the values nearest to the percentile positions
    p_i = (i + 0.5) / n_keep  for i in 0..n_keep-1, mapped onto index space.
    Endpoints are naturally included because the first/last percentile buckets
    land on the extreme indices. Duplicates (when two percentiles map to the
    same index) are removed, so the result may be slightly smaller than n_keep.
    """
    n = len(thresholds)
    if n_keep <= 0:
        return []
    if n_keep >= n:
        return list(thresholds)

    kept_indices = []
    for i in range(n_keep):
        p = (i + 0.5) / n_keep
        idx = int(round(p * (n - 1)))
        kept_indices.append(idx)
    # Deduplicate while preserving order.
    seen = set()
    unique = []
    for idx in kept_indices:
        if idx not in seen:
            seen.add(idx)
            unique.append(idx)
    return [thresholds[idx] for idx in unique]


def nearest(value, sorted_values):
    """Return the element of sorted_values numerically closest to value."""
    pos = bisect_left(sorted_values, value)
    if pos == 0:
        return sorted_values[0]
    if pos == len(sorted_values):
        return sorted_values[-1]
    before = sorted_values[pos - 1]
    after = sorted_values[pos]
    return before if (value - before) <= (after - value) else after


def _collapse_to_kept(threshold_map, kept_sorted):
    """Snap every original threshold to the nearest kept boundary, unioning the
    tree lists so no tree reference is lost. Returns {threshold: sorted([trees])}."""
    merged = {t: set() for t in kept_sorted}
    for orig_key in threshold_map:
        target = nearest(float(orig_key), kept_sorted)
        merged[target].update(threshold_map[orig_key])
    return {t: sorted(trees) for t, trees in sorted(merged.items())}


def merge_feature(threshold_map, n_bins):
    """Coarsen one feature's {threshold: [trees]} map down to n_bins bins by
    percentile selection.

    Returns a new {threshold: sorted([trees])} map with at most n_bins - 1
    thresholds. Dropped thresholds' tree lists are unioned into the nearest
    surviving threshold.
    """
    thresholds = sorted(float(t) for t in threshold_map)
    # Keep at least one threshold for any feature that had any, so a feature the
    # forest splits on never disappears from the ASP. This keeps the feature
    # count consistent across all --bins values (a feature with 0 thresholds has
    # no bin/3 domain and would be dropped by model2ASP).
    n_keep = min(len(thresholds), max(1, n_bins - 1)) if thresholds else 0
    kept = select_percentile_thresholds(thresholds, n_keep)

    if len(kept) >= len(thresholds):
        # Nothing dropped; return as-is (normalised to float keys).
        return {t: sorted(threshold_map[k])
                for t, k in zip(thresholds, sorted(threshold_map, key=float))}

    return _collapse_to_kept(threshold_map, sorted(kept))


def merge_split_points(model_dir, n_bins, strategy="percentile"):
    """Coarsen split points to <= n_bins bins per feature, write split_points.json.

    The SOURCE the bins cap reads depends on `strategy`:
      "percentile"    — read split_points_original.json (full resolution).
      "agglomerative" — read split_points_agglo.json, the impurity-guided
                        pre-reduction produced earlier by
                        utils/agglomerative_split_points.py (which must have run
                        first). The bins cap (percentile selection) is then
                        applied on top of those survivors.

    Returns the merged dict {feat_key: {threshold_str: [trees]}}. Raises
    FileNotFoundError if the chosen source is missing and ValueError if n_bins < 1.
    """
    if n_bins < 1:
        raise ValueError("n_bins must be >= 1")

    if os.path.isfile(model_dir):
        model_dir = os.path.dirname(os.path.abspath(model_dir))

    output_path = os.path.join(model_dir, "split_points.json")
    if strategy == "agglomerative":
        source_path = os.path.join(model_dir, "split_points_agglo.json")
        source_label = "split_points_agglo.json"
    else:
        source_path = os.path.join(model_dir, "split_points_original.json")
        source_label = "split_points_original.json"

    if not os.path.exists(source_path):
        hint = ("Run utils/agglomerative_split_points.py first."
                if strategy == "agglomerative"
                else "Run discretization first to create it.")
        raise FileNotFoundError(f"{source_path} not found. {hint}")

    with open(source_path) as f:
        raw = json.load(f)

    merged = {}
    print(f"Merging split points to at most {n_bins} bins per feature "
          f"(strategy: {strategy}, source: {source_label}):")
    for feat_key in sorted(raw, key=int):
        feat_map = raw[feat_key]
        before = len(feat_map)
        new_map = merge_feature(feat_map, n_bins)
        after = len(new_map)
        merged[feat_key] = {str(t): trees for t, trees in new_map.items()}
        print(f"  f{feat_key}: {before} -> {after} thresholds "
              f"({before + 1} -> {after + 1} bins)")

    with open(output_path, "w") as f:
        json.dump(merged, f, indent=2)

    print(f"\nWrote coarsened split points to: {output_path}")
    return merged


def main():
    parser = argparse.ArgumentParser(
        description="Coarsen split_points_original.json to a target number of "
                    "bins per feature, writing split_points.json."
    )
    parser.add_argument("model_dir",
                        help="Model directory containing split_points_original.json")
    parser.add_argument("--bins", type=int, required=True,
                        help="Target maximum number of bins per feature (>= 1). "
                             "A feature ends up with at most --bins - 1 thresholds.")
    parser.add_argument("--strategy", choices=["percentile", "agglomerative"],
                        default="percentile",
                        help="Threshold-reduction strategy (default: percentile). "
                             "agglomerative clusters nearby thresholds first, then "
                             "percentile-trims to the cap.")
    args = parser.parse_args()

    try:
        merge_split_points(args.model_dir, args.bins, args.strategy)
    except (ValueError, FileNotFoundError) as e:
        parser.error(str(e))


if __name__ == "__main__":
    main()
