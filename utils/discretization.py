import joblib
import json
import os
import sys
from collections import defaultdict

if len(sys.argv) < 2:
    print("Usage: python discretization.py <model_path>")
    sys.exit(1)

model_path = sys.argv[1]
rf_classifier = joblib.load(model_path)

print(f"Model loaded: {os.path.basename(model_path)}")
print(f"Trees: {rf_classifier.n_estimators}  Features: {rf_classifier.n_features_in_}")

# For each feature, map threshold -> set of tree indices where it appears
split_points = defaultdict(lambda: defaultdict(set))

for tree_idx, estimator in enumerate(rf_classifier.estimators_):
    t = estimator.tree_
    for node_id in range(t.node_count):
        if t.feature[node_id] != -2:  # not a leaf
            split_points[t.feature[node_id]][t.threshold[node_id]].add(tree_idx)

print("\nSplit points per feature:")
for feat_idx in sorted(split_points):
    for threshold in sorted(split_points[feat_idx]):
        trees = sorted(split_points[feat_idx][threshold])
        print(f"  f{feat_idx}  threshold={float(threshold)}  trees={trees}")

# Save to file next to the model
# Format: {feat_idx: {threshold: [tree_indices]}}
model_dir = os.path.dirname(os.path.abspath(model_path))
output_path = os.path.join(model_dir, 'split_points.json')
original_path = os.path.join(model_dir, 'split_points_original.json')

serializable = {
    str(feat_idx): {
        str(threshold): sorted(trees)
        for threshold, trees in sorted(split_points[feat_idx].items())
    }
    for feat_idx in sorted(split_points)
}
# split_points.json is the working copy (may later be coarsened by
# utils/merge_split_points.py); split_points_original.json is the pristine,
# full-resolution set of thresholds extracted straight from the model.
for path in (output_path, original_path):
    with open(path, 'w') as f:
        json.dump(serializable, f, indent=2)

print(f"\nSaved to: {output_path}")
print(f"Original (pristine) saved to: {original_path}")
