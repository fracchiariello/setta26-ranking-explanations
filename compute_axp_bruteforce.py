"""
Compute AXps (abductive explanations) by brute force.

Usage:
    python compute_axp_bruteforce.py <program.lp> [<program2.lp> ...] [--pkl model.pkl]

Pipeline:

1. LABEL all bin combinations with clingo: the forest facts and the pair facts
   are combined with the traversal/vote rules and a probe item 0 whose bins
   are free; enumerating all answer sets yields, for every combination, its
   majority-vote class with ties broken to the LOWEST class (a single
   prediction atom), plus topvote/2 recording the tie set so ties are tracked
   in the output. Each combination is also labelled with same-1/same-2: the
   features on which it has the same bin as item 1 / item 2.

2. LABEL the same combinations with the trained sklearn model
   (random_forest.pkl, auto-detected next to the input .lp files or given via
   --pkl): bins are converted to feature values via split_points.json (same
   midpoint convention as utils/generate_items.py) and per-tree votes are
   aggregated with the same hard-vote, lowest-class tie-break semantics. The
   two labelings are checked for compliance; any disagreement is reported.

3. For every subset S of the candidate features, the verdict is determined by
   the COUNT of counterexamples derived from the label table: the item-3
   candidates are the combinations with same-1 >= S, the item-4 candidates
   those with same-2 >= S, and every pair where the former's classes all
   exceed the latter's is a counterexample (count shown in product form).

       count > 0  -> SAT   (S does not force the class order)
       count = 0  -> UNSAT (S is sufficient)

   Each verdict is cross-checked by solving the original ASP program
   (encoding.lp constraint) with selected(f). facts for S; mismatches are
   flagged.

An AXp is a subset-minimal sufficient set: count = 0, but every proper subset
has count > 0. This is the same notion computed by compute_mus.py via
wasp --mus, here obtained by exhaustive enumeration as a ground-truth check.

Candidate features are derived from the bin/3 facts in the input files,
exactly as in compute_mus.py.
"""

import argparse
import json
import os
import re
import subprocess
import sys
from collections import Counter
from itertools import combinations


# Atoms to extract from the models
SHOW_DIRECTIVES = "#show bin/3.\n#show prediction/2.\n#show class/3.\n#show topvote/2.\n"

# Mirrors the reasoning section of encoding.lp (traversal + majority voting,
# vote ties broken to the LOWEST class), without the explanation part (items 3
# and 4 and the class-order constraint). item 0 is a probe whose bins are left
# free by the forest choice rules, so enumerating all answer sets labels every
# bin combination with its prediction.
#
# topvote(I,C): every class sharing the maximum vote count (the tie set, before
# the lowest-class break). prediction(I,C) is the single resolved class; when
# topvote has more than one C for an item, that item's vote was a tie.
TRAVERSAL_RULES = """
next_node(I,T,0) :- item(I), tree(T).
next_node(I,T,N2) :- next_node(I,T,N1), node(T,N1,F,B), bin(I,F,Bv), Bv <= B, left_node(T,N1,N2).
next_node(I,T,N2) :- next_node(I,T,N1), node(T,N1,F,B), bin(I,F,Bv), Bv > B,  right_node(T,N1,N2).
class(I,T,C) :- next_node(I,T,N), leaf_class(T,N,C).
vote(I,C,V) :- item(I), class_idx(C), V = #count{T : class(I,T,C)}.
max_votes(I,M) :- item(I), M = #max{V : vote(I,_,V)}.
topvote(I,C) :- max_votes(I,M), vote(I,C,M).
prediction(I,C) :- max_votes(I,M), C = #min{C2 : vote(I,C2,M)}.
item(0).
"""


def run_clingo(program: str, all_models: bool = False):
    """Run clingo on the program.

    Returns (True, models) if SAT — models is the list of answer sets as
    strings (all of them when all_models, projected onto the shown atoms;
    otherwise just the first) — or (False, []) if UNSAT.
    """
    cmd = ["clingo", "-n0", "--project", "-"] if all_models else ["clingo", "-n1", "-"]
    proc = subprocess.Popen(
        cmd, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE,
    )
    stdout, stderr = proc.communicate(input=(program + "\n" + SHOW_DIRECTIVES).encode())
    # clingo exit codes: 10 = SAT, 20 = UNSAT, 30 = SAT (all models enumerated)
    if proc.returncode in (10, 30):
        lines = stdout.decode().splitlines()
        models = [lines[i + 1] for i, l in enumerate(lines) if l.startswith("Answer:")]
        return True, models
    if proc.returncode == 20:
        return False, []
    print(f"[clingo stderr]\n{stderr.decode()}", file=sys.stderr)
    raise RuntimeError(f"clingo exited with unexpected code {proc.returncode}")


