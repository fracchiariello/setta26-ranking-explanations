"""
Impurity-guided agglomerative reduction of per-feature split points.

This is a SUPERVISED, bottom-up (agglomerative) merge that runs BEFORE the
--bins coarsening. For each feature, the original thresholds partition its
training values into bins; we greedily merge the adjacent pair of bins whose
merge causes the smallest *weighted impurity increase* of the target label
distribution, stopping when the cheapest remaining merge would exceed a
normalized (MDLP-style) tolerance.

Because impurity is computed over how the target y distributes across each bin,
this needs the training data and labels. The train split is recreated exactly
as learn_random_forest.py does (same test_size / random_state), and only the
training rows are used.

Input:  split_points_original.json  ({feat_idx: {threshold: [tree_indices]}})
Output: split_points_agglo.json     (same format; <= original thresholds)
        Each dropped threshold's tree list is unioned into the nearest survivor.

Usage:
    python utils/agglomerative_split_points.py <model_dir> [--tol T]
        [--test-size 0.2] [--random-state 42] [--criterion gini|entropy]
"""

import argparse
import json
import math
import os

import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split

from feature_encoding import apply_feature_encoding


def _impurity(counts, criterion):
    """Impurity of a class-count vector (gini or entropy). 0 for empty."""
    total = counts.sum()
    if total == 0:
        return 0.0
    p = counts / total
    p = p[p > 0]
    if criterion == "entropy":
        return float(-(p * np.log2(p)).sum())
    return float(1.0 - (p * p).sum())  # gini


def _weighted_impurity(bin_counts, criterion):
    """Sum over bins of (n_bin / N) * impurity(bin)."""
    total = sum(c.sum() for c in bin_counts)
    if total == 0:
        return 0.0
    return sum((c.sum() / total) * _impurity(c, criterion) for c in bin_counts)


def reduce_feature(values, labels, thresholds, n_classes, tol, criterion):
    """Greedily merge adjacent bins of one feature; return kept thresholds.

    values     : 1-D array of the feature's training values.
    labels     : integer class labels aligned with values.
    thresholds : sorted list of the feature's original thresholds.
    tol        : stop when the cheapest adjacent merge's normalized weighted
                 impurity increase exceeds tol (relative to the feature's
                 current total weighted impurity; scale-free across features).
    Returns the surviving (subset) thresholds, sorted.
    """
    if len(thresholds) <= 1:
        return list(thresholds)

    # Assign each training row to a bin 0..len(thresholds) via the thresholds.
    # bin j holds values in (t[j-1], t[j]]; bin 0 is <= t0; last bin is > t[-1].
    edges = np.array(sorted(thresholds), dtype=float)
    bin_idx = np.searchsorted(edges, values, side="left")

    # Per-bin class-count vectors; boundaries[i] is the threshold *between*
    # bin i and bin i+1 (so there are len(edges) boundaries for len(edges)+1 bins).
    n_bins = len(edges) + 1
    bins = [np.zeros(n_classes, dtype=float) for _ in range(n_bins)]
    for b, y in zip(bin_idx, labels):
        bins[b][y] += 1.0
    boundaries = list(edges)  # boundary[i] separates bins[i] and bins[i+1]

    def merge_cost(i):
        """Weighted-impurity increase (normalized) of merging bins i and i+1."""
        before = ((bins[i].sum() * _impurity(bins[i], criterion)
                   + bins[i + 1].sum() * _impurity(bins[i + 1], criterion)))
        merged = bins[i] + bins[i + 1]
        after = merged.sum() * _impurity(merged, criterion)
        n = merged.sum()
        if n == 0:
            return 0.0
        # Normalize by the merged-bin weight so the tolerance is scale-free.
        return (after - before) / n

    # Greedy bottom-up merges until the cheapest exceeds tol. Never drop the
    # last boundary: a feature the forest split on must keep >= 1 threshold, or
    # its tree tests would have no bin boundary (and threshold_to_bin breaks).
    min_boundaries = 1
    while len(boundaries) > min_boundaries:
        costs = [merge_cost(i) for i in range(len(bins) - 1)]
        i = int(np.argmin(costs))
        if costs[i] > tol:
            break
        bins[i] = bins[i] + bins[i + 1]
        del bins[i + 1]
        del boundaries[i]  # removing the boundary merges the two bins

    return sorted(boundaries)


