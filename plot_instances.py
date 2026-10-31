"""
Draw Figure 4 of the paper: per-instance explanation results, grouped by
dataset, from the newest results/explanations_pair_merged_*.json written by
merge_explanation_parts.py (or the file given as argument).

Runs with one AXp per pair (run_explanations.py --first-only): (a) time to
the AXp, with timeouts as triangles on the timeout line; (b) AXp size, and for
timeouts, as triangles, the size of the weak AXp the deletion had reached.
Writes results/instance_plots.png and .pdf.

Runs with all AXps: (a) time to the first AXp; (b) time to enumerate all AXps,
with enumeration timeouts as triangles on the timeout line; (c) average AXp
size, triangles for partial enumerations; (d) number of AXps, triangles for
lower bounds from partial enumerations. Pairs whose first AXp timed out in some
repetition have no result and are omitted; an enumeration that timed out in
some repetition is drawn as a timeout (the rule of make_table2.py). Writes
results/four_panel_instance_plots.png and .pdf.

A pair counts as solved only if every repetition finished.

Usage:
    python plot_instances.py [merged.json] [--timeout-first 3600] [--timeout-all 18000]
"""

import argparse
import glob
import json
import os

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt  # noqa: E402

from make_table2 import all_solved, first_solved  # noqa: E402

BASE = os.path.dirname(os.path.abspath(__file__))
RESULTS = os.path.join(BASE, "results")


def load(path):
    if path is None:
        candidates = sorted(glob.glob(os.path.join(RESULTS, "explanations_pair_merged_*.json")))
        if not candidates:
            raise SystemExit("No merged results; run merge_explanation_parts.py first")
        path = candidates[-1]
    with open(path) as f:
        return path, json.load(f)["results"]


def pair_index(name):
    return int(name.split("_")[1].split(".")[0])


def dataset_axes(axes, datasets, pairs_per_dataset):
    """Dataset separators, limits and x tick positions shared by every panel."""
    for ax in axes:
        for i in range(1, len(datasets)):
            ax.axvline(i * pairs_per_dataset, linestyle=":", linewidth=0.6, color="C9", alpha=0.7)
        ax.grid(axis="y", which="both", linewidth=0.4, alpha=0.4)
        ax.set_xlim(0, len(datasets) * pairs_per_dataset)
        ax.set_xticks([(i + 0.5) * pairs_per_dataset for i in range(len(datasets))])


def plot_single(path, records, timeout):
    """Figure for runs with one AXp per pair: time and size."""
    datasets = sorted({r["dataset"] for r in records})
    pairs_per_dataset = max(pair_index(r["pair"]) for r in records) + 1
    x_of = {d: i * pairs_per_dataset for i, d in enumerate(datasets)}
    pts = {key: ([], []) for key in ("time", "time_to", "size", "size_weak")}

    def add(key, x, y):
        if y is not None:
            pts[key][0].append(x)
            pts[key][1].append(y)

    for r in records:
        first = r.get("first")
        if not first:
            continue
        x = x_of[r["dataset"]] + pair_index(r["pair"]) + 0.5
        if first_solved(r):
            add("time", x, first.get("time_mean_s"))
            add("size", x, first.get("size"))
        else:
            add("time_to", x, timeout)
            if first.get("weak_axp"):
                add("size_weak", x, len(first["weak_axp"]))

    fig, (ax_a, ax_b) = plt.subplots(2, 1, figsize=(12.3, 6.4), sharex=True)
    style = dict(s=8, color="C0", zorder=3, linewidths=0)
    ax_a.scatter(*pts["time"], marker="o", label="Solved", **style)
    ax_a.scatter(*pts["time_to"], marker="^", s=18, color="C3", zorder=3, linewidths=0,
                 label="Timeout")
    ax_a.axhline(timeout, linestyle="--", linewidth=0.8, color="C3")
    ax_b.scatter(*pts["size"], marker="o", label="Abductive explanation", **style)
    ax_b.scatter(*pts["size_weak"], marker="^", s=18, color="C3", zorder=3, linewidths=0,
                 label="Weak explanation at the timeout")
    ax_a.set_title("(a) Time to compute an abductive explanation")
    ax_a.set_ylabel("Time (s)")
    ax_a.set_yscale("log")
    ax_a.yaxis.set_minor_formatter(matplotlib.ticker.NullFormatter())
    ax_b.set_title("(b) Explanation size")
    ax_b.set_ylabel("Features")
    dataset_axes((ax_a, ax_b), datasets, pairs_per_dataset)
    ax_a.legend(loc="lower right", fontsize=8)
    ax_b.legend(loc="upper right", fontsize=8)
    ax_b.set_xticklabels([d.replace("+", " ") for d in datasets], rotation=35, ha="right", fontsize=8)
    ax_b.set_xlabel(f"Dataset (instances 1–{pairs_per_dataset} ordered from left to right "
                    "within each group)")
    fig.tight_layout()

    os.makedirs(RESULTS, exist_ok=True)
    out = os.path.join(RESULTS, "instance_plots")
    fig.savefig(out + ".png", dpi=300)
    fig.savefig(out + ".pdf")
    print(f"Read {os.path.relpath(path, BASE)} ({len(records)} pairs)\n"
          f"Wrote {os.path.relpath(out, BASE)}.png and .pdf")