def parse_model_atoms(model: str, items: tuple):
    """Extract bins, per-tree decisions, the resolved prediction, and the tie set.

    Returns (bins, tree_class, pred, topvote):
      pred[i]    : the single resolved class (vote tie broken to lowest class);
      topvote[i] : sorted list of classes sharing the max vote count (the tie
                   set). len > 1 means item i's forest vote was a tie.
    """
    bins = {i: {} for i in items}
    for i, f, b in re.findall(r"bin\((\d+),(\d+),(\d+)\)", model):
        if int(i) in bins:
            bins[int(i)][int(f)] = int(b)
    tree_class = {i: {} for i in items}
    for i, t, c in re.findall(r"class\((\d+),(\d+),(\d+)\)", model):
        if int(i) in tree_class:
            tree_class[int(i)][int(t)] = int(c)
    pred = {i: None for i in items}
    for i, c in re.findall(r"prediction\((\d+),(\d+)\)", model):
        if int(i) in pred:
            pred[int(i)] = int(c)
    topvote = {i: [] for i in items}
    for i, c in re.findall(r"topvote\((\d+),(\d+)\)", model):
        if int(i) in topvote:
            topvote[int(i)].append(int(c))
    topvote = {i: sorted(cs) for i, cs in topvote.items()}
    return bins, tree_class, pred, topvote


def parse_feature_info(program: str) -> dict:
    """Extract feature names and split thresholds from random_forest.lp comments.

    Matches lines like:
        % Feature 2 (glucose): 4 bins  (thresholds: [125.5, 172.15, 178.75])
    Returns {feat_idx: (name, [thresholds])}.
    """
    info = {}
    for f, name, ts in re.findall(
            r"% Feature (\d+) \(([^)]+)\):.*thresholds: \[([^\]]*)\]", program):
        info[int(f)] = (name, [float(t) for t in ts.split(",")])
    return info


def fmt(t: float) -> str:
    """Trim float32 noise from a threshold for display."""
    return f"{round(t, 2):g}"


def describe_bin(feat: int, b: int, feat_info: dict) -> str:
    """Human-readable value interval covered by bin b of a feature."""
    if feat not in feat_info:
        return f"f{feat}={b}"
    name, ts = feat_info[feat]
    if b == 0:
        return f"{name} <= {fmt(ts[0])}"
    if b == len(ts):
        return f"{name} > {fmt(ts[-1])}"
    return f"{name} in ({fmt(ts[b - 1])}, {fmt(ts[b])}]"


def class_str(resolved: int, topvote) -> str:
    """Resolved class, annotated with the vote tie it was broken from.

    topvote is the list of classes sharing the max vote count. When it has more
    than one element the vote was a tie; show it as e.g. "2 (tie 0|2 -> 2)".
    """
    if topvote is None or len(topvote) <= 1:
        return str(resolved)
    return f"{resolved} (tie {'|'.join(map(str, topvote))} -> {resolved})"


def column_widths(table: list, feats: list, feat_info: dict) -> dict:
    """Widest bin description per feature, for column-aligned output."""
    return {f: max(len(describe_bin(f, bins[f], feat_info)) for bins, *_ in table)
            for f in feats}


def format_combo(bins: dict, feats: list, feat_info: dict, widths: dict) -> str:
    """Render a bin combination as one row with column-aligned features."""
    cells = []
    for idx, f in enumerate(feats):
        d = describe_bin(f, bins[f], feat_info)
        if idx < len(feats) - 1:
            cells.append(f"{d + ',':<{widths[f] + 2}}")
        else:
            cells.append(f"{d:<{widths[f]}}")
    return "[" + "".join(cells) + "]"


def format_items(model: str, items: tuple, feat_info: dict, indent: str = "  ") -> str:
    """Render the given items from a model: bin values, per-tree decisions, prediction."""
    bins, tree_class, pred, topvote = parse_model_atoms(model, items)
    lines = []
    for i in items:
        bs = ", ".join(describe_bin(f, b, feat_info) for f, b in sorted(bins[i].items()))
        trees = ", ".join(f"tree {t} -> {c}" for t, c in sorted(tree_class[i].items()))
        cls = class_str(pred[i], topvote[i]) if pred[i] is not None else "?"
        lines.append(f"{indent}item {i}: {bs}")
        lines.append(f"{indent}        {trees}  =>  class {cls}")
    return "\n".join(lines)


