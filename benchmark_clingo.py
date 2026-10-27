"""
Benchmark: model2asp (bin-based) vs feast-main (node-truth) encoding for clingo prediction query.

Generates a random decision tree of configurable size, encodes it both ways,
then times clingo on N random instances and reports statistics.
"""

import argparse
import subprocess
import tempfile
import time
import re
import os
import numpy as np
from sklearn.datasets import make_classification
from sklearn.tree import DecisionTreeClassifier

CLINGO_TIMEOUT = 30  # seconds per call

# ────────────────────────────────────────────────────────────────────────────
# ASP encoding for prediction: feast-main style (node-truth)
# ────────────────────────────────────────────────────────────────────────────
FEAST_PREDICT_LP = """\
next_node(N2) :- node(0,B,F), left_node(0,N2),  B=1.
next_node(N2) :- node(0,B,F), right_node(0,N2), B=0.
next_node(N2) :- next_node(N1), node(N1,B,F), left_node(N1,N2),  B=1.
next_node(N2) :- next_node(N1), node(N1,B,F), right_node(N1,N2), B=0.
prediction(C) :- next_node(N), leaf_node(N,C).
#show prediction/1.
"""


def feast_instance_facts(dt, x, feature_names):
    """Build feast-style ASP facts for instance x in decision tree dt."""
    td = dt.tree_
    n_nodes = td.node_count
    children_left = td.children_left
    children_right = td.children_right
    feature = td.feature
    threshold = td.threshold
    values = td.value

    # Collect unique (feature, threshold) pairs as condition indices
    cond_set = {}
    cid = 0
    for i in range(n_nodes):
        if children_left[i] != children_right[i]:
            key = (feature[i], threshold[i])
            if key not in cond_set:
                cond_set[key] = cid
                cid += 1

    lines = []
    for i in range(n_nodes):
        if children_left[i] != children_right[i]:
            left_child = children_left[i]
            right_child = children_right[i]
            lines.append(f"left_node({i},{left_child}).")
            lines.append(f"right_node({i},{right_child}).")
            cond_idx = cond_set[(feature[i], threshold[i])]
            sat = 1 if x[feature[i]] <= threshold[i] else 0
            lines.append(f"node({i},{sat},{cond_idx}).")
        else:
            dist = values[i][0]
            cls = int(dist.argmax())
            lines.append(f"leaf_node({i},{cls}).")

    return "\n".join(lines)


# ────────────────────────────────────────────────────────────────────────────
# ASP encoding for prediction: model2asp style (bin-based)
# ────────────────────────────────────────────────────────────────────────────

def collect_split_points(dt):
    """Return dict {feat_idx: sorted list of thresholds} from a DT."""
    td = dt.tree_
    splits = {}
    for i in range(td.node_count):
        if td.feature[i] != -2:
            f = int(td.feature[i])
            t = float(td.threshold[i])
            splits.setdefault(f, set()).add(t)
    return {f: sorted(v) for f, v in splits.items()}


def threshold_to_bin(feat_idx, threshold, split_points):
    pts = split_points.get(feat_idx, [])
    for b, pt in enumerate(pts):
        if abs(pt - threshold) < 1e-12:
            return b
    for b in range(len(pts) - 1, -1, -1):
        if pts[b] < threshold:
            return b
    return -1


