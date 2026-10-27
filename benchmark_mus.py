"""
Benchmark compute_mus.py: time to find the first AXp and all AXps.

For each dataset / pair, the script runs the clingo | wasp --mus pipeline twice:
  -n 1   → time to first AXp
  -n 0   → time to all AXps

Each run is repeated --repeats times; the reported times are the mean ± stdev.

Usage:
    python benchmark_mus.py [--datasets <d> ...] [--pairs <n>] [--repeats <r>] [--timeout <s>]

Examples:
    python benchmark_mus.py
    python benchmark_mus.py --datasets running+example breast+cancer+wisconsin+diagnostic
    python benchmark_mus.py --repeats 5
    python benchmark_mus.py --timeout 120
"""

import argparse
import collections
import builtins
import datetime
import math
import os
import re
import shutil
import subprocess
import sys
import threading
import time

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
WASP_BIN = shutil.which("wasp") or os.path.join(
    os.path.expanduser("~"), "Downloads", "alviano-wasp-4332268", "build", "release", "wasp"
)
ENCODING_LP = os.path.join(BASE_DIR, "encoding.lp")

ALL_DATASETS = [
    "running+example",
    "breast+cancer+wisconsin+diagnostic",
    "optical+recognition+of+handwritten+digits",
    "wine+quality",
]

TIMEOUT_FIRST_DEFAULT = 60   # Seconds for the first-AXp run
# The all-AXps timeout defaults to this multiple of the first-AXp timeout *in
# effect*. So overriding --timeout-first alone scales --timeout-all with it
# (see resolve_timeout_all); an explicit --timeout-all still takes precedence.
TIMEOUT_ALL_MULTIPLIER = 5
TIMEOUT_ALL_DEFAULT = TIMEOUT_ALL_MULTIPLIER * TIMEOUT_FIRST_DEFAULT


def resolve_timeout_all(timeout_first, timeout_all):
    """Return the all-AXps timeout: explicit value if given, else the multiple
    of the (possibly overridden) first-AXp timeout."""
    if timeout_all is not None:
        return timeout_all
    return TIMEOUT_ALL_MULTIPLIER * timeout_first


def find_pairs(model_dir: str, max_pairs: int) -> list:
    """Return up to max_pairs pair .lp paths from model_dir.

    Looks in model_dir/pairs/ first (new location), then model_dir/ (old location),
    then falls back to the single pair.lp file.
    """
    pairs = []
    for subdir in [os.path.join(model_dir, "pairs"), model_dir]:
        for i in range(max_pairs):
            p = os.path.join(subdir, f"pair_{i}.lp")
            if os.path.exists(p):
                pairs.append(p)
        if pairs:
            return pairs
    # fall back to pair.lp in model_dir
    p = os.path.join(model_dir, "pair.lp")
    if os.path.exists(p):
        pairs.append(p)
    return pairs


def run_mus(program: str, n_mus: int, timeout: int) -> tuple:
    """Run clingo | wasp --mus on program; return (wall_s, muses, timed_out).

    wall_s   : elapsed wall time in seconds (None on timeout)
    muses    : list of feature lists. On timeout this holds the MUSes streamed
               by wasp *before* it was killed (may be empty).
    timed_out: True if the process was killed by timeout

    wasp's stdout is consumed by a background thread so that MUSes emitted prior
    to a timeout are not lost (communicate() would otherwise discard buffered
    output when the process is killed).
    """
    clingo_cmd = ["clingo", "--output=smodels", "-"]
    wasp_cmd = ["stdbuf", "-oL", WASP_BIN, "--mus=__debug__", f"-n{n_mus}"]

    t0 = time.perf_counter()

    clingo_proc = subprocess.Popen(
        clingo_cmd, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE,
    )
    stdout_clingo, _ = clingo_proc.communicate(input=program.encode())

    wasp_proc = subprocess.Popen(
        wasp_cmd, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE,
    )

    muses = []

    def reader():
        for raw in wasp_proc.stdout:
            m = re.match(r"\[MUS #\d+\]:(.*)", raw.decode(errors="replace"))
            if m:
                feats = re.findall(r"__debug__\(selected\((\d+)\)\)", m.group(1))
                muses.append(sorted(int(f) for f in feats))

    reader_thread = threading.Thread(target=reader, daemon=True)

    # Feed clingo's smodels output, then close stdin so wasp starts solving.
    wasp_proc.stdin.write(stdout_clingo)
    wasp_proc.stdin.close()
    reader_thread.start()

    try:
        wasp_proc.wait(timeout=timeout)
        wall = time.perf_counter() - t0
        timed_out = False
    except subprocess.TimeoutExpired:
        wasp_proc.kill()
        wall = None
        timed_out = True

    # Let the reader drain whatever is left in the pipe after wait/kill.
    reader_thread.join(timeout=5)
    return wall, muses, timed_out


def add_debug_wrappers(program: str, feat_indices: list) -> str:
    lines = [program.strip(), ""]
    for f in feat_indices:
        lines.append(f"selected({f}) :- __debug__(selected({f})).")
        lines.append(f"{{__debug__(selected({f}))}}.")
    lines.append("#show __debug__/1.")
    return "\n".join(lines)


