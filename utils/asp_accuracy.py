"""
Train/test accuracy of the coarsened ASP model.

After --bins coarsening, each feature value is discretized into a bin using the
coarsened split_points.json. The ASP encoding's prediction(I,C) is a HARD
majority vote (ties broken to the lowest class index) over the per-tree leaf
predictions, evaluated on the binned input. This module measures the accuracy of
that coarsened-ASP prediction on the train and test sets, so you can see how much
accuracy the discretization costs versus the original forest.

A row is scored exactly as the ASP sees it: bin each feature with the coarsened
thresholds, reconstruct a representative value per bin (midpoint convention, same
as utils/generate_items.py / PklLabeler), then take the per-tree hard vote.

For reference it also reports the SOFT-vote accuracy (sklearn forest.predict on
the same binned-and-reconstructed input), since that's the forest's own decision
rule — the gap between hard and soft is the cost of the encoding's vote
semantics, separate from the cost of binning.

Usage:
    python utils/asp_accuracy.py <model_dir> [--test-size 0.2] [--random-state 42]
"""

import argparse
import json
import os

import numpy as np
import pandas as pd
import joblib
from sklearn.model_selection import train_test_split

from feature_encoding import apply_feature_encoding


def _load_split(dataset_dir, test_size, random_state):
    """Recreate the exact train/test split learn_random_forest.py uses."""
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
    X = df.iloc[:, feature_columns].values.astype(float)
    label_mapping = config["label_mapping"]
    y = np.array([label_mapping[str(v)] for v in df.iloc[:, config["target_column"]].values])
    return train_test_split(X, y, test_size=test_size, random_state=random_state)


def _binned_vector(X, split_points, n_features):
    """Map each row of X to the ASP's reconstructed bin-midpoint values.

    For feature f with sorted thresholds ts: value v falls in bin
    b = #{t in ts : t < v} (0..len(ts)); the reconstructed representative is
    ts[0]-1 for bin 0, ts[-1]+1 for the last bin, else the midpoint of the
    bracketing thresholds. Features absent from split_points are left as-is.
    """
    Xr = np.array(X, dtype=float, copy=True)
    for f in range(n_features):
        ts = split_points.get(f)
        if not ts:
            continue
        ts = np.array(ts, dtype=float)
        col = X[:, f]
        bins = np.searchsorted(ts, col, side="left")  # 0..len(ts)
        rep = np.empty_like(col)
        for i, b in enumerate(bins):
            if b == 0:
                rep[i] = ts[0] - 1.0
            elif b == len(ts):
                rep[i] = ts[-1] + 1.0
            else:
                rep[i] = (ts[b - 1] + ts[b]) / 2.0
        Xr[:, f] = rep
    return Xr


def _hard_vote(forest, X, classes):
    """Hard majority vote (ties -> lowest class index), matching prediction(I,C)."""
    n_classes = len(classes)
    tree_preds = np.array([est.predict(X).astype(int) for est in forest.estimators_])
    preds = np.empty(X.shape[0], dtype=int)
    for j in range(X.shape[0]):
        counts = np.bincount(tree_preds[:, j], minlength=n_classes)
        mx = counts.max()
        preds[j] = min(c for c in range(n_classes) if counts[c] == mx)
    return preds


def asp_accuracy(model_dir, test_size=0.2, random_state=42, dataset=None):
    """Return a dict of train/test accuracies for the coarsened ASP model.

    Keys: hard_train, hard_test (the ASP's hard-vote accuracy on binned input)
    and soft_train, soft_test (sklearn forest.predict on the same binned input).
    """
    return _accuracy_for(model_dir, "split_points.json", test_size, random_state, dataset)


def _accuracy_for(model_dir, split_points_file, test_size, random_state, dataset):
    """Train/test hard- and soft-vote accuracy using `split_points_file` for the
    binning. Returns dict with hard_train/hard_test/soft_train/soft_test."""
    if os.path.isfile(model_dir):
        model_dir = os.path.dirname(os.path.abspath(model_dir))
    name = dataset or os.path.basename(os.path.abspath(model_dir))
    repo_root = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
    dataset_dir = os.path.join(repo_root, "data", name)

    forest = joblib.load(os.path.join(model_dir, "random_forest.pkl"))
    with open(os.path.join(model_dir, split_points_file)) as f:
        raw = json.load(f)
    split_points = {int(k): sorted(float(t) for t in v) for k, v in raw.items()}
    classes = list(forest.classes_)
    n_features = forest.n_features_in_

    X_train, X_test, y_train, y_test = _load_split(dataset_dir, test_size, random_state)
    Xtr = _binned_vector(X_train, split_points, n_features)
    Xte = _binned_vector(X_test, split_points, n_features)

    return {
        "hard_train": float((_hard_vote(forest, Xtr, classes) == y_train).mean()),
        "hard_test": float((_hard_vote(forest, Xte, classes) == y_test).mean()),
        "soft_train": float((forest.predict(Xtr).astype(int) == y_train).mean()),
        "soft_test": float((forest.predict(Xte).astype(int) == y_test).mean()),
    }


def coarsened_accuracy(model_dir, test_size=0.2, random_state=42, dataset=None):
    """Accuracy of the ENCODING (hard vote) at the AGGLOMERATIVE thresholds.

    Uses split_points_agglo.json — the impurity-guided merge produced by
    utils/agglomerative_split_points.py, BEFORE the --bins cap — with the same
    hard majority vote the ASP encoding does. Depends only on the model and the
    agglomerative tolerance (not on --bins), so it's a MODEL property. Read the
    hard_* keys; the encoding has no soft-vote analogue.
    """
    return _accuracy_for(model_dir, "split_points_agglo.json",
                         test_size, random_state, dataset)


def main():
    parser = argparse.ArgumentParser(
        description="Train/test accuracy of the coarsened ASP model "
                    "(hard-vote, matching prediction(I,C); soft-vote for reference).")
    parser.add_argument("model_dir", help="Config dir with random_forest.pkl + split_points.json")
    parser.add_argument("--test-size", type=float, default=0.2)
    parser.add_argument("--random-state", type=int, default=42)
    parser.add_argument("--dataset", default=None,
                        help="Dataset name for data/ lookup (default: dir name)")
    args = parser.parse_args()

    r = asp_accuracy(args.model_dir, args.test_size, args.random_state, args.dataset)
    print(f"ASP (hard vote)  train={r['hard_train']:.4f}  test={r['hard_test']:.4f}")
    print(f"forest (soft)    train={r['soft_train']:.4f}  test={r['soft_test']:.4f}")


if __name__ == "__main__":
    main()
