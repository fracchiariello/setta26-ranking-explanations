import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from collections import defaultdict
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score, classification_report, cohen_kappa_score, confusion_matrix, precision_recall_fscore_support
from sklearn import tree
import os
import json
import joblib
import sys
import shutil
import argparse

# Set random seed for reproducibility
np.random.seed(42)

# ============================================================================
# Parse command line arguments
# ============================================================================
parser = argparse.ArgumentParser(description='Random Forest Classifier', formatter_class=argparse.ArgumentDefaultsHelpFormatter)
parser.add_argument('dataset_dir', help='Path to dataset directory')
parser.add_argument('-g', '--generate-trees', action='store_true', help='Generate tree PNG visualizations')
parser.add_argument('--n-estimators', type=int, default=10, help='Number of trees')
parser.add_argument('--max-depth', type=int, default=3, help='Maximum tree depth')
parser.add_argument('--min-samples-split', type=int, default=5, help='Min samples to split a node')
parser.add_argument('--min-samples-leaf', type=int, default=2, help='Min samples in a leaf')
parser.add_argument('--ccp-alpha', type=float, default=0.0, help='Cost-complexity pruning parameter')
parser.add_argument('--criterion', choices=['gini', 'entropy', 'log_loss'], default='gini',
                    help='Split quality criterion')
parser.add_argument('--voting', choices=['hard', 'soft'], default='hard',
                    help='How the trees are combined when the forest is evaluated: hard '
                         '(majority vote, ties -> lowest class, as in encoding.lp and '
                         'Breiman 2001) or soft (sklearn forest.predict, averaged '
                         'class probabilities)')
parser.add_argument('--test-size', type=float, default=0.2, help='Test set fraction')
parser.add_argument('--random-state', type=int, default=42, help='Random seed')
parser.add_argument('--output-dir', default=None,
                    help='Directory to write the model into (default: '
                         'experiments/<dataset_name>). Set this to write directly '
                         'into a per-config folder.')
args = parser.parse_args()

dataset_dir = args.dataset_dir
if os.path.isfile(dataset_dir):
    dataset_dir = os.path.dirname(dataset_dir)
generate_tree_pngs = args.generate_trees
np.random.seed(args.random_state)

print(f"Dataset path: {dataset_dir}")
print(f"Tree PNG generation: {'ENABLED' if generate_tree_pngs else 'DISABLED'}")
print(f"Classifier params: n_estimators={args.n_estimators}, max_depth={args.max_depth}, "
      f"min_samples_split={args.min_samples_split}, min_samples_leaf={args.min_samples_leaf}, "
      f"ccp_alpha={args.ccp_alpha}, criterion={args.criterion}, test_size={args.test_size}, "
      f"random_state={args.random_state}, voting={args.voting}")

# ============================================================================
# PART 1: Classification with Random Forest
# ============================================================================
print("=" * 70)
print("RANDOM FOREST CLASSIFICATION")
print("=" * 70)

# Load configuration
config_path = os.path.join(dataset_dir, 'config.json')
with open(config_path, 'r') as f:
    config = json.load(f)

target_column = config['target_column']
ignore_columns = config['ignore_columns']
label_mapping = config['label_mapping']
csv_file = config['csv_file']
separator = config['separator']
header_row = config['header_row']
# Optional: per-column string->int maps for categorical features, keyed by the
# feature's absolute column index (as a string, matching JSON keys). Datasets
# with only numeric features simply omit this key.
feature_encoding = config.get('feature_encoding', {})

# Load dataset
data_path = os.path.join(dataset_dir, csv_file)
df = pd.read_csv(data_path, sep=separator, header=0 if header_row else None)
print(f"Dataset shape: {df.shape}")

# Numerically encode any categorical feature columns declared in the config, so
# the random forest trains on a fully numeric X. Assigning by column label (with
# isetitem) replaces the column outright so its dtype becomes numeric — a direct
# `df.iloc[:, col] = ...` instead tries to preserve the old object dtype and fails.
for col_key, mapping in feature_encoding.items():
    col = int(col_key)
    encoded = df.iloc[:, col].astype(str).map(mapping)
    if encoded.isna().any():
        bad = sorted(set(df.iloc[:, col].astype(str)[encoded.isna()]))
        raise ValueError(
            f"feature_encoding for column {col} is missing a mapping for "
            f"value(s) {bad} (check config.json)")
    df.isetitem(col, encoded.astype(int))
    print(f"Encoded categorical feature column {col}: {mapping}")