def fmt_t(t):
    if t is None:
        return "TIMEOUT"
    return f"{t * 1000:.1f} ms"


def fmt_t_pm(mean, std):
    """Format mean ± stdev in milliseconds."""
    if mean is None:
        return "TIMEOUT"
    return f"{mean*1000:.1f} ± {std*1000:.1f} ms"


def repeat_run(program: str, n_mus: int, repeats: int, timeout: int):
    """Run run_mus `repeats` times; return (mean_s, std_s, muses, any_timeout).

    muses is the MUS list from the LAST repetition (kept for backward
    compatibility — wasp's result is deterministic across repeats in practice).
    Use repeat_run_collect to obtain every repetition's MUS list.

    Stops early on the first timeout and returns (None, None, partial_muses, True),
    where partial_muses are the MUSes streamed before that run was killed.
    """
    mean, std, all_muses, timed_out = repeat_run_collect(program, n_mus, repeats, timeout)
    muses = all_muses[-1] if all_muses else []
    return mean, std, muses, timed_out


def repeat_run_collect(program: str, n_mus: int, repeats: int, timeout: int):
    """Like repeat_run but returns the MUS list of EVERY repetition.

    Returns (mean_s, std_s, muses_per_repeat, any_timeout) where
    muses_per_repeat is a list with one MUS-list per repetition. On timeout
    returns (None, None, [partial_muses], True).
    """
    times = []
    muses_per_repeat = []
    for _ in range(repeats):
        t, m, timed_out = run_mus(program, n_mus, timeout)
        if timed_out:
            return None, None, [m], True
        times.append(t)
        muses_per_repeat.append(m)
    mean = sum(times) / len(times)
    variance = sum((t - mean) ** 2 for t in times) / len(times)
    std = math.sqrt(variance)
    return mean, std, muses_per_repeat, False


