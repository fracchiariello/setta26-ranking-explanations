"""
Test-set performance of the selected forests under hard and soft voting.

learn_random_forest.py (and hence model_statistics.txt, best_models.txt and
models/model_info_table.tex) scores each forest with sklearn's
forest.predict(), which is SOFT voting: the class with the highest mean
probability estimate across the trees. The ASP encoding instead explains the
forest under HARD majority voting: each tree votes for the class of the leaf
the item reaches, and the most-voted class wins, ties broken to the lowest
class index (prediction(I,C) in encoding.lp). This script recomputes the
test-set metrics under both rules so the reported performance can match the
classifier that is actually explained.

For every model directory (default: all of models/<dataset>/t*_d*/) it:
  - recreates the exact train/test split learn_random_forest.py used;
  - checks the recreated soft-vote weighted F1 against model_statistics.txt;
  - reports accuracy, macro F1, weighted F1 and quadratic weighted kappa under
    both rules, plus how many test items the two rules classify differently and
    how many hard votes were ties.

Results are printed and written to models/voting_performance.txt and
models/voting_performance_table.tex.

Usage:
    python voting_performance.py [model_dir ...] [--test-size 0.2] [--random-state 42]
"""

import argparse
import glob
import json
import os
import re
import sys

import joblib
import numpy as np
import pandas as pd
from sklearn.metrics import accuracy_score, cohen_kappa_score, f1_score
from sklearn.model_selection import train_test_split

BASE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, os.path.join(BASE, "utils"))
from feature_encoding import apply_feature_encoding  # noqa: E402


def load_split(dataset_dir, test_size, random_state):
    """Recreate the exact train/test split learn_random_forest.py uses.

    Returns (X_train, X_test, y_train, y_test, class_labels), where
    class_labels are the integer codes of every class in label_mapping.
    """
    with open(os.path.join(dataset_dir, "config.json")) as f:
        config = json.load(f)
    df = pd.read_csv(os.path.join(dataset_dir, config["csv_file"]),
                     sep=config["separator"],
                     header=0 if config["header_row"] else None)
    apply_feature_encoding(df, config)
    all_cols = set(range(df.shape[1]))
    feature_columns = sorted(all_cols - set(config["ignore_columns"])
                             - {config["target_column"]})
    X = df.iloc[:, feature_columns].values
    label_mapping = config["label_mapping"]
    y = np.array([label_mapping[str(v)] for v in df.iloc[:, config["target_column"]].values])
    X_train, X_test, y_train, y_test = train_test_split(
        X, y, test_size=test_size, random_state=random_state)
    return X_train, X_test, y_train, y_test, list(label_mapping.values())


def hard_vote(forest, X):
    """Hard majority vote, ties -> lowest class index, matching prediction(I,C).

    Each sub-estimator predicts an index into forest.classes_ (the forest
    re-encodes y before fitting its trees), so votes are counted per index and
    the winner is mapped back to its label. Returns (labels, is_tie).
    """
    n_classes = len(forest.classes_)
    tree_preds = np.array([est.predict(X).astype(int) for est in forest.estimators_])
    counts = np.array([np.bincount(tree_preds[:, j], minlength=n_classes)
                       for j in range(X.shape[0])])
    top = counts.max(axis=1, keepdims=True)
    is_tie = (counts == top).sum(axis=1) > 1
    # argmax returns the first maximum, i.e. the lowest class index.
    return forest.classes_[counts.argmax(axis=1)], is_tie


def metrics(y_true, y_pred, class_labels):
    return {
        "acc": accuracy_score(y_true, y_pred),
        "macro_f1": f1_score(y_true, y_pred, labels=class_labels,
                             average="macro", zero_division=0),
        "weighted_f1": f1_score(y_true, y_pred, labels=class_labels,
                                average="weighted", zero_division=0),
        "qwk": cohen_kappa_score(y_true, y_pred, labels=class_labels,
                                 weights="quadratic"),
    }


def stored_stats(model_dir):
    """Test-set size and soft-vote weighted F1 recorded at training time."""
    path = os.path.join(model_dir, "model_statistics.txt")
    if not os.path.exists(path):
        return None, None
    t = open(path).read()
    n_test = re.search(r"Test set size:\s*(\d+)", t)
    wf1 = re.search(r"weighted avg\s+[\d.]+\s+[\d.]+\s+([\d.]+)", t)
    return (int(n_test.group(1)) if n_test else None,
            float(wf1.group(1)) if wf1 else None)