# Extract features (exclude target and ignore columns)
all_columns = set(range(df.shape[1]))
feature_columns = sorted(all_columns - set(ignore_columns) - {target_column})
X = df.iloc[:, feature_columns].values
y_labels = df.iloc[:, target_column].values

# Feature names: real column names when the CSV has a header, else f0, f1, ...
if header_row:
    feature_names = [str(df.columns[i]) for i in feature_columns]
else:
    feature_names = [f'f{i}' for i in range(len(feature_columns))]

# Encode labels with explicit mapping (cast to str to match JSON string keys)
y = np.array([label_mapping[str(label)] for label in y_labels])
classes = np.array(list(label_mapping.keys()))
# Integer codes for every class in the mapping, in name order. Passed as the
# explicit `labels` to the sklearn metrics so they align with all class names
# even when some class never appears in y_test (e.g. a rare CL level for a drug).
class_labels = list(label_mapping.values())
print(f"Target column: {target_column}")
print(f"Ignore columns: {ignore_columns}")
print(f"Feature columns: {feature_columns}")
print(f"Classes: {classes}")
print(f"Label mapping: {label_mapping}")
print(f"Class distribution: {np.bincount(y)}")

# Split data
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=args.test_size, random_state=args.random_state
)

# Train Random Forest Classifier
rf_classifier = RandomForestClassifier(
    n_estimators=args.n_estimators,
    max_depth=args.max_depth,
    min_samples_split=args.min_samples_split,
    min_samples_leaf=args.min_samples_leaf,
    ccp_alpha=args.ccp_alpha,
    criterion=args.criterion,
    random_state=args.random_state
)
rf_classifier.fit(X_train, y_train)


def hard_vote(forest, X):
    """Majority vote of the trees, ties -> lowest class index (prediction(I,C)
    in encoding.lp). Each tree predicts an index into forest.classes_."""
    votes = np.array([est.predict(X).astype(int) for est in forest.estimators_])
    counts = np.apply_along_axis(np.bincount, 0, votes, minlength=len(forest.classes_))
    # argmax returns the first maximum, i.e. the lowest class index.
    return forest.classes_[counts.argmax(axis=0)]


def predict(X):
    return hard_vote(rf_classifier, X) if args.voting == 'hard' else rf_classifier.predict(X)


# Make predictions
y_pred = predict(X_test)

# Evaluate
train_accuracy = accuracy_score(y_train, predict(X_train))
accuracy = accuracy_score(y_test, y_pred)
print(f"\nTrain Accuracy: {train_accuracy:.4f}")
print(f"Test Accuracy:  {accuracy:.4f}")
print("\nClassification Report:")
print(classification_report(y_test, y_pred, labels=class_labels,
                            target_names=classes, zero_division=0))

# Create model output directory (clean existing contents first)
if args.output_dir:
    model_dir = os.path.abspath(args.output_dir)
else:
    model_dir = os.path.join(os.path.dirname(__file__), 'experiments', os.path.basename(dataset_dir.rstrip('/')))
if os.path.exists(model_dir):
    shutil.rmtree(model_dir)
os.makedirs(model_dir)
print(f"Model directory cleaned: {model_dir}")

# Compute confusion matrix (labels pins it to all classes, so it stays square
# and aligned with `classes` even when some class is absent from y_test).
cm = confusion_matrix(y_test, y_pred, labels=class_labels)


dataset_name = os.path.basename(dataset_dir)

# Save the trained model
model_path = os.path.join(model_dir, 'random_forest.pkl')
joblib.dump(rf_classifier, model_path)
print(f"\nModel saved: {model_path}")

