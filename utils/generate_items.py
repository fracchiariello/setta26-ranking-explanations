import json
import random
import sys
import os
import argparse
import joblib
import numpy as np

from empty_bins import bin_value

parser = argparse.ArgumentParser(description='Generate random item pairs as ASP facts.')
parser.add_argument('model_path', help='Path to the model .pkl file')
parser.add_argument('--n_pairs', type=int, default=5, help='Number of pairs to generate (default: 5)')
parser.add_argument('--seed', type=int, default=42, help='Random seed (default: 42)')
parser.add_argument('--class1', type=int, default=None, help='Required class for item 1')
parser.add_argument('--class2', type=int, default=None, help='Required class for item 2')
args = parser.parse_args()

model_dir = os.path.dirname(os.path.abspath(args.model_path))
n_pairs = args.n_pairs
seed = args.seed

random.seed(seed)

split_points_path = os.path.join(model_dir, 'split_points.json')
with open(split_points_path, 'r') as f:
    raw = json.load(f)
split_points = {int(k): sorted(float(t) for t in v) for k, v in raw.items()}

rf = joblib.load(args.model_path)
n_features = rf.n_features_in_
feat_indices = sorted(split_points.keys())

# Feature names: real column names when the dataset CSV has a header, else f0, f1, ...
feature_names = [f'f{i}' for i in range(n_features)]
# Resolve the dataset's data/ dir for feature/class names. Handles both the flat
# layout (model_dir = .../<dataset>) and the nested one (.../<dataset>/<config>),
# where the dataset name is the parent of the t<trees>_d<depth> config dir.
data_root = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), 'data')
dataset_name = os.path.basename(model_dir)
dataset_dir = os.path.join(data_root, dataset_name)
if not os.path.exists(os.path.join(dataset_dir, 'config.json')):
    dataset_name = os.path.basename(os.path.dirname(model_dir))
    dataset_dir = os.path.join(data_root, dataset_name)
config_path = os.path.join(dataset_dir, 'config.json')
if os.path.exists(config_path):
    with open(config_path) as f:
        config = json.load(f)
    if config.get('header_row'):
        with open(os.path.join(dataset_dir, config['csv_file'])) as f:
            header = f.readline().strip().split(config.get('separator', ','))
        all_columns = set(range(len(header)))
        feature_columns = sorted(all_columns - set(config['ignore_columns']) - {config['target_column']})
        feature_names = [header[i].strip() for i in feature_columns]


class_names = {}
if os.path.exists(config_path):
    class_names = {v: k for k, v in config.get('label_mapping', {}).items()}


def class_name(cls):
    return f" ({class_names[cls]})" if cls in class_names else ""


def fmt(t):
    """Trim float32 noise from a threshold for display."""
    return f"{round(t, 2):g}"


def bin_interval(feat_idx, b):
    """Human-readable interval covered by bin b of a feature."""
    ts = split_points[feat_idx]
    if b == 0:
        return f"<= {fmt(ts[0])}"
    if b == len(ts):
        return f"> {fmt(ts[-1])}"
    return f"({fmt(ts[b - 1])}, {fmt(ts[b])}]"


def random_bins():
    """Return a dict {feat_idx: bin} for all features in split_points.

    Bins are drawn uniformly. model2ASP.py merges the bins of integer-valued
    features that contain no integer, so every bin holds a value of its feature.
    """
    return {f: random.randint(0, len(split_points[f])) for f in feat_indices}


def bins_to_feature_vector(bins):
    """Convert bin assignments to a feature vector: one value per bin that stays
    in the bin once cast to float32 (utils/empty_bins.py)."""
    x = np.zeros(n_features)
    for feat_idx, b in bins.items():
        x[feat_idx] = bin_value(split_points[feat_idx], b)
    return x


def predict_class(bins):
    # Hard majority vote, ties broken to lowest class index — matches ASP encoding.
    x = bins_to_feature_vector(bins).reshape(1, -1)
    votes = [int(t.predict(x)[0]) for t in rf.estimators_]
    counts = {}
    for v in votes:
        counts[v] = counts.get(v, 0) + 1
    max_votes = max(counts.values())
    return min(c for c, v in counts.items() if v == max_votes)


def bins_to_facts(item_id, bins):
    lines = [f"item({item_id})."]
    for feat_idx in feat_indices:
        fact = f"bin({item_id},{feat_idx},{bins[feat_idx]})."
        comment = f"% {feature_names[feat_idx]} {bin_interval(feat_idx, bins[feat_idx])}"
        lines.append(f"{fact:<18}{comment}")
    return lines


for p in range(n_pairs):
    while True:
        bins_a = random_bins()
        bins_b = random_bins()
        cls_a = predict_class(bins_a)
        cls_b = predict_class(bins_b)

        # ensure class_1 <= class_2
        if cls_a <= cls_b:
            bins1, bins2 = bins_a, bins_b
            cls1, cls2 = cls_a, cls_b
        else:
            bins1, bins2 = bins_b, bins_a
            cls1, cls2 = cls_b, cls_a

        if (args.class1 is None or cls1 == args.class1) and \
           (args.class2 is None or cls2 == args.class2):
            break

    lines = [f"% class_1={cls1}{class_name(cls1)}, class_2={cls2}{class_name(cls2)}"]
    lines.append("")
    lines.extend(bins_to_facts(1, bins1))
    lines.append("")
    lines.extend(bins_to_facts(2, bins2))

    pairs_dir = os.path.join(model_dir, "pairs")
    os.makedirs(pairs_dir, exist_ok=True)
    out_path = os.path.join(pairs_dir, f"pair_{p}.lp")
    with open(out_path, 'w') as f:
        f.write("\n".join(lines) + "\n")
    print(f"Written: {out_path}  (class_1={cls1}, class_2={cls2})")