class PklLabeler:
    """Label bin combinations directly with the sklearn forest.

    Bins are converted to feature values with the same midpoint convention as
    utils/generate_items.py. The label is the MAJORITY-VOTE class: each tree
    predicts one class (its leaf's argmax), the votes are counted, and ties are
    broken to the LOWEST class index — matching the ASP encoding's
    prediction(I,C) = #min{C2 : vote(I,C2,M)}. (Not forest.predict(), which is
    soft voting; this tool validates the hard-vote encoding.)
    """

    def __init__(self, pkl_path: str, split_points_path: str):
        import joblib
        self.np = __import__("numpy")
        self.forest = joblib.load(pkl_path)
        with open(split_points_path) as f:
            raw = json.load(f)
        self.split_points = {int(k): sorted(float(t) for t in v) for k, v in raw.items()}
        self.classes = list(self.forest.classes_)

    def _vector(self, bins: dict):
        x = self.np.zeros(self.forest.n_features_in_)
        for f, b in bins.items():
            ts = self.split_points[f]
            if b == 0:
                x[f] = ts[0] - 1.0
            elif b == len(ts):
                x[f] = ts[-1] + 1.0
            else:
                x[f] = (ts[b - 1] + ts[b]) / 2.0
        return x

    def labels(self, bin_dicts: list):
        """For each bin assignment, (resolved_class, topvote) under hard voting.

        resolved_class is the most-voted class with ties broken to the lowest
        index; topvote is the sorted list of classes sharing the max vote count.
        """
        X = self.np.array([self._vector(b) for b in bin_dicts])
        n_classes = len(self.classes)
        # Per-tree predicted class for every sample: (n_trees, n_samples).
        tree_preds = self.np.array([est.predict(X).astype(int) for est in self.forest.estimators_])
        out = []
        for j in range(X.shape[0]):
            counts = self.np.bincount(tree_preds[:, j], minlength=n_classes)
            mx = counts.max()
            top = [int(self.classes[c]) for c in range(n_classes) if counts[c] == mx]
            out.append((min(top), sorted(top)))
        return out


def print_compliant(rows1: list, rows2: list, feats: list, feat_info: dict, widths: dict):
    """Print the combinations compliant with item 1 and item 2 for a subset.

    Each combination has a single resolved class (vote ties broken to the
    lowest class). On the item-1 side the max class is selected (best
    candidate for item 3), on the item-2 side the min class (best item-4).
    """
    best1 = max(cls for _, cls, _ in rows1)
    best2 = min(cls for _, cls, _ in rows2)
    cls_w = max(len(class_str(cls, tv)) for rows in (rows1, rows2) for _, cls, tv in rows)
    for item, rows, best, side in ((1, rows1, best1, "max"), (2, rows2, best2, "min")):
        print(f"      compliant with item {item} ({len(rows)}), {side} class = {best}:")
        for bins, cls, tv in sorted(rows, key=lambda r: tuple(r[0][f] for f in feats)):
            combo = format_combo(bins, feats, feat_info, widths)
            mark = f"   <== {side}" if cls == best else ""
            print(f"        {combo} => class {class_str(cls, tv):<{cls_w}}{mark}".rstrip())