# ============================================================================
# Save Model Statistics
# ============================================================================
stats_path = os.path.join(model_dir, 'model_statistics.txt')
with open(stats_path, 'w') as f:
    f.write("=" * 70 + "\n")
    f.write("RANDOM FOREST MODEL STATISTICS\n")
    f.write("=" * 70 + "\n\n")

    f.write("Model Configuration:\n")
    f.write(f"  Number of trees: {rf_classifier.n_estimators}\n")
    f.write(f"  Max depth: {rf_classifier.max_depth}\n")
    f.write(f"  Min samples split: {rf_classifier.min_samples_split}\n")
    f.write(f"  Min samples leaf: {rf_classifier.min_samples_leaf}\n")
    f.write(f"  CCP alpha: {rf_classifier.ccp_alpha}\n")
    f.write(f"  Criterion: {rf_classifier.criterion}\n")
    f.write(f"  Voting: {args.voting}\n")
    f.write(f"  Number of features: {rf_classifier.n_features_in_}\n")
    f.write(f"  Number of classes: {len(classes)}\n")
    # Distinct classes the model actually predicts on the test set (<= total).
    f.write(f"  Classes predicted: {len(np.unique(y_pred))}\n")
    f.write(f"  Classes: {', '.join(classes)}\n\n")

    f.write("Training Data:\n")
    f.write(f"  Training set size: {len(X_train)}\n")
    f.write(f"  Test set size: {len(X_test)}\n")
    f.write(f"  Target column: {target_column}\n")
    f.write(f"  Ignore columns: {ignore_columns}\n")
    f.write(f"  Feature columns: {feature_columns}\n")
    f.write(f"  Feature names: {feature_names}\n\n")

    precision, recall, f1, support = precision_recall_fscore_support(
        y_test, y_pred, labels=class_labels, zero_division=0)

    f.write(f"Performance Metrics ({args.voting} voting):\n")
    f.write(f"  Train Accuracy: {train_accuracy:.4f}\n")
    f.write(f"  Test Accuracy:  {accuracy:.4f}\n\n")

    f.write("Per-Class Metrics:\n")
    header = f"  {'Class':>8}  {'Precision':>10}  {'Recall':>10}  {'F1-Score':>10}  {'Support':>8}\n"
    f.write(header)
    f.write("  " + "-" * 56 + "\n")
    for i, cls in enumerate(classes):
        f.write(f"  {cls:>8}  {precision[i]:>10.4f}  {recall[i]:>10.4f}  {f1[i]:>10.4f}  {support[i]:>8}\n")
    macro_p, macro_r, macro_f1, _ = precision_recall_fscore_support(
        y_test, y_pred, labels=class_labels, average='macro', zero_division=0)
    weighted_p, weighted_r, weighted_f1, _ = precision_recall_fscore_support(
        y_test, y_pred, labels=class_labels, average='weighted', zero_division=0)
    f.write("  " + "-" * 56 + "\n")
    f.write(f"  {'macro avg':>8}  {macro_p:>10.4f}  {macro_r:>10.4f}  {macro_f1:>10.4f}  {len(y_test):>8}\n")
    f.write(f"  {'weighted avg':>8}  {weighted_p:>10.4f}  {weighted_r:>10.4f}  {weighted_f1:>10.4f}  {len(y_test):>8}\n\n")

    # Quadratic Weighted Kappa: agreement metric for (categorical) ordinal data,
    # penalizing disagreements by squared distance in the label ordering. Labels
    # are integer-encoded via the config's label_mapping, which preserves order.
    # labels= pins the full ordinal scale so a class absent from y_test doesn't
    # collapse the distance weighting.
    qwk = cohen_kappa_score(y_test, y_pred, labels=class_labels, weights='quadratic')
    f.write(f"Quadratic Weighted Kappa: {qwk:.4f}\n\n")

    f.write("Confusion Matrix:\n")
    header = "         " + "  ".join(f"{c:>6}" for c in classes)
    f.write(f"{header}\n")
    for i, row in enumerate(cm):
        row_str = "  ".join(f"{v:>6}" for v in row)
        f.write(f"  {classes[i]:>6}  {row_str}\n")
    f.write("\n")

    depths = [t.get_depth() for t in rf_classifier.estimators_]
    leaves = [t.get_n_leaves() for t in rf_classifier.estimators_]
    nodes  = [t.tree_.node_count for t in rf_classifier.estimators_]

    f.write("Forest Size:\n")
    f.write(f"  Total nodes:  {sum(nodes)}\n")
    f.write(f"  Total leaves: {sum(leaves)}\n")
    f.write(f"  Max depth:    {max(depths)}  (avg: {np.mean(depths):.1f})\n")
    f.write(f"  Avg nodes per tree:  {np.mean(nodes):.1f}\n")
    f.write(f"  Avg leaves per tree: {np.mean(leaves):.1f}\n")

    # Split points per feature: distinct thresholds used across the whole forest
    # for each feature (the same notion discretization.py turns into bins). The
    # average is over features the forest actually splits on.
    split_points = defaultdict(set)
    for tree_model in rf_classifier.estimators_:
        tr = tree_model.tree_
        for node in range(tr.node_count):
            fi = tr.feature[node]
            if fi >= 0:
                split_points[int(fi)].add(float(tr.threshold[node]))
    if split_points:
        avg_split_points = sum(len(v) for v in split_points.values()) / len(split_points)
    else:
        avg_split_points = 0.0
    f.write(f"  Avg split points per feature: {avg_split_points:.2f}\n\n")

    all_features = set(range(rf_classifier.n_features_in_))
    used_features = set()
    for tree_model in rf_classifier.estimators_:
        used_features.update(int(i) for i in tree_model.tree_.feature[tree_model.tree_.feature >= 0])
    unused_features = all_features - used_features

    def format_feature_list(indices, cols=10):
        indices = sorted(indices)
        rows = [indices[i:i+cols] for i in range(0, len(indices), cols)]
        return "\n".join("    " + "  ".join(feature_names[idx] for idx in row) for row in rows)

    f.write("Feature Usage (across entire forest):\n")
    f.write(f"  Used ({len(used_features)}/{rf_classifier.n_features_in_}):\n{format_feature_list(used_features)}\n")
    f.write(f"  Unused ({len(unused_features)}/{rf_classifier.n_features_in_}):\n")
    if unused_features:
        f.write(format_feature_list(unused_features) + "\n")
    else:
        f.write("    (none)\n")
    f.write("\n")

    f.write("Per-Tree Statistics:\n")
    f.write(f"  {'Tree':>6}  {'Depth':>6}  {'Nodes':>7}  {'Leaves':>7}  {'Features':>9}  {'Train Acc':>10}  {'Test Acc':>10}\n")
    f.write("  " + "-" * 68 + "\n")
    for tree_idx, tree_model in enumerate(rf_classifier.estimators_):
        t_train = tree_model.score(X_train, y_train)
        t_test = tree_model.score(X_test, y_test)
        n_nodes = tree_model.tree_.node_count
        n_features_used = len(set(tree_model.tree_.feature[tree_model.tree_.feature >= 0]))
        f.write(f"  {tree_idx:>6}  {tree_model.get_depth():>6}  {n_nodes:>7}  {tree_model.get_n_leaves():>7}  {n_features_used:>9}  {t_train:>10.4f}  {t_test:>10.4f}\n")

    f.write("\n" + "=" * 70 + "\n")

