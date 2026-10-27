"""
Summarise the brute-force Table 2 runs (slurm/bruteforce_table2.sbatch) in the
layout of Table 2: per dataset, the first-AXp and all-AXps columns, averaged
over solved pairs.

Usage:
    python summarize_bruteforce.py [results_dir]     (default: results/bruteforce)
"""

import glob
import json
import os
import re
import sys
from collections import defaultdict

BASE = os.path.dirname(os.path.abspath(__file__))


def load(results_dir, mode):
    """{dataset: [row, ...]} from <mode>_<dataset>_pair<k>.json files."""
    out = defaultdict(list)
    for path in glob.glob(os.path.join(results_dir, f"{mode}_*_pair*.json")):
        # Skips files of earlier runs, named ..._pair<k>_t<timeout>.json.
        m = re.match(rf"{mode}_(.+)_pair\d+\.json$", os.path.basename(path))
        if m:
            out[m.group(1)].extend(json.load(open(path))[0]["rows"])
    return out


def mean(rows, key):
    return sum(r[key] for r in rows) / len(rows)


def main():
    results_dir = sys.argv[1] if len(sys.argv) > 1 else os.path.join(BASE, "results", "bruteforce")
    first, all_ = load(results_dir, "first"), load(results_dir, "all")
    lines = [f"{'':<18}{'First solution':^30}{'All solutions':^40}",
             f"{'Dataset':<18}{'Solved':>8}{'Avg size':>10}{'Avg time':>12}"
             f"{'Solved':>9}{'Avg size':>10}{'Avg #AXps':>11}{'Avg time':>12}",
             "-" * 90]
    for dataset in sorted(first):
        f_rows = first[dataset]
        f_ok = [r for r in f_rows if r["solved"]]
        a_ok = [r for r in all_.get(dataset, []) if r["solved"]]
        line = f"{dataset.replace('+', ' '):<18}{len(f_ok):>5}/{len(f_rows):<2}"
        line += (f"{mean(f_ok, 'size'):>10.1f}{mean(f_ok, 'time'):>12.3f}" if f_ok
                 else f"{'-':>10}{'-':>12}")
        line += f"{len(a_ok):>6}/{len(f_rows):<2}"
        line += (f"{mean(a_ok, 'size'):>10.1f}{mean(a_ok, 'axps'):>11.1f}"
                 f"{mean(a_ok, 'total'):>12.3f}" if a_ok else f"{'-':>10}{'-':>11}{'-':>12}")
        lines.append(line)
    reasons = defaultdict(int)
    for rows in all_.values():
        for r in rows:
            if not r["solved"]:
                reasons[r["reason"]] += 1
    lines += ["", "Times in seconds, averaged over solved pairs; one repetition. All solutions are",
              "attempted only for pairs whose first solution was found (as in Table 2).",
              f"All-solutions failures: {dict(reasons) or 'none'} "
              f"(memory = too many agreement patterns to enumerate)."]
    print("\n".join(lines))


if __name__ == "__main__":
    main()