def main():
    parser = argparse.ArgumentParser(description="Draw the per-instance results figure.")
    parser.add_argument("merged", nargs="?", help="Merged JSON (default: newest in results/)")
    parser.add_argument("--timeout-first", type=float, default=3600,
                        help="First-AXp timeout in seconds, drawn as a line in panel (a) "
                             "of the one-AXp figure")
    parser.add_argument("--timeout-all", type=float, default=18000,
                        help="All-AXps timeout in seconds, drawn as a line in panel (b)")
    args = parser.parse_args()
    path, records = load(args.merged)
    if not any(r.get("all") for r in records):
        plot_single(path, records, args.timeout_first)
        return

    datasets = sorted({r["dataset"] for r in records})
    pairs_per_dataset = max(pair_index(r["pair"]) for r in records) + 1
    x_of = {d: i * pairs_per_dataset for i, d in enumerate(datasets)}
    pts = {key: ([], []) for key in ("first", "all_done", "all_to", "size_done", "size_part",
                                     "count_done", "count_part")}

    def add(key, x, y):
        if y is not None:
            pts[key][0].append(x)
            pts[key][1].append(y)

    for r in records:
        first = r.get("first")
        if not first_solved(r):
            continue
        x = x_of[r["dataset"]] + pair_index(r["pair"]) + 0.5
        add("first", x, first.get("time_mean_s"))
        a = r.get("all")
        if not a:
            continue
        if not all_solved(r):
            add("all_to", x, args.timeout_all)
            add("size_part", x, a.get("avg_size"))
            add("count_part", x, a.get("count"))
        else:
            add("all_done", x, a.get("time_mean_s"))
            add("size_done", x, a.get("avg_size_mean", a.get("avg_size")))
            add("count_done", x, a.get("count_mean", a.get("count")))

    fig, axes = plt.subplots(2, 2, figsize=(12.3, 7.45))
    (ax_a, ax_b), (ax_c, ax_d) = axes
    style = dict(s=22, color="C0", zorder=3)
    ax_a.scatter(*pts["first"], marker="o", **style)
    ax_b.scatter(*pts["all_done"], marker="o", label="Completed", **style)
    ax_b.scatter(*pts["all_to"], marker="^", s=40, color="C0", zorder=3, label="Enumeration timeout")
    ax_b.axhline(args.timeout_all, linestyle="--", linewidth=0.8, color="C0")
    ax_c.scatter(*pts["size_done"], marker="o", label="Complete enumeration", **style)
    ax_c.scatter(*pts["size_part"], marker="^", s=40, color="C0", zorder=3, label="Partial enumeration")
    ax_d.scatter(*pts["count_done"], marker="o", label="Exact count", **style)
    ax_d.scatter(*pts["count_part"], marker="^", s=40, color="C0", zorder=3, label="Lower bound")

    titles = ["(a) Time to first explanation", "(b) Time to enumerate all explanations",
              "(c) Average explanation size", "(d) Number of abductive explanations"]
    ylabels = ["Time (s)", "Time (s)", "Average size", "Number of AXps"]
    for ax, title, ylabel in zip(axes.flat, titles, ylabels):
        ax.set_title(title)
        ax.set_ylabel(ylabel)
        for i in range(1, len(datasets)):
            ax.axvline(i * pairs_per_dataset, linestyle=":", linewidth=0.6, color="C9", alpha=0.7)
        ax.grid(axis="y", which="both", linewidth=0.4, alpha=0.4)
        ax.set_xlim(0, len(datasets) * pairs_per_dataset)
    for ax in (ax_a, ax_b, ax_d):
        ax.set_yscale("log")
        ax.yaxis.set_minor_formatter(matplotlib.ticker.NullFormatter())
    # Legends placed where no points fall.
    ax_b.legend(loc="center right", fontsize=8)
    ax_c.legend(loc="upper left", fontsize=8)
    ax_d.legend(loc="upper center", ncol=2, fontsize=8)
    centers = [x_of[d] + pairs_per_dataset / 2 for d in datasets]
    for ax in axes.flat:
        ax.set_xticks(centers)
        ax.set_xlabel(f"Dataset (instances 1–{pairs_per_dataset} ordered from left to right "
                      "within each group)")
    for ax in axes[0]:
        ax.tick_params(axis="x", labelbottom=False)
    for ax in axes[1]:
        ax.set_xticklabels([d.replace("+", " ") for d in datasets], rotation=35, ha="right", fontsize=8)
    fig.suptitle("Per-instance explanation results across datasets")
    fig.tight_layout()

    os.makedirs(RESULTS, exist_ok=True)
    out = os.path.join(RESULTS, "four_panel_instance_plots")
    fig.savefig(out + ".png", dpi=300)
    fig.savefig(out + ".pdf")
    print(f"Read {os.path.relpath(path, BASE)} ({len(records)} pairs)\n"
          f"Wrote {os.path.relpath(out, BASE)}.png and .pdf")


if __name__ == "__main__":
    main()