def model2asp_static_lp(dt, split_points, n_classes, with_domains=False):
    """Build the static (instance-independent) part of the model2asp encoding.

    with_domains=True  → include {bin(F,B)}=1 choice rules (open/no-instance mode)
    with_domains=False → decision rules only; bin facts are supplied by the caller
    """
    td = dt.tree_
    lines = []

    if with_domains:
        for feat_idx in sorted(split_points.keys()):
            n_bins = len(split_points[feat_idx]) + 1
            lines.append(f"{{bin({feat_idx}, B) : B = 0..{n_bins-1}}} = 1.")

    # Tree decision rules
    def recurse(node_id, conditions, var_counter):
        if td.feature[node_id] == -2:
            cls = int(td.value[node_id].argmax())
            if conditions:
                body = ", ".join(conditions)
                lines.append(f"decision({cls}) :- {body}.")
            else:
                lines.append(f"decision({cls}).")
        else:
            feat_idx = int(td.feature[node_id])
            thr = float(td.threshold[node_id])
            b = threshold_to_bin(feat_idx, thr, split_points)
            var = f"B{var_counter}"
            n_bins = len(split_points.get(feat_idx, [])) + 1

            if b >= 0:
                left_cond = f"bin({feat_idx}, {var}), {var} <= {b}"
            else:
                left_cond = f"bin({feat_idx}, 0)"
            recurse(td.children_left[node_id], conditions + [left_cond], var_counter + 1)

            if b + 1 <= n_bins - 1:
                right_cond = f"bin({feat_idx}, {var}), {var} >= {b + 1}"
            else:
                right_cond = f"bin({feat_idx}, {n_bins-1})"
            recurse(td.children_right[node_id], conditions + [right_cond], var_counter + 1)

    recurse(0, [], 0)

    lines.append(f"prediction(C) :- decision(C).")
    lines.append("#show prediction/1.")
    return "\n".join(lines)


def value_to_bin(value, thresholds):
    """Map a continuous value to its bin index."""
    for b, t in enumerate(thresholds):
        if value <= t:
            return b
    return len(thresholds)


def model2asp_instance_facts(x, split_points):
    """Build bin facts for instance x (these pin the bin choices)."""
    lines = []
    for feat_idx, thresholds in split_points.items():
        b = value_to_bin(x[feat_idx], thresholds)
        lines.append(f"bin({feat_idx}, {b}).")
    return "\n".join(lines)


# ────────────────────────────────────────────────────────────────────────────
# Timing helpers
# ────────────────────────────────────────────────────────────────────────────

def run_clingo(lp_content, timeout=CLINGO_TIMEOUT):
    """Run clingo with lp_content written to a temp file; return (wall_time, solving_time, stdout)."""
    with tempfile.NamedTemporaryFile(mode='w', suffix='.lp', delete=False) as f:
        f.write(lp_content)
        fname = f.name
    try:
        t0 = time.perf_counter()
        result = subprocess.run(
            ['clingo', fname, '--stats=2'],
            capture_output=True, text=True, timeout=timeout
        )
        wall = time.perf_counter() - t0
        stdout = result.stdout
        m = re.search(r'Solving:\s+([0-9.]+)s', stdout)
        solving = float(m.group(1)) if m else None
        return wall, solving, stdout
    except subprocess.TimeoutExpired:
        return None, None, None
    finally:
        os.unlink(fname)


def extract_prediction(stdout):
    """Extract prediction atom from clingo output."""
    m = re.search(r'prediction\((\d+)\)', stdout or '')
    return int(m.group(1)) if m else None


# ────────────────────────────────────────────────────────────────────────────
# Main benchmark
# ────────────────────────────────────────────────────────────────────────────

