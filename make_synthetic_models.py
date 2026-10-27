"""
Generate synthetic random forests with a controlled bin space and relevance.

Each model is trained on N items with n integer features uniform in {0..k-1},
so every feature has at most k-1 split points (k bins) and the bin space has at
most k^n combinations. The ordinal class (low < medium < high) depends only on
the first r features: score = x_0 + ... + x_{r-1} + Gaussian noise, cut at its
tertiles. The remaining n - r features are noise, so r steers how many features
an explanation needs.

Every model then goes through the same pipeline as the real datasets:
model2ASP.py (which runs utils/discretization.py) and utils/generate_items.py.
Layout:
    <out>/data/<name>/config.json          (read by model2ASP.py via --dataset)
    <out>/models/<name>/t<T>_d<D>/         random_forest.pkl/.lp, split_points.json, pairs/

Model names are n<n>_r<r>_k<k>.

Usage:
    python make_synthetic_models.py --out DIR --n 8 10 12 --r 4 [--k 4] [--trees 20] [--depth 5]
    python make_synthetic_models.py --out DIR --n 14 --r 2 4 7 10 14
"""

import argparse
import json
import os
import subprocess
import sys

import joblib
import numpy as np
from sklearn.ensemble import RandomForestClassifier

BASE = os.path.dirname(os.path.abspath(__file__))
LABELS = {"low": 0, "medium": 1, "high": 2}


def make_data(n, r, k, n_items, rng):
    X = rng.integers(0, k, size=(n_items, n))
    score = X[:, :r].sum(axis=1) + rng.normal(0.0, 1.0, size=n_items)
    y = np.digitize(score, np.quantile(score, [1 / 3, 2 / 3]))
    return X, y


def make_model(out, n, r, k, trees, depth, n_items, n_pairs, seed):
    name = f"n{n}_r{r}_k{k}"
    data_dir = os.path.join(out, "data", name)
    model_dir = os.path.join(out, "models", name, f"t{trees}_d{depth}")
    os.makedirs(data_dir, exist_ok=True)
    os.makedirs(model_dir, exist_ok=True)
    with open(os.path.join(data_dir, "config.json"), "w") as f:
        json.dump({"csv_file": None, "separator": ",", "header_row": False,
                   "target_column": n, "ignore_columns": [], "label_mapping": LABELS}, f, indent=2)

    X, y = make_data(n, r, k, n_items, np.random.default_rng(seed))
    forest = RandomForestClassifier(n_estimators=trees, max_depth=depth, random_state=seed)
    forest.fit(X, y)
    model_path = os.path.join(model_dir, "random_forest.pkl")
    joblib.dump(forest, model_path)

    quiet = {"stdout": subprocess.DEVNULL, "check": True}
    subprocess.run([sys.executable, os.path.join(BASE, "model2ASP.py"), model_path,
                    "--dataset", os.path.abspath(data_dir)], **quiet)
    subprocess.run([sys.executable, os.path.join(BASE, "utils", "generate_items.py"), model_path,
                    "--n_pairs", str(n_pairs), "--seed", str(seed)], **quiet)

    with open(os.path.join(model_dir, "split_points.json")) as f:
        bins = [len(v) + 1 for v in json.load(f).values()]
    print(f"{name}/t{trees}_d{depth}: {len(bins)} features used, "
          f"{int(np.prod(bins, dtype=float)):,} bin combinations, "
          f"train accuracy {forest.score(X, y):.3f}")


def main():
    parser = argparse.ArgumentParser(
        description="Generate synthetic random forests for controlled benchmarks.",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument("--out", required=True, help="Output directory")
    parser.add_argument("--n", type=int, nargs="+", required=True, help="Numbers of features")
    parser.add_argument("--r", type=int, nargs="+", required=True,
                        help="Numbers of relevant features (r > n is skipped)")
    parser.add_argument("--k", type=int, default=4, help="Values per feature")
    parser.add_argument("--trees", type=int, default=20)
    parser.add_argument("--depth", type=int, default=5)
    parser.add_argument("--items", type=int, default=5000, help="Training items")
    parser.add_argument("--pairs", type=int, default=10, help="Pairs per model")
    parser.add_argument("--seed", type=int, default=42)
    args = parser.parse_args()

    for n in args.n:
        for r in args.r:
            if r <= n:
                make_model(args.out, n, r, args.k, args.trees, args.depth,
                           args.items, args.pairs, args.seed)


if __name__ == "__main__":
    main()