def main():
    parser = argparse.ArgumentParser(
        description="Benchmark time to first AXp and all AXps via compute_mus pipeline."
    )
    parser.add_argument(
        "--datasets", nargs="+", default=None,
        help="Dataset folder names under model/ (default: all found)",
    )
    parser.add_argument(
        "--pairs", type=int, default=5,
        help="Max number of pairs to test per dataset (default: 5)",
    )
    parser.add_argument(
        "--repeats", type=int, default=1,
        help="Number of times to repeat each run for stable timing (default: 1)",
    )
    parser.add_argument(
        "--timeout-first", type=int, default=TIMEOUT_FIRST_DEFAULT,
        help=f"Timeout (s) for the first-AXp run (default: {TIMEOUT_FIRST_DEFAULT} = 5 min). "
             f"If exceeded, the pair is skipped (all-AXps not attempted).",
    )
    parser.add_argument(
        "--timeout-all", type=int, default=None,
        help=f"Timeout (s) for the all-AXps run (default: {TIMEOUT_ALL_MULTIPLIER}x "
             f"--timeout-first). If exceeded, the count of MUSes found so far is reported.",
    )
    parser.add_argument(
        "--output", default=None,
        help="Path to save results (default: results/benchmark_mus_<timestamp>.txt)",
    )
    args = parser.parse_args()
    args.timeout_all = resolve_timeout_all(args.timeout_first, args.timeout_all)

    datasets = args.datasets or ALL_DATASETS

    # Set up output file (tee to both stdout and file)
    results_dir = os.path.join(BASE_DIR, "results")
    os.makedirs(results_dir, exist_ok=True)
    if args.output:
        out_path = args.output
    else:
        ts = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
        out_path = os.path.join(results_dir, f"benchmark_mus_{ts}.txt")

    out_file = open(out_path, "w")

    import builtins
    _orig_print = builtins.print

    def _tee_print(*a, **kw):
        _orig_print(*a, **kw)
        kw2 = {k: v for k, v in kw.items() if k != "file"}
        _orig_print(*a, file=out_file, **kw2)

    builtins.print = _tee_print

    col_w = 52  # width for the pair column
    t_col_w = 20 if args.repeats > 1 else 12  # wider when showing ± stdev

    print("=" * 80)
    print("MUS timing benchmark  (clingo | wasp --mus)")
    print(f"wasp:           {WASP_BIN}")
    print(f"repeats:        {args.repeats}")
    print(f"timeout first:  {args.timeout_first}s ({args.timeout_first/60:.0f} min) — pair skipped if exceeded")
    print(f"timeout all:    {args.timeout_all}s ({args.timeout_all/60:.0f} min) — partial MUS count reported if exceeded")
    print("=" * 80)

    summary_rows = []  # (dataset, pair, n_feats, t_first, t_all, n_mus)

    for dataset in datasets:
        model_dir = os.path.join(BASE_DIR, "experiments", dataset)
        rf_lp = os.path.join(model_dir, "random_forest.lp")

        if not os.path.exists(rf_lp):
            print(f"\n[{dataset}]  random_forest.lp not found — skipping")
            continue

        pairs = find_pairs(model_dir, args.pairs)
        if not pairs:
            print(f"\n[{dataset}]  no pair files found — skipping")
            continue

        print(f"\n{'─'*80}")
        print(f"Dataset: {dataset}  ({len(pairs)} pairs)")
        print(f"{'─'*80}")
        print(f"  {'Pair':<{col_w}}  {'Features':>8}  {'First AXp':>{t_col_w}}  {'All AXps':>{t_col_w}}  {'#AXps':>6}")
        print(f"  {'-'*col_w}  {'-'*8}  {'-'*t_col_w}  {'-'*t_col_w}  {'-'*6}")

        for pair_path in pairs:
            pair_name = os.path.basename(pair_path)

            # Load and prepare program
            with open(rf_lp) as f:
                rf_content = f.read()
            with open(ENCODING_LP) as f:
                enc_content = f.read()
            with open(pair_path) as f:
                pair_content = f.read()

            program_raw = rf_content + "\n" + enc_content + "\n" + pair_content

            feat_indices = sorted(set(
                int(f) for f in re.findall(
                    r"bin\(\s*\d+\s*,\s*(\d+)\s*,\s*\d+\s*\)\.", program_raw
                )
            ))
            n_feats = len(feat_indices)
            program = add_debug_wrappers(program_raw, feat_indices)

            # --- time to first AXp (5 min default) ---
            mean_first, std_first, _, to_first = repeat_run(
                program, n_mus=1, repeats=args.repeats, timeout=args.timeout_first)

            if to_first:
                # Could not even find a single AXp within the budget — skip the
                # (much more expensive) all-AXps computation for this pair.
                mean_all, std_all, to_all = None, None, False
                n_mus = "SKIP"
            else:
                # --- time to all AXps (20 min default) ---
                mean_all, std_all, muses_all, to_all = repeat_run(
                    program, n_mus=0, repeats=args.repeats, timeout=args.timeout_all)
                if to_all:
                    # Timed out: at least this many MUSes were found (more may
                    # exist but weren't enumerated), so prefix with '>='.
                    n_mus = f">={len(muses_all)}"
                else:
                    n_mus = len(muses_all)

            label = f"{dataset}/{pair_name}"
            if args.repeats > 1:
                s_first = fmt_t_pm(mean_first, std_first)
                s_all   = fmt_t_pm(mean_all,   std_all)
            else:
                s_first = fmt_t(mean_first)
                s_all   = fmt_t(mean_all)
            if to_first:
                s_first = "TIMEOUT"
                s_all = "—"
            print(f"  {label:<{col_w}}  {n_feats:>8}  {s_first:>{t_col_w}}  {s_all:>{t_col_w}}  {str(n_mus):>6}")

            summary_rows.append((dataset, pair_name, n_feats,
                                  mean_first, std_first, mean_all, std_all,
                                  n_mus, to_first, to_all))

    # ── Summary table ──
    print(f"\n{'='*80}")
    print("SUMMARY")
    print(f"{'='*80}")
    print(f"  {'Dataset':<45}  {'Pair':<12}  {'Feats':>5}  {'First AXp':>{t_col_w}}  {'All AXps':>{t_col_w}}  {'#AXps':>6}")
    print(f"  {'-'*45}  {'-'*12}  {'-'*5}  {'-'*t_col_w}  {'-'*t_col_w}  {'-'*6}")
    for dataset, pair, n_feats, mean_first, std_first, mean_all, std_all, n_mus, to_first, to_all in summary_rows:
        if args.repeats > 1:
            s_first = fmt_t_pm(mean_first, std_first)
            s_all   = fmt_t_pm(mean_all,   std_all)
        else:
            s_first = fmt_t(mean_first)
            s_all   = fmt_t(mean_all)
        if to_first:
            s_first = "TIMEOUT"
            s_all = "—"
        print(f"  {dataset:<45}  {pair:<12}  {n_feats:>5}  "
              f"{s_first:>{t_col_w}}  {s_all:>{t_col_w}}  {str(n_mus):>6}")

    # Per-dataset aggregate (mean of means over non-timed-out runs)
    by_dataset = collections.defaultdict(list)
    for row in summary_rows:
        by_dataset[row[0]].append(row)

    print(f"\n{'─'*80}")
    print("Per-dataset averages (excluding timeouts):")
    print(f"  {'Dataset':<45}  {'Pairs':>5}  {'Avg First':>{t_col_w}}  {'Avg All':>{t_col_w}}")
    print(f"  {'-'*45}  {'-'*5}  {'-'*t_col_w}  {'-'*t_col_w}")
    for dataset, rows in by_dataset.items():
        firsts = [r[3] for r in rows if r[3] is not None]
        alls   = [r[5] for r in rows if r[5] is not None]
        avg_first = sum(firsts) / len(firsts) if firsts else None
        avg_all   = sum(alls)   / len(alls)   if alls   else None
        print(f"  {dataset:<45}  {len(rows):>5}  "
              f"{fmt_t(avg_first):>{t_col_w}}  {fmt_t(avg_all):>{t_col_w}}")


    builtins.print = _orig_print
    out_file.close()
    print(f"\nResults saved to: {out_path}")


if __name__ == "__main__":
    main()