def main():
    parser = argparse.ArgumentParser(description='Benchmark model2asp vs feast-main clingo encodings')
    parser.add_argument('--n-features', type=int, default=20, help='Number of features (default: 20)')
    parser.add_argument('--n-classes', type=int, default=2, help='Number of classes (default: 2)')
    parser.add_argument('--max-depth', type=int, default=10, help='Max DT depth (default: 10)')
    parser.add_argument('--n-samples', type=int, default=5000, help='Training samples (default: 5000)')
    parser.add_argument('--n-test', type=int, default=30, help='Instances to time (default: 30)')
    parser.add_argument('--seed', type=int, default=42)
    args = parser.parse_args()

    rng = np.random.default_rng(args.seed)

    print("=" * 60)
    print("Generating random dataset and training decision tree...")
    print(f"  features={args.n_features}, classes={args.n_classes}, "
          f"max_depth={args.max_depth}, train_samples={args.n_samples}")

    X, y = make_classification(
        n_samples=args.n_samples,
        n_features=args.n_features,
        n_informative=max(2, args.n_features // 2),
        n_classes=args.n_classes,
        n_clusters_per_class=1,
        random_state=args.seed
    )
    feature_names = [f"f{i}" for i in range(args.n_features)]

    dt = DecisionTreeClassifier(max_depth=args.max_depth, random_state=args.seed)
    dt.fit(X, y)

    n_nodes = dt.tree_.node_count
    n_leaves = (dt.tree_.children_left == -1).sum()
    print(f"  DT: {n_nodes} nodes, {n_leaves} leaves, actual_depth={dt.get_depth()}")

    split_points = collect_split_points(dt)
    n_feats_used = len(split_points)
    total_bins = sum(len(v) + 1 for v in split_points.values())
    print(f"  Split points: {n_feats_used} features used, {total_bins} total bins")

    # Build static model2asp encoding (reused across all instances)
    static_lp = model2asp_static_lp(dt, split_points, args.n_classes)

    # Pick test instances
    idx = rng.choice(len(X), size=args.n_test, replace=False)
    X_test = X[idx]
    y_test = dt.predict(X_test)

    print(f"\nRunning {args.n_test} instances...\n")
    print(f"{'Instance':>8}  {'feast wall':>12}  {'feast solve':>12}  "
          f"{'m2asp wall':>12}  {'m2asp solve':>12}  {'agree':>6}")
    print("-" * 72)

    feast_walls, feast_solves = [], []
    m2asp_walls, m2asp_solves = [], []
    agreements = 0

    for i, (x, true_cls) in enumerate(zip(X_test, y_test)):
        # ── feast-main encoding ──
        facts = feast_instance_facts(dt, x, feature_names)
        feast_lp = facts + "\n" + FEAST_PREDICT_LP
        fw, fs, fout = run_clingo(feast_lp)
        feast_pred = extract_prediction(fout) if fout else None

        # ── model2asp encoding ──
        inst_facts = model2asp_instance_facts(x, split_points)
        m2asp_lp = inst_facts + "\n" + static_lp
        mw, ms, mout = run_clingo(m2asp_lp)
        m2asp_pred = extract_prediction(mout) if mout else None

        agree = (feast_pred == m2asp_pred == int(true_cls))
        if agree:
            agreements += 1

        if fw is not None:
            feast_walls.append(fw)
        if fs is not None:
            feast_solves.append(fs)
        if mw is not None:
            m2asp_walls.append(mw)
        if ms is not None:
            m2asp_solves.append(ms)

        fw_s = f"{fw*1000:.2f}ms" if fw is not None else "TIMEOUT"
        fs_s = f"{fs*1000:.2f}ms" if fs is not None else "N/A"
        mw_s = f"{mw*1000:.2f}ms" if mw is not None else "TIMEOUT"
        ms_s = f"{ms*1000:.2f}ms" if ms is not None else "N/A"
        print(f"{i:>8}  {fw_s:>12}  {fs_s:>12}  {mw_s:>12}  {ms_s:>12}  {'OK' if agree else 'MISMATCH':>6}")

    print("\n" + "=" * 60)
    print("SUMMARY")
    print("=" * 60)

    def stats(vals, label):
        if not vals:
            print(f"  {label}: no data")
            return
        arr = np.array(vals) * 1000  # ms
        print(f"  {label}: mean={arr.mean():.2f}ms  median={np.median(arr):.2f}ms  "
              f"min={arr.min():.2f}ms  max={arr.max():.2f}ms  n={len(arr)}")

    print(f"\nfeast-main (node-truth) encoding:")
    stats(feast_walls,  "  wall time  ")
    stats(feast_solves, "  solve time ")

    print(f"\nmodel2asp (bin-based) encoding:")
    stats(m2asp_walls,  "  wall time  ")
    stats(m2asp_solves, "  solve time ")

    print(f"\nPrediction agreement (both match sklearn): {agreements}/{args.n_test}")

    if feast_walls and m2asp_walls:
        ratio = np.mean(feast_walls) / np.mean(m2asp_walls)
        faster = "feast-main" if ratio > 1 else "model2asp"
        print(f"Speed ratio (feast_wall / m2asp_wall): {ratio:.2f}x  →  {faster} is faster on average")


if __name__ == '__main__':
    main()
