"""
Merge the theoretically empty bins: those no input of the forest can reach.

The forest's thresholds are real numbers, so on a feature whose values are all
integers (counts, ages, label-encoded categories) two thresholds can enclose no
integer: sklearn splits at the midpoint of the values present in a node, so age
can get both 47.0 (between 46 and 48) and 47.5 (between 47 and 48), and the bin
(47, 47.5] contains no age. For an integer x, x <= t iff x <= floor(t) + 0.5, so
every threshold t of such a feature is moved to floor(t) + 0.5, and thresholds
that coincide are merged (their tree-index lists united). Every bin of the
result contains an integer, and a test x <= t of the forest is the test
x <= floor(t) + 0.5 on it.

The midpoint of two consecutive moved thresholds, the representative value of
a bin in generate_items.py and benchmark_bruteforce.py, lies in
[m1 + 1, m2] for thresholds m1 + 0.5 < m2 + 0.5, so it is on the same side of
every original threshold as the integers of its bin (and so are t1 - 1 and
tk + 1 for the first and last bin).

A feature is integer-valued when every value it takes in the dataset is an
integer.

The other features are real-valued, but the forest compares 32-bit floats:
sklearn casts every input to float32 before testing x <= t, while its
thresholds are float64 midpoints of float32 values. Two thresholds from
different nodes can then enclose no float32 value, e.g. 64.0999985 (the
float32 nearest to 64.1) and 64.1000004 (a midpoint just above it): no input
lands in that bin. For a float32 x, x <= t iff x <= snap32(t), the largest
float32 not above t, so every threshold of a real-valued feature is moved to
snap32(t), and thresholds that coincide are merged the same way.

bin_value() picks the representative value of a bin, used to turn bins into
inputs by generate_items.py, compute_axp_bruteforce.py and
benchmark_bruteforce.py: the midpoint of the bin, cast to float32 as the forest
will, or the bin's upper threshold (itself a float32 value) when the midpoint
rounds out of a bin only one float32 wide.

Format of split_points.json (unchanged): {feat_idx: {threshold: [tree_indices]}}

Usage:
    python utils/empty_bins.py <model_dir> <dataset_dir>
"""

import argparse
import json
import math
import os

import numpy as np
import pandas as pd

from feature_encoding import apply_feature_encoding


def integer_features(dataset_dir):
    """Indices (in the forest's feature order) of the features whose values in
    the dataset are all integers."""
    with open(os.path.join(dataset_dir, "config.json")) as f:
        config = json.load(f)
    df = pd.read_csv(os.path.join(dataset_dir, config["csv_file"]),
                     sep=config["separator"],
                     header=0 if config["header_row"] else None)
    apply_feature_encoding(df, config)
    columns = sorted(set(range(df.shape[1])) - set(config["ignore_columns"])
                     - {config["target_column"]})
    X = df.iloc[:, columns].to_numpy(dtype=float)
    return {i for i in range(X.shape[1])
            if np.isfinite(X[:, i]).all() and (X[:, i] == np.round(X[:, i])).all()}


def snap(threshold):
    """The threshold an integer-valued feature's test x <= threshold is equal to."""
    return math.floor(threshold) + 0.5


def snap32(threshold):
    """The largest float32 not above threshold: on float32 inputs, the test
    x <= threshold of a real-valued feature is x <= snap32(threshold)."""
    x = np.float32(threshold)
    if float(x) > threshold:
        x = np.nextafter(x, np.float32(-np.inf))
    return float(x)


def bin_value(ts, b):
    """A value of bin b of a feature with sorted thresholds ts (after merging)
    that stays in the bin once cast to float32, as the forest's input is."""
    if b == 0:
        v = float(np.float32(ts[0] - 1.0))
        return v if v <= ts[0] else ts[0]
    if b == len(ts):
        v = np.float32(ts[-1] + 1.0)
        if float(v) <= ts[-1]:
            v = np.nextafter(np.float32(ts[-1]), np.float32(np.inf))
        return float(v)
    low, high = ts[b - 1], ts[b]
    v = float(np.float32((low + high) / 2.0))
    return v if low < v <= high else high


def merge_empty_bins(model_dir, dataset_dir):
    """Rewrite model_dir/split_points.json with the thresholds of integer-valued
    features moved to floor(t) + 0.5, those of the others to snap32(t), and
    the thresholds that coincide merged. Returns the set of integer-valued
    feature indices."""
    path = os.path.join(model_dir, "split_points.json")
    with open(path) as f:
        raw = json.load(f)
    int_feats = integer_features(dataset_dir)

    merged = {}
    for feat, threshold_map in raw.items():
        integer = int(feat) in int_feats
        move = snap if integer else snap32
        snapped = {}
        for t, trees in threshold_map.items():
            snapped.setdefault(move(float(t)), set()).update(trees)
        merged[feat] = {str(t): sorted(trees) for t, trees in sorted(snapped.items())}
        if len(snapped) < len(threshold_map):
            print(f"  f{feat}: {len(threshold_map)} -> {len(snapped)} thresholds "
                  f"({'integer' if integer else 'float32'})")

    with open(path, "w") as f:
        json.dump(merged, f, indent=2)
    return int_feats


def main():
    parser = argparse.ArgumentParser(description=__doc__.strip().splitlines()[0])
    parser.add_argument("model_dir")
    parser.add_argument("dataset_dir")
    args = parser.parse_args()
    merge_empty_bins(args.model_dir, args.dataset_dir)


if __name__ == "__main__":
    main()
