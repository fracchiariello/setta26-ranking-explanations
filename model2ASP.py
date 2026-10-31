import joblib
import os
import json
import subprocess
import sys
import argparse
from sklearn import tree as sklearn_tree

sys.path.insert(0, os.path.join(os.path.dirname(os.path.abspath(__file__)), 'utils'))
from merge_split_points import merge_split_points
from agglomerative_split_points import agglomerative_split_points
from empty_bins import merge_empty_bins, snap, snap32

parser = argparse.ArgumentParser(
    description="Convert a trained random forest into ASP facts (random_forest.lp)."
)
parser.add_argument('model_path', help='Path to the model .pkl file')
parser.add_argument('--bins', type=int, default=None, metavar='N',
                    help='Coarsen split points to at most N bins per feature '
                         'before generating the ASP. Omit to use the '
                         'full-resolution thresholds.')
parser.add_argument('--strategy', choices=['percentile', 'agglomerative'],
                    default='percentile',
                    help='Threshold-reduction strategy when --bins is set '
                         '(default: percentile). "agglomerative" first runs an '
                         'impurity-guided pre-merge, then the --bins cap.')
parser.add_argument('--agglo-tol', type=float, default=0.0,
                    help='Tolerance for the agglomerative impurity merge '
                         '(default: 0.0). Only used with --strategy agglomerative.')
parser.add_argument('--agglo-criterion', choices=['gini', 'entropy'], default='gini',
                    help='Impurity criterion for agglomerative merge (default: gini).')
parser.add_argument('--keep-empty-bins', action='store_true',
                    help='Keep the bins that no input can reach: no integer for an '
                         'integer-valued feature, no float32 value for a real-valued '
                         'one (by default they are merged, see utils/empty_bins.py).')
parser.add_argument('--dataset', default=None, metavar='NAME',
                    help='Dataset name under data/ for config lookup. Defaults to '
                         'the model directory name; set this when the model lives '
                         'in a directory not named after the dataset.')
args = parser.parse_args()

model_path = args.model_path
model_dir = os.path.dirname(os.path.abspath(model_path))
# Derive the dataset name from the model dir. Grid-search models are nested as
# models/<dataset>/t<trees>_d<depth>/, so when the immediate dir is a t*_d*
# config dir, use its parent (the dataset). Otherwise use the dir name itself.
# --dataset always overrides.
import re as _re
_dirname = os.path.basename(model_dir)
if args.dataset:
    dataset_name = args.dataset
elif _re.fullmatch(r't\d+_d\d+', _dirname):
    dataset_name = os.path.basename(os.path.dirname(model_dir))
else:
    dataset_name = _dirname
dataset_dir = os.path.join(os.path.dirname(__file__), 'data', dataset_name)

rf_classifier = joblib.load(model_path)
print(f"Model loaded: {model_path}")
print(f"Trees: {rf_classifier.n_estimators}  Features: {rf_classifier.n_features_in_}")

config_path = os.path.join(dataset_dir, 'config.json')
with open(config_path, 'r') as f:
    config = json.load(f)

label_mapping = config['label_mapping']
classes = list(label_mapping.keys())
n_classes = len(classes)
idx_to_class = {v: k for k, v in label_mapping.items()}

# Feature names: real column names when the CSV has a header, else f0, f1, ...
feature_names = [f'f{i}' for i in range(rf_classifier.n_features_in_)]
if config.get('header_row'):
    with open(os.path.join(dataset_dir, config['csv_file'])) as f:
        header = f.readline().strip().split(config.get('separator', ','))
    all_columns = set(range(len(header)))
    feature_columns = sorted(all_columns - set(config['ignore_columns']) - {config['target_column']})
    feature_names = [header[i].strip() for i in feature_columns]

# Run discretization.py to (re)generate split_points.json (and the pristine
# split_points_original.json) from the model.
discretization_script = os.path.join(os.path.dirname(__file__), 'utils', 'discretization.py')
print("\nRunning discretization...")
subprocess.run([sys.executable, discretization_script, model_path], check=True)

# Optionally coarsen split_points.json to a target number of bins per feature.
# Reads the pristine split_points_original.json just written by discretization.
if args.bins is not None:
    # For the agglomerative strategy, run the impurity-guided pre-merge FIRST
    # (independent of --bins): it writes split_points_agglo.json, which the
    # --bins cap then reads from.
    if args.strategy == 'agglomerative':
        print(f"\nAgglomerative (impurity-guided) pre-merge "
              f"(tol={args.agglo_tol}, criterion={args.agglo_criterion})...")
        agglomerative_split_points(model_dir, tol=args.agglo_tol,
                                   criterion=args.agglo_criterion,
                                   dataset=args.dataset)
    print(f"\nCoarsening split points to <= {args.bins} bins per feature "
          f"(strategy: {args.strategy})...")
    merge_split_points(model_dir, args.bins, args.strategy)