def evaluate(model_dir, test_size, random_state):
    model_dir = os.path.abspath(model_dir)
    dataset = os.path.basename(os.path.dirname(model_dir))
    forest = joblib.load(os.path.join(model_dir, "random_forest.pkl"))
    _, X_test, _, y_test, class_labels = load_split(
        os.path.join(BASE, "data", dataset), test_size, random_state)

    soft = forest.predict(X_test).astype(int)
    hard, is_tie = hard_vote(forest, X_test)
    hard = hard.astype(int)

    row = {
        "dataset": dataset,
        "config": os.path.basename(model_dir),
        "n_test": len(y_test),
        "soft": metrics(y_test, soft, class_labels),
        "hard": metrics(y_test, hard, class_labels),
        "disagree": int((soft != hard).sum()),
        "ties": int(is_tie.sum()),
        "warnings": [],
    }

    # The split is recreated from scratch, so check it against what training
    # recorded: same test-set size and same soft-vote weighted F1 (4 decimals).
    n_test, stored_wf1 = stored_stats(model_dir)
    if n_test is not None and n_test != row["n_test"]:
        row["warnings"].append(f"test set has {row['n_test']} items, "
                               f"model_statistics.txt says {n_test}")
    if stored_wf1 is not None and abs(stored_wf1 - row["soft"]["weighted_f1"]) > 5e-5:
        row["warnings"].append(f"soft weighted F1 {row['soft']['weighted_f1']:.4f} "
                               f"!= {stored_wf1:.4f} in model_statistics.txt")
    if list(forest.classes_) != sorted(class_labels):
        row["warnings"].append(f"forest.classes_ {list(forest.classes_)} does not "
                               f"cover every class in label_mapping")
    return row


def text_table(rows):
    head = (f"{'Dataset':<18} {'Config':<7} {'Test':>5}  "
            f"{'Acc S':>6} {'Acc H':>6}  {'mF1 S':>6} {'mF1 H':>6}  "
            f"{'wF1 S':>6} {'wF1 H':>6}  {'QWK S':>6} {'QWK H':>6}  "
            f"{'Diff':>5} {'Ties':>5}")
    lines = [head, "-" * len(head)]
    for r in rows:
        s, h = r["soft"], r["hard"]
        lines.append(
            f"{r['dataset']:<18} {r['config']:<7} {r['n_test']:>5}  "
            f"{s['acc']:>6.4f} {h['acc']:>6.4f}  "
            f"{s['macro_f1']:>6.4f} {h['macro_f1']:>6.4f}  "
            f"{s['weighted_f1']:>6.4f} {h['weighted_f1']:>6.4f}  "
            f"{s['qwk']:>6.4f} {h['qwk']:>6.4f}  "
            f"{r['disagree']:>5} {r['ties']:>5}")
    lines += ["",
              "S = soft voting (sklearn forest.predict), H = hard majority voting "
              "(ties -> lowest class, as in encoding.lp).",
              "Diff = test items classified differently by the two rules; "
              "Ties = test items whose hard vote was a tie."]
    return "\n".join(lines) + "\n"


def latex_table(rows):
    L = [
        r"\begin{table}[t]",
        r"\centering",
        r"\caption{Test-set performance of the selected random forests under "
        r"soft voting (S, scikit-learn's \texttt{predict}) and hard majority "
        r"voting (H, ties broken in favour of the smallest class index). "
        r"$F_1^{M}$/$F_1^{W}$: macro/weighted $F_1$; QWK: quadratic weighted "
        r"kappa; Diff: test items classified differently by the two rules.}",
        r"\label{tab:voting-performance}",
        r"\small",
        r"\begin{tabular}{lrrrrrrrrr}",
        r"\toprule",
        r" & \multicolumn{2}{c}{Accuracy} & \multicolumn{2}{c}{$F_1^{M}$} & "
        r"\multicolumn{2}{c}{$F_1^{W}$} & \multicolumn{2}{c}{QWK} & \\",
        r"\cmidrule(lr){2-3}\cmidrule(lr){4-5}\cmidrule(lr){6-7}\cmidrule(lr){8-9}",
        r"Dataset & S & H & S & H & S & H & S & H & Diff \\",
        r"\midrule",
    ]
    for r in rows:
        s, h = r["soft"], r["hard"]
        L.append(
            f"{r['dataset']} & {s['acc']:.3f} & {h['acc']:.3f} & "
            f"{s['macro_f1']:.3f} & {h['macro_f1']:.3f} & "
            f"{s['weighted_f1']:.3f} & {h['weighted_f1']:.3f} & "
            f"{s['qwk']:.3f} & {h['qwk']:.3f} & {r['disagree']}/{r['n_test']} \\\\")
    L += [r"\bottomrule", r"\end{tabular}", r"\end{table}"]
    return "\n".join(L) + "\n"


def main():
    parser = argparse.ArgumentParser(
        description="Test-set performance under hard and soft voting.",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument("model_dirs", nargs="*",
                        help="Model dirs (models/<dataset>/t*_d*); default: all")
    parser.add_argument("--test-size", type=float, default=0.2)
    parser.add_argument("--random-state", type=int, default=42)
    args = parser.parse_args()

    model_dirs = args.model_dirs or sorted(
        glob.glob(os.path.join(BASE, "models", "*", "t*_d*")))
    rows = [evaluate(d, args.test_size, args.random_state) for d in model_dirs]

    text = text_table(rows)
    print(text)
    for r in rows:
        for w in r["warnings"]:
            print(f"[warn] {r['dataset']}/{r['config']}: {w}")

    if not args.model_dirs:
        txt_path = os.path.join(BASE, "models", "voting_performance.txt")
        tex_path = os.path.join(BASE, "models", "voting_performance_table.tex")
        open(txt_path, "w").write(text)
        open(tex_path, "w").write(latex_table(rows))
        print(f"\nWrote {txt_path}\nWrote {tex_path}")


if __name__ == "__main__":
    main()
