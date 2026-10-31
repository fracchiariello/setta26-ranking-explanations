"""
Draw the explanation-size figure of the paper: for every dataset, the time to
compute an AXp against its number of free features (the features not in the
AXp), from the newest results/explanations_pair_merged_*.json written by
merge_explanation_parts.py (or the file given as argument).

One panel per dataset, with a shared logarithmic time axis. For every number
of free features, a circle at the median time of the AXps with that many, its
area proportional to their number, and a whisker from the fastest to the
slowest; a thin line joins the medians. A second line gives the median time of
the solver calls that proved a candidate sufficient (unsatisfiable query) with
that many free features, over the first repetition of every pair: the cost of
these proofs grows steeply with the free features and makes the pairs with
small AXps the slow ones. The first call of a run, with every feature fixed, is
left out, as it also pays the solver's start-up. Pairs that timed out are
triangles on the timeout line, at the free features of the weak AXp their
deletion had reached (the AXp would have at least as many). A pair counts as
solved only if every repetition finished (the rule of make_table2.py).

Writes results/size_time.png and .pdf.

Usage:
    python plot_size_time.py [merged.json] [--timeout-first 3600]
"""

import argparse
import os
import statistics
from collections import defaultdict

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt  # noqa: E402
from matplotlib.lines import Line2D  # noqa: E402
from matplotlib.ticker import MaxNLocator, NullLocator  # noqa: E402

from make_table2 import first_solved  # noqa: E402
from plot_instances import BASE, RESULTS, load  # noqa: E402

SOLVED = "#2a78d6"     # categorical slot 1 of the reference palette
TIMEOUT = "#eb6834"    # categorical slot 2
CHECK = "#1baf7a"      # categorical slot 3
INK = "#52514e"        # secondary text
GRID = "#d9d8d4"


def area(n):
    """Marker area (points^2) for n explanations."""
    return 4 + 1.6 * n


def main():
    parser = argparse.ArgumentParser(description="Draw the explanation-size figure.")
    parser.add_argument("merged", nargs="?", help="Merged JSON (default: newest in results/)")
    parser.add_argument("--timeout-first", type=float, default=3600,
                        help="First-AXp timeout in seconds, drawn as a line in every panel")
    args = parser.parse_args()
    path, records = load(args.merged)

    times = defaultdict(lambda: defaultdict(list))     # dataset -> free features -> times
    timeouts = defaultdict(lambda: defaultdict(int))   # dataset -> free features reached -> count
    checks = defaultdict(lambda: defaultdict(list))    # dataset -> free features -> proof times
    for r in records:
        first = r.get("first")
        if not first:
            continue
        d, n = r["dataset"], r["n_features"]
        if first_solved(r):
            times[d][n - first["size"]].append(first["time_mean_s"])
        else:
            timeouts[d][n - len(first.get("weak_axp") or ())] += 1
        runs = first.get("call_log") or []
        for size, unsat, seconds in (runs[0]["calls"] if runs else []):
            if unsat and size < n:
                checks[d][n - size].append(seconds)

    plt.rcParams.update({"font.size": 7, "axes.titlesize": 6, "axes.labelsize": 7,
                         "xtick.labelsize": 6, "ytick.labelsize": 6, "legend.fontsize": 6})
    datasets = sorted(set(times) | set(timeouts))
    ncols = 5
    nrows = -(-len(datasets) // ncols)
    fig, axes = plt.subplots(nrows, ncols, figsize=(5.6, 0.85 * nrows + 0.42),
                             sharey=True, squeeze=False)
    for ax in axes.flat[len(datasets):]:
        ax.set_visible(False)

    for ax, d in zip(axes.flat, datasets):
        free = sorted(checks[d])
        ax.plot(free, [statistics.median(checks[d][k]) for k in free], color=CHECK,
                linewidth=0.8, marker="D", markersize=1.8, zorder=2.5)
        sizes = sorted(times[d])
        med = [statistics.median(times[d][s]) for s in sizes]
        ax.vlines(sizes, [min(times[d][s]) for s in sizes], [max(times[d][s]) for s in sizes],
                  color=SOLVED, alpha=0.45, linewidth=0.8, zorder=2)
        ax.plot(sizes, med, color=SOLVED, linewidth=0.7, alpha=0.7, zorder=2)
        ax.scatter(sizes, med, s=[area(len(times[d][s])) for s in sizes], color=SOLVED,
                   edgecolors="white", linewidths=0.4, zorder=3)
        if timeouts[d]:
            weak = sorted(timeouts[d])
            ax.scatter(weak, [args.timeout_first] * len(weak),
                       s=[area(timeouts[d][s]) for s in weak], marker="^", color=TIMEOUT,
                       edgecolors="white", linewidths=0.4, zorder=3)
        ax.axhline(args.timeout_first, linestyle="--", linewidth=0.6, color=INK, alpha=0.6)
        ax.set_title(d.replace("+", " "), pad=2, color="#0b0b0b")
        ax.set_yscale("log")
        ax.yaxis.set_minor_locator(NullLocator())
        ax.xaxis.set_major_locator(MaxNLocator(integer=True, nbins=4))
        all_sizes = sizes + sorted(timeouts[d]) + free
        ax.set_xlim(min(all_sizes) - 0.8, max(all_sizes) + 0.8)
        ax.grid(axis="y", which="major", color=GRID, linewidth=0.4)
        ax.tick_params(colors=INK, length=2, pad=1.5)
        for side in ("top", "right"):
            ax.spines[side].set_visible(False)
        for side in ("left", "bottom"):
            ax.spines[side].set_color(INK)
            ax.spines[side].set_linewidth(0.5)
    axes[0][0].set_ylim(0.004, args.timeout_first * 2.5)
    axes[0][0].set_yticks([0.1, 10, 1000])
    fig.supxlabel("Free features (features not in the explanation)", fontsize=7,
                  color="#0b0b0b", y=0.09)
    fig.supylabel("Time (s)", fontsize=7, color="#0b0b0b", x=0.012)

    handles = [Line2D([], [], marker="o", linestyle="", markersize=(area(n) ** 0.5),
                      markerfacecolor=SOLVED, markeredgecolor="white",
                      label=f"{n}" + (" explanations" if n == 40 else ""))
               for n in (1, 10, 40)]
    handles += [Line2D([], [], color=SOLVED, alpha=0.45, linewidth=0.8, label="min–max"),
                Line2D([], [], color=CHECK, linewidth=0.8, marker="D", markersize=1.8,
                       label="UNSAT call"),
                Line2D([], [], marker="^", linestyle="", markersize=6,
                       markerfacecolor=TIMEOUT, markeredgecolor="white",
                       label="timeout")]
    fig.legend(handles=handles, loc="lower center", ncol=len(handles), frameon=False,
               handletextpad=0.3, columnspacing=1.2, borderaxespad=0.1)
    fig.subplots_adjust(left=0.075, right=0.995, top=0.93, bottom=0.215, hspace=0.42, wspace=0.08)

    os.makedirs(RESULTS, exist_ok=True)
    out = os.path.join(RESULTS, "size_time")
    fig.savefig(out + ".png", dpi=300)
    fig.savefig(out + ".pdf")
    print(f"Read {os.path.relpath(path, BASE)} ({len(records)} pairs)\n"
          f"Wrote {os.path.relpath(out, BASE)}.png and .pdf")


if __name__ == "__main__":
    main()