# Merge the bins that no input reaches (no integer, or no float32 value).
int_feats = set()
if not args.keep_empty_bins:
    print("\nMerging theoretically empty bins of integer-valued features...")
    int_feats = merge_empty_bins(model_dir, dataset_dir)

split_points_path = os.path.join(model_dir, 'split_points.json')
with open(split_points_path, 'r') as f:
    raw = json.load(f)
# Keys are already 0-based sklearn feature indices (written by discretization.py
# directly from tree_.feature), so no remapping is needed.
split_points = {int(k): sorted(float(t) for t in v) for k, v in raw.items()}

print(f"Classes: {classes}")

# ============================================================================
# Encoding strategy
# ============================================================================
# Each continuous feature f_i is discretized into an integer bin b_i in
# {0, 1, ..., len(split_points[i])}.  Bin 0 means the value is <= all
# thresholds; bin k means it is > threshold[k-1] and <= threshold[k]; the
# last bin means it is > all thresholds.
#
# On integer-valued (and label-encoded categorical) features a threshold may
# fall on an integer (sklearn splits at the midpoint of the values present in a
# node, e.g. 35.0 between 34 and 36), so a bin such as (35, 35.5] can contain no
# integer. Likewise, since the forest compares float32 inputs, two thresholds of
# a real-valued feature can enclose no float32 value. Such theoretically empty
# bins are merged (utils/empty_bins.py): the thresholds of an integer-valued
# feature are moved to floor(t) + 0.5, those of a real-valued one to the largest
# float32 not above t, where the forest's test x <= t gives the same result on
# every input, and thresholds that coincide become one. --keep-empty-bins keeps
# them.
#
# ASP atoms:
#   bin(FeatIdx, Bin)          — the discretized bin of feature FeatIdx
#
# Each tree is encoded using a tree structure where each internal node
# is represented by a node fact and left/right child facts, and leaves
# are derived via traversal rules using bin conditions:
#
#   node(T, X, F, B)           — internal node X in tree T tests feature F,
#                                 B is the max bin satisfying the left branch
#   left_node(T, X, N2)        — left child of node X in tree T
#   right_node(T, X, N2)       — right child of node X in tree T
#   leaf_class(T, X, C)        — leaf X of tree T predicts class C, the argmax
#                                 of its training counts (ties -> lowest class
#                                 index, matching sklearn's tree.predict). A
#                                 node is a leaf iff it has a leaf_class fact.
#                                 Precomputed here so encoding.lp needs only the
#                                 single majority class, not the full counts.
#
#   bin_max(F, K)              — the bins of feature F are 0..K
#
# Traversal rules (encoding.lp) read the bin order le(I, F, B), "the bin of item
# I for feature F is at most B", derived once per feature and bin:
#   le(I, F, B)   :- bin(I, F, B).
#   le(I, F, B+1) :- le(I, F, B), bin_max(F, K), B < K.
#   next_node(I, T, N2) :- next_node(I, T, N1), node(T, N1, F, B), le(I, F, B), left_node(T, N1, N2).
#   next_node(I, T, N2) :- next_node(I, T, N1), node(T, N1, F, B), not le(I, F, B), right_node(T, N1, N2).
#
# The forest prediction is hard (majority) voting: each tree casts one vote for
# the class of the leaf the item reaches, and the class with the most votes wins
# (vote ties -> lowest class index):
#   class(I, T, C) :- next_node(I, T, N), leaf_class(T, N, C).
#   vote(I, C, V)  :- class_idx(C), V = #count{ T : class(I, T, C) }.
#   prediction(I, C) :- max_votes(I, M), C = #min{ C' : vote(I, C', M) }.
# ============================================================================

# ===========================================================================
# FILE 1: random_forest.lp  — RF-dependent facts (bin domains + tree structure)
# ===========================================================================

rf_lines = []

