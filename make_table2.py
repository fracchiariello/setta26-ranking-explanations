"""
Build Table 2 of the paper: per dataset, the ASP results (first AXp and all
AXps) and the brute-force (BF) baseline, over solved instances. For the first
AXp: the number solved, the explanation size as mean and standard deviation,
and the median time (times span orders of magnitude, so a few slow pairs
dominate the mean).

ASP columns come from the newest results/explanations_pair_merged_*.json
written by merge_explanation_parts.py (or the file given as argument): a pair
is solved only when every repetition completed (all AXps: also its first AXp),
and its time is the mean over the repetitions. BF columns come from results/bruteforce/
(slurm/bruteforce_table2.sbatch), and are left out if that folder is missing.

Prints a text table and writes the LaTeX rows, in Table 2's column order, to
results/table2_rows.tex. Runs without any all-AXps result (run_explanations.py
--first-only) give the first-AXp columns only. plot_size_time.py draws the
ASP times by explanation size, and the size of the weak AXp reached by the
pairs that timed out.

Usage:
    python make_table2.py [merged.json]
"""

import glob
import json
import os
import statistics
import sys
from collections import defaultdict

from summarize_bruteforce import load as load_bruteforce

BASE = os.path.dirname(os.path.abspath(__file__))
RESULTS = os.path.join(BASE, "results")
DASH = r"\textemdash"


def mean(xs):
    xs = [x for x in xs if x is not None]
    return sum(xs) / len(xs) if xs else None


def stdev(xs):
    xs = [x for x in xs if x is not None]
    return statistics.stdev(xs) if len(xs) > 1 else None


def median(xs):
    xs = [x for x in xs if x is not None]
    return statistics.median(xs) if xs else None


def first_solved(r):
    """The first AXp was found in every repetition."""
    first = r.get("first")
    return bool(first) and first["timeout_repetitions"] == 0


def all_solved(r):
    """The first AXp was found and the enumeration completed in every
    repetition (the merged record of a partly timed-out enumeration keeps only
    its completed repetitions, so it is not marked as a timeout)."""
    a = r.get("all")
    return (first_solved(r) and bool(a)
            and a["completed_repetitions"] == a["available_repetitions"])


def asp_columns(records):
    """{dataset: dict of first/all averages over solved pairs}."""
    by_dataset = defaultdict(list)
    for r in records:
        by_dataset[r["dataset"]].append(r)
    out = {}
    for dataset, recs in by_dataset.items():
        first = [r["first"] for r in recs if first_solved(r)]
        alls = [r["all"] for r in recs if all_solved(r)]
        out[dataset] = {
            "first_solved": len(first),
            "first_size": mean([f["size"] for f in first]),
            "first_size_sd": stdev([f["size"] for f in first]),
            "first_time": median([f["time_mean_s"] for f in first]),
            "all_solved": len(alls),
            "all_size": mean([a.get("avg_size_mean", a.get("avg_size")) for a in alls]),
            "all_axps": mean([a.get("count_mean", a.get("count")) for a in alls]),
            "all_time": mean([a["time_mean_s"] for a in alls]),
        }
    return out


def bf_columns():
    """{dataset: dict of BF first/all averages}, empty without BF results."""
    bf_dir = os.path.join(RESULTS, "bruteforce")
    if not os.path.isdir(bf_dir):
        return {}
    first, all_ = load_bruteforce(bf_dir, "first"), load_bruteforce(bf_dir, "all")
    out = {}
    for dataset, rows in first.items():
        f_ok = [r for r in rows if r["solved"]]
        a_ok = [r for r in all_.get(dataset, []) if r["solved"]]
        out[dataset] = {
            "first_solved": len(f_ok),
            "first_size": mean([r["size"] for r in f_ok]),
            "first_size_sd": stdev([r["size"] for r in f_ok]),
            "first_time": median([r["time"] for r in f_ok]),
            "all_solved": len(a_ok),
            "all_size": mean([r["size"] for r in a_ok]),
            "all_time": mean([r["total"] for r in a_ok]),
        }
    return out


def fmt(v, spec, latex):
    if v is None:
        return DASH if latex else "-"
    return format(v, spec)


def fmt_sd(v, sd, latex):
    """Mean and standard deviation, the mean alone when there is no spread."""
    if v is None or sd is None:
        return fmt(v, ".1f", latex)
    return f"${v:.1f}\\pm{sd:.1f}$" if latex else f"{v:.1f}±{sd:.1f}"


def main():
    if len(sys.argv) > 1:
        merged = sys.argv[1]
    else:
        candidates = sorted(glob.glob(os.path.join(RESULTS, "explanations_pair_merged_*.json")))
        if not candidates:
            raise SystemExit("No merged results; run merge_explanation_parts.py first")
        merged = candidates[-1]
    with open(merged) as f:
        records = json.load(f)["results"]
    asp = asp_columns(records)
    bf = bf_columns()
    with_all = any(r.get("all") for r in records)

    def row(dataset, latex):
        a, b = asp[dataset], bf.get(dataset, {})
        cells = [fmt(a["first_solved"], "d", latex), fmt_sd(a["first_size"], a["first_size_sd"], latex),
                 fmt(a["first_time"], ".1f", latex)]
        if bf:
            cells += [fmt(b.get("first_solved"), "d", latex),
                      fmt_sd(b.get("first_size"), b.get("first_size_sd"), latex),
                      fmt(b.get("first_time"), ".1f", latex)]
        if not with_all:
            return cells
        cells += [fmt(a["all_solved"], "d", latex), fmt(a["all_size"], ".1f", latex),
                  fmt(a["all_axps"], ".1f", latex), fmt(a["all_time"], ".3f", latex)]
        if bf:
            cells += [fmt(b.get("all_solved"), "d", latex), fmt(b.get("all_size"), ".1f", latex),
                      fmt(b.get("all_time"), ".3f", latex)]
        return cells

    datasets = sorted(asp)
    names = {d: d.replace("+", " ") for d in datasets}
    header = (["Solved", "Size", "Med. time"]
              + (["BF solved", "BF size", "BF med."] if bf else []))
    if with_all:
        header += ["Solved", "Size", "#AXps", "Time"] + (["BF solved", "BF size", "BF time"] if bf else [])
    print(f"Merged results: {os.path.relpath(merged, BASE)}"
          f"{'' if bf else '  (no results/bruteforce: BF columns left out)'}\n")
    print(f"{'Dataset':<18}" + "".join(f"{h:>12}" for h in header))
    for d in datasets:
        print(f"{names[d]:<18}" + "".join(f"{c:>12}" for c in row(d, latex=False)))

    tex = "\n".join(f"{names[d]:<17} & " + " & ".join(row(d, latex=True)) + r" \\" for d in datasets)
    out = os.path.join(RESULTS, "table2_rows.tex")
    with open(out, "w") as f:
        f.write(tex + "\n")
    print(f"\nWrote {os.path.relpath(out, BASE)}")


if __name__ == "__main__":
    main()