def _load_training_data(model_dir, test_size, random_state):
    """Recreate the training split as learn_random_forest.py does.

    Returns (X_train, y_train, feature_columns, n_classes).
    """
    dataset_name = os.path.basename(os.path.abspath(model_dir))
    repo_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    dataset_dir = os.path.join(repo_root, "data", dataset_name)
    with open(os.path.join(dataset_dir, "config.json")) as f:
        config = json.load(f)

    df = pd.read_csv(os.path.join(dataset_dir, config["csv_file"]),
                     sep=config["separator"],
                     header=0 if config["header_row"] else None)
    # Apply the same categorical encoding learn_random_forest.py uses, so X is
    # numeric and matches the trained model (datasets without string features
    # omit feature_encoding and are unaffected).
    apply_feature_encoding(df, config)
    all_cols = set(range(df.shape[1]))
    feature_columns = sorted(all_cols - set(config["ignore_columns"])
                             - {config["target_column"]})
    X = df.iloc[:, feature_columns].values
    label_mapping = config["label_mapping"]
    y = np.array([label_mapping[str(v)] for v in df.iloc[:, config["target_column"]].values])
    n_classes = len(label_mapping)

    X_train, _, y_train, _ = train_test_split(
        X, y, test_size=test_size, random_state=random_state)
    return X_train, y_train, feature_columns, n_classes


def agglomerative_split_points(model_dir, tol=0.0, test_size=0.2,
                               random_state=42, criterion="gini",
                               dataset=None):
    """Write split_points_agglo.json (impurity-guided merge of the originals).

    Returns the reduced dict {feat_key: {threshold_str: [trees]}}.
    """
    if os.path.isfile(model_dir):
        model_dir = os.path.dirname(os.path.abspath(model_dir))
    if dataset is not None:
        # Resolve data/config from `dataset` rather than the dir name.
        lookup_dir = os.path.join(
            os.path.dirname(os.path.dirname(os.path.abspath(__file__))),
            "experiments", dataset)
    else:
        lookup_dir = model_dir

    original_path = os.path.join(model_dir, "split_points_original.json")
    output_path = os.path.join(model_dir, "split_points_agglo.json")
    if not os.path.exists(original_path):
        raise FileNotFoundError(
            f"{original_path} not found. Run discretization first to create it.")

    with open(original_path) as f:
        raw = json.load(f)

    X_train, y_train, feature_columns, n_classes = _load_training_data(
        lookup_dir, test_size, random_state)

    reduced = {}
    print(f"Impurity-guided agglomerative merge "
          f"(criterion={criterion}, tol={tol}):")
    for feat_key in sorted(raw, key=int):
        feat_map = raw[feat_key]
        f = int(feat_key)
        # Keys in split_points_original.json are 0-based sklearn feature indices,
        # which align directly with the columns of X_train (already feature-
        # selected). So column index == feature index.
        values = X_train[:, f].astype(float)
        thresholds = sorted(float(t) for t in feat_map)

        kept = reduce_feature(values, y_train, thresholds, n_classes, tol, criterion)
        kept_set = sorted(kept)

        # Snap every original threshold to the nearest survivor; union trees.
        if kept_set:
            merged = {t: set() for t in kept_set}
            for orig_key in feat_map:
                tval = float(orig_key)
                nearest = min(kept_set, key=lambda k: abs(k - tval))
                merged[nearest].update(feat_map[orig_key])
            reduced[feat_key] = {str(t): sorted(v) for t, v in sorted(merged.items())}
        else:
            reduced[feat_key] = {}
        print(f"  f{feat_key}: {len(feat_map)} -> {len(reduced[feat_key])} thresholds")

    with open(output_path, "w") as f:
        json.dump(reduced, f, indent=2)
    print(f"\nWrote agglomerative split points to: {output_path}")
    return reduced


def main():
    parser = argparse.ArgumentParser(
        description="Impurity-guided agglomerative reduction of split points "
                    "(runs before the --bins coarsening).")
    parser.add_argument("model_dir",
                        help="Model dir with split_points_original.json")
    parser.add_argument("--tol", type=float, default=0.0,
                        help="Max normalized weighted-impurity increase per merge "
                             "(default: 0.0 = merge only zero-cost pairs)")
    parser.add_argument("--test-size", type=float, default=0.2,
                        help="Train/test split fraction (match training; default 0.2)")
    parser.add_argument("--random-state", type=int, default=42,
                        help="Split seed (match training; default 42)")
    parser.add_argument("--criterion", choices=["gini", "entropy"], default="gini",
                        help="Impurity criterion (default: gini)")
    parser.add_argument("--dataset", default=None,
                        help="Dataset name for data/config lookup (default: dir name)")
    args = parser.parse_args()

    try:
        agglomerative_split_points(args.model_dir, args.tol, args.test_size,
                                   args.random_state, args.criterion, args.dataset)
    except (ValueError, FileNotFoundError) as e:
        parser.error(str(e))


if __name__ == "__main__":
    main()