rf_lines.append("% ============================================================")
rf_lines.append(f"% random_forest.lp — RF facts for {dataset_name}")
rf_lines.append(f"% {rf_classifier.n_estimators} trees  |  {rf_classifier.n_features_in_} features")
rf_lines.append("% RF-dependent: bin domains and tree structural facts.")
rf_lines.append("% Load together with encoding.lp.")
rf_lines.append("%")
rf_lines.append("% --- Predicates ---")
rf_lines.append("% tree(T)            : T is a tree index.")
rf_lines.append("% node(T,X,F,B)      : internal node X in tree T tests feature F with split bin B.")
rf_lines.append("% left_node(T,X,N2)  : left child of node X in tree T  (condition true:  bin <= B).")
rf_lines.append("% right_node(T,X,N2) : right child of node X in tree T (condition false: bin > B).")
rf_lines.append("% leaf_class(T,X,C)  : leaf X of tree T predicts class C.")
rf_lines.append("%                      A node is a leaf iff it has a leaf_class fact.")
rf_lines.append("% bin(I,F,B)         : item I is assigned to bin B for feature F. With sorted")
rf_lines.append("%                      thresholds [t1<...<tk], bin 0 means v<=t1, bin j means")
rf_lines.append("%                      tj<v<=tj+1, bin k means v>tk. A \"bin <= B\" test is \"v <= t(B+1)\".")
rf_lines.append("% bin_max(F,K)       : the bins of feature F are 0..K.")
rf_lines.append("% class_idx(C)       : C is a valid class index.")
rf_lines.append("% ============================================================")
rf_lines.append("")

# ---- Bin domains ----
rf_lines.append("% --- Feature bin domains ---")
rf_lines.append("% bin(I,F,B): item I is assigned to bin B for feature F.")
rf_lines.append("")
for feat_idx in sorted(split_points.keys()):
    n_bins = len(split_points[feat_idx]) + 1
    bins = list(range(n_bins))
    rf_lines.append(f"% Feature {feat_idx} ({feature_names[feat_idx]}): {n_bins} bins  (thresholds: {split_points[feat_idx]})")
    rf_lines.append(f"{{bin(I,{feat_idx},B) : B = {bins[0]}..{bins[-1]}}} = 1 :- item(I).")
    rf_lines.append(f"bin_max({feat_idx},{bins[-1]}).")
    rf_lines.append("")

# ---- Tree structural facts ----
rf_lines.append("% --- Tree structural facts ---")
rf_lines.append("")


def threshold_to_bin(feat_idx, threshold):
    """Return the bin index b such that value <= threshold iff bin <= b."""
    pts = split_points.get(feat_idx, [])
    if not args.keep_empty_bins:
        threshold = snap(threshold) if feat_idx in int_feats else snap32(threshold)
    for b, pt in enumerate(pts):
        if abs(pt - threshold) < 1e-12:
            return b
    for b in range(len(pts) - 1, -1, -1):
        if pts[b] < threshold:
            return b
    return -1


for t_idx, t_model in enumerate(rf_classifier.estimators_):
    td = t_model.tree_
    rf_lines.append(f"% Tree {t_idx}")
    rf_lines.append(f"tree({t_idx}).")
    for node in range(td.node_count):
        feat = int(td.feature[node])
        if feat == -2:
            value = td.value[node][0]
            # value holds normalized class proportions in recent sklearn,
            # raw (bootstrap-weighted) counts in older versions
            if abs(value.sum() - 1.0) < 1e-6:
                counts = value * td.weighted_n_node_samples[node]
            else:
                counts = value
            counts = [int(round(c)) for c in counts]
            # The leaf's predicted class is the argmax of its counts. sklearn's
            # tree.predict breaks ties to the lowest class index (numpy argmax),
            # so we precompute leaf_class here rather than emitting the full
            # count distribution and deriving it in encoding.lp.
            leaf_class = max(range(len(counts)), key=lambda c: (counts[c], -c))
            rf_lines.append(f"% node {node} (leaf): class {idx_to_class.get(leaf_class, leaf_class)} ({leaf_class})")
            rf_lines.append(f"leaf_class({t_idx},{node},{leaf_class}).")
        else:
            threshold = float(td.threshold[node])
            left_child = int(td.children_left[node])
            right_child = int(td.children_right[node])
            b = threshold_to_bin(feat, threshold)
            rf_lines.append(f"% node {node}: {feature_names[feat]} <= {threshold}  (F{feat}, bin <= {b})  "
                            f"left -> {left_child}, right -> {right_child}")
            rf_lines.append(f"node({t_idx},{node},{feat},{b}).")
            rf_lines.append(f"left_node({t_idx},{node},{left_child}).")
            rf_lines.append(f"right_node({t_idx},{node},{right_child}).")
    rf_lines.append("")

rf_lines.append("% --- Class domain ---")
for name, idx in label_mapping.items():
    rf_lines.append(f"class_idx({idx}).  % {name}")
rf_lines.append("")

rf_path = os.path.join(model_dir, 'random_forest.lp')
with open(rf_path, 'w') as f:
    f.write("\n".join(rf_lines))
print(f"\nRF facts saved: {rf_path}")