print(f"Model statistics saved: {stats_path}")

# ============================================================================
# PART 3: Visualize and Inspect Trees (Optional)
# ============================================================================

if generate_tree_pngs:
    print("\n" + "=" * 70)
    print("GENERATING TREE VISUALIZATIONS")
    print("=" * 70)

    # Create dedicated subfolder for tree visualizations
    trees_dir = os.path.join(model_dir, 'trees')
    os.makedirs(trees_dir, exist_ok=True)

    # Visualize all trees
    n_trees = len(rf_classifier.estimators_)
    print(f"\nGenerating visualizations for {n_trees} trees...")
    for tree_idx, tree_model in enumerate(rf_classifier.estimators_):
        depth = tree_model.get_depth()
        fig, ax = plt.subplots(figsize=(max(20, depth * 4), max(10, depth * 2)))
        tree.plot_tree(tree_model,
                       feature_names=feature_names,
                       class_names=classes,
                       filled=True,
                       ax=ax)

        tree_output_path = os.path.join(trees_dir, f'tree_{tree_idx}.png')
        plt.savefig(tree_output_path, dpi=150, bbox_inches='tight')
        plt.close()

        # Print statistics for each tree
        t_test = tree_model.score(X_test, y_test)
        print(f"  Tree {tree_idx}: depth={tree_model.get_depth()}, leaves={tree_model.get_n_leaves()}, test_acc={t_test:.4f}")

    print(f"\nAll {n_trees} tree visualizations saved to: {trees_dir}")
else:
    print("Tree PNG generation skipped (use --generate-trees or -g to enable)")

print("\n" + "=" * 70)
print("SCRIPT COMPLETE")
print("=" * 70)