def main():
    parser = argparse.ArgumentParser(
        description="Compute AXps by brute force: test every combination of selected features."
    )
    parser.add_argument("files", nargs="+", help="ASP files to concatenate")
    parser.add_argument("--pkl", help="Path to random_forest.pkl (default: auto-detect "
                                      "next to the input files; split_points.json must sit beside it)")
    args = parser.parse_args()

    contents = []
    for path in args.files:
        with open(path) as f:
            contents.append(f.read())

    program = "\n".join(contents)

    # Derive candidate features from bin/3 facts present in the program
    feats = sorted(set(int(f) for f in re.findall(r"bin\(\s*\d+\s*,\s*(\d+)\s*,\s*\d+\s*\)\.", program)))
    n = len(feats)

    feat_info = parse_feature_info(program)

    # Bins of the input pair (fixed facts in the pair file)
    pair_bins = {1: {}, 2: {}}
    for i, f, b in re.findall(r"bin\((1|2)\s*,\s*(\d+)\s*,\s*(\d+)\s*\)\.", program):
        pair_bins[int(i)][int(f)] = int(b)

    # --- Step 1: label all bin combinations with clingo ---
    # Forest facts + pair facts + traversal rules + free probe item 0;
    # exclude the encoding file (it defines items 3/4 and the constraint).
    label_program = "\n".join(c for c in contents if "next_node" not in c) + TRAVERSAL_RULES
    sat, label_models = run_clingo(label_program, all_models=True)
    if not sat:
        raise RuntimeError("labeling program is UNSAT — check the input files")

    print("Input pair:")
    print(format_items(label_models[0], (1, 2), feat_info))
    print()

    # table: (bins, same1, same2, cls, topvote) per combination
    # cls is the single resolved class; topvote is the vote tie set (len > 1 => tie).
    table = []
    for m in label_models:
        bins, _, pred, topvote = parse_model_atoms(m, (0,))
        b0 = bins[0]
        same1 = frozenset(f for f in feats if b0.get(f) == pair_bins[1].get(f))
        same2 = frozenset(f for f in feats if b0.get(f) == pair_bins[2].get(f))
        table.append((b0, same1, same2, pred[0], topvote[0]))
    print(f"clingo labelled {len(table)} bin combinations.")
    n_ties = sum(1 for *_, tv in table if len(tv) > 1)
    print(f"{n_ties} of them are vote ties (broken to the lowest class).")

    # --- Step 2: label the same combinations with the pkl model and compare ---
    pkl_path = args.pkl
    if pkl_path is None:
        for path in args.files:
            cand = os.path.join(os.path.dirname(os.path.abspath(path)), "random_forest.pkl")
            if os.path.exists(cand):
                pkl_path = cand
                break
    labeler = None
    if pkl_path:
        sp_path = os.path.join(os.path.dirname(os.path.abspath(pkl_path)), "split_points.json")
        if os.path.exists(sp_path):
            labeler = PklLabeler(pkl_path, sp_path)
        else:
            print(f"split_points.json not found next to {pkl_path}; skipping pkl labeling")
    else:
        print("random_forest.pkl not found; skipping pkl labeling")

    widths = column_widths(table, feats, feat_info)

    if labeler is not None:
        pkl_labels = labeler.labels([bins for bins, *_ in table])
        bad = [(bins, cls, tv, pcls, ptv)
               for (bins, _, _, cls, tv), (pcls, ptv) in zip(table, pkl_labels)
               if (cls, tv) != (pcls, ptv)]
        if bad:
            print(f"!! clingo and pkl labels DISAGREE on {len(bad)} combination(s):")
            for bins, cls, tv, pcls, ptv in bad:
                combo = format_combo(bins, feats, feat_info, widths)
                print(f"  {combo}: clingo {class_str(cls, tv)} vs pkl {class_str(pcls, ptv)}")
        else:
            print(f"clingo and pkl labels are compliant on all {len(table)} combinations.")
    print()

    print(f"Candidate features: {feats}")
    print(f"Testing all 2^{n} = {2**n} subsets...\n")

    # --- Step 3: decide each subset by its counterexample count ---
    results = {}  # subset (tuple) -> True if sufficient (count = 0)
    mismatches = []
    for k in range(n + 1):
        for subset in combinations(feats, k):
            s = set(subset)
            rows1 = [(bins, cls, tv) for bins, s1, _, cls, tv in table if s <= s1]
            rows2 = [(bins, cls, tv) for bins, _, s2, cls, tv in table if s <= s2]

            # Counterexamples as a product: any item-3 candidate of class d
            # paired with any item-4 candidate of class c < d. With deterministic
            # prediction each combination contributes its single resolved class.
            n3 = Counter(cls for _, cls, _ in rows1)
            n4 = Counter(cls for _, cls, _ in rows2)
            terms = [(d, c, n3[d] * n4[c]) for d in sorted(n3) for c in sorted(n4) if d > c]
            total = sum(t for _, _, t in terms)
            sat = total > 0
            results[subset] = not sat

            # Cross-check: solve the original program with the selected facts
            facts = "\n".join(f"selected({f})." for f in subset)
            clingo_sat, _ = run_clingo(program + "\n" + facts)
            note = f"  [clingo check: {'SAT' if clingo_sat else 'UNSAT'}]"
            if clingo_sat != sat:
                note += "  !! MISMATCH"
                mismatches.append(subset)

            label = f"{{{', '.join(map(str, subset)) or ' '}}}"
            status = "SAT" if sat else "UNSAT (sufficient)"
            print(f"  {label}: {status}{note}")
            print_compliant(rows1, rows2, feats, feat_info, widths)
            prod = " + ".join(f"{n3[d]}x{n4[c]} [{d}>{c}]" for d, c, _ in terms)
            detail = f" = {prod}" if terms else ""
            print(f"      counterexamples: {total}{detail}  =>  {status}")

    # AXps = subset-minimal sufficient sets: count 0, no proper subset with count 0
    axps = []
    for subset, sufficient in results.items():
        if not sufficient:
            continue
        if any(results[sub] for k in range(len(subset))
               for sub in combinations(subset, k)):
            continue  # a proper subset is already sufficient -> not minimal
        axps.append(list(subset))

    if mismatches:
        print(f"\n!! count-based and clingo verdicts DISAGREE on {len(mismatches)} subset(s): "
              f"{[list(s) for s in mismatches]}")
    else:
        print("\ncount-based and clingo verdicts agree on all subsets.")

    if not axps:
        print("\nNo AXp found (no subset of features is sufficient).")
    else:
        print(f"\nFound {len(axps)} AXp(s):\n")
        for i, axp in enumerate(axps, 1):
            print(f"  AXp #{i}: selected features = {axp}")


if __name__ == "__main__":
    main()
