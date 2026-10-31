"""
Run the explanation experiments over every model and every pair.

For each model (models/<dataset>/t<trees>_d<depth>/) and each pair
(pairs/pair_*.lp) the script computes, with compute_mus.py (deletion-based MUS
extraction, clingo as the oracle):

  * the FIRST explanation        (-n 1, deletion) — its size and the time to find it
  * the SET of ALL explanations  (-n 0, MARCO)    — how many, their min/max/avg size,
                                                    and the time to enumerate them all

An explanation (AXp) is a MUS of the `selected/1` features: a subset-minimal set
of features that, when fixed to item-1's values, forces the prediction order to
hold — i.e. a minimal abductive explanation of the pair's classification.

Each timing can be repeated (--repeats) and reported as mean ± stdev; a per-run
timeout guards both the first-AXp and the all-AXps computation. A first-AXp
run that times out still records the weak AXp its deletion had reached.

Results are printed and teed to:
    results/explanations_<timestamp>.txt   (human-readable tables)
    results/explanations_<timestamp>.json  (machine-readable, with the AXp sets)

Usage:
    python run_explanations.py
    python run_explanations.py --datasets breast+cancer glioma
    python run_explanations.py --pairs 5 --repeats 3
    python run_explanations.py --pair-files models/breast+cancer/t100_d3/pairs/pair_0.lp
    python run_explanations.py --first-only --timeout-first 120
    python run_explanations.py --models-dir models --pairs 5

Requires the clingo Python package.
"""

import argparse
import datetime
import glob
import json
import math
import multiprocessing
import os
import re
import time

import clingo

from compute_mus import Oracle, candidate_features, enumerate_muses

BASE_DIR = os.path.dirname(os.path.abspath(__file__))
ENCODING_LP = os.path.join(BASE_DIR, "encoding.lp")
MODELS_DIR_DEFAULT = os.path.join(BASE_DIR, "models")

TIMEOUT_FIRST_DEFAULT = 300          # seconds for the first-AXp run (5 min)
TIMEOUT_ALL_MULTIPLIER = 5           # all-AXps timeout = this * first-AXp timeout
CONFIG_RE = re.compile(r"^t\d+_d\d+$")


# --------------------------------------------------------------------------- #
# Model / pair discovery
# --------------------------------------------------------------------------- #
def discover_models(models_dir, datasets=None):
    """Return [(dataset, config, model_dir), ...] for every model that has a
    random_forest.lp. A model dir is models_dir/<dataset>/t<trees>_d<depth>/.

    If `datasets` is given, only those dataset folders are considered.
    Results are sorted by (dataset, config) for stable, reproducible runs.
    """
    found = []
    for rf_lp in glob.glob(os.path.join(models_dir, "*", "*", "random_forest.lp")):
        model_dir = os.path.dirname(rf_lp)
        config = os.path.basename(model_dir)
        dataset = os.path.basename(os.path.dirname(model_dir))
        if not CONFIG_RE.match(config):
            continue
        if datasets and dataset not in datasets:
            continue
        found.append((dataset, config, model_dir))
    return sorted(found)


def find_pairs(model_dir, max_pairs):
    """Return up to max_pairs pair .lp paths (numerically ordered) for a model.

    Looks in model_dir/pairs/ first, then model_dir/, then a single pair.lp.
    """
    for subdir in (os.path.join(model_dir, "pairs"), model_dir):
        paths = glob.glob(os.path.join(subdir, "pair_*.lp"))
        if paths:
            paths.sort(key=lambda p: int(re.search(r"pair_(\d+)\.lp$", p).group(1)))
            return paths[:max_pairs]
    p = os.path.join(model_dir, "pair.lp")
    return [p] if os.path.exists(p) else []


def normalize_paths(paths):
    """Return absolute, normalized paths for stable pair-file filtering."""
    return {os.path.abspath(p) for p in (paths or [])}


# --------------------------------------------------------------------------- #
# Deletion-based MUS extraction (compute_mus.py), with a timeout
# --------------------------------------------------------------------------- #
FORK = multiprocessing.get_context("fork")


def mus_worker(program_files, n_mus, conn):
    """Child process: compute the MUSes and stream them to conn as ("mus", axp).
    A first-AXp run also sends ("ground", seconds) once grounded, ("call",
    [size, unsat, seconds]) after every solve call, and ("weak", axp) after
    every deletion."""
    program = "\n".join(open(p).read() for p in program_files)
    oracle = Oracle(program, candidate_features(program))
    on_drop = None
    if n_mus == 1:
        conn.send(("ground", oracle.ground_s))
        oracle.on_call = lambda size, unsat, s: conn.send(("call", [size, unsat, s]))
        on_drop = lambda mus: conn.send(("weak", mus))
    for mus in enumerate_muses(oracle, n_mus, on_drop):
        conn.send(("mus", mus))
    conn.close()


def run_mus(program_files, n_mus, timeout):
    """Compute up to n_mus MUSes (0 = all) of `program_files` in a forked child;
    return (wall_s, muses, weak_axp, timed_out, calls).

    wall_s    : elapsed wall time in seconds, grounding included (None on timeout)
    muses     : list of AXps, each a sorted list of feature indices. On timeout
                this holds whatever the child streamed before being killed.
    weak_axp  : the last weak AXp the first deletion reached (first-AXp runs
                only, else None)
    timed_out : True if the child was killed by the timeout.
    calls     : first-AXp runs only, else None: {"ground_s": grounding time,
                "calls": [[size, unsat, seconds], ...]}, one entry per solve
                call (size of the checked subset, its verdict, its time), also
                on timeout.

    The child is forked from this process, so the time covers grounding and
    solving but not interpreter start-up; it is taken when the child closes
    the pipe.
    """
    recv, send = FORK.Pipe(duplex=False)
    t0 = time.perf_counter()
    proc = FORK.Process(target=mus_worker, args=(program_files, n_mus, send), daemon=True)
    proc.start()
    send.close()

    muses, weak, wall = [], None, None
    calls = {"ground_s": None, "calls": []} if n_mus == 1 else None
    deadline = t0 + timeout
    while True:
        remaining = deadline - time.perf_counter()
        if remaining <= 0 or not recv.poll(remaining):
            break
        try:
            kind, value = recv.recv()
        except EOFError:
            wall = time.perf_counter() - t0
            break
        if kind == "mus":
            muses.append(value)
        elif kind == "weak":
            weak = value
        elif kind == "ground":
            calls["ground_s"] = value
        else:
            calls["calls"].append(value)

    timed_out = wall is None
    if timed_out:
        proc.kill()
    proc.join()
    recv.close()
    if not timed_out and proc.exitcode != 0:
        raise RuntimeError(f"MUS computation exited with code {proc.exitcode}")
    return wall, muses, weak, timed_out, calls


def repeat_run(program_files, n_mus, repeats, timeout):
    """Run run_mus `repeats` times; return
    (mean_s, std_s, muses, weak_axp, timed_out, calls).

    `muses` is the AXp list from the last (completed) repetition — the
    deletion order is fixed, so the result is the same across repeats. `calls`
    lists run_mus's per-call record of every repetition run. Stops at the first
    timeout and returns (None, None, partial_muses, weak_axp, True, calls).
    """
    times = []
    last_muses = []
    calls = []
    for _ in range(repeats):
        t, m, weak, timed_out, c = run_mus(program_files, n_mus, timeout)
        calls.append(c)
        if timed_out:
            return None, None, m, weak, True, calls
        times.append(t)
        last_muses = m
    mean = sum(times) / len(times)
    std = math.sqrt(sum((t - mean) ** 2 for t in times) / len(times))
    return mean, std, last_muses, None, False, calls


# --------------------------------------------------------------------------- #
# Formatting / stats
# --------------------------------------------------------------------------- #
def fmt_t(mean, std=None, repeats=1):
    if mean is None:
        return "TIMEOUT"
    if repeats > 1 and std is not None:
        return f"{mean*1000:.1f} ± {std*1000:.1f} ms"
    return f"{mean*1000:.1f} ms"


def size_stats(muses):
    """min, max, avg AXp size over a list of AXps ([] -> (0, 0, 0.0))."""
    if not muses:
        return 0, 0, 0.0
    sizes = [len(m) for m in muses]
    return min(sizes), max(sizes), sum(sizes) / len(sizes)


# --------------------------------------------------------------------------- #
# Main
# --------------------------------------------------------------------------- #
def main():
    parser = argparse.ArgumentParser(
        description="Compute the first explanation and all explanations (size + time) "
                    "for every model and every pair."
    )
    parser.add_argument("--models-dir", default=MODELS_DIR_DEFAULT,
                        help="Root holding <dataset>/t<trees>_d<depth>/ models "
                             f"(default: {MODELS_DIR_DEFAULT})")
    parser.add_argument("--datasets", nargs="+", default=None,
                        help="Restrict to these dataset folder names (default: all found)")
    parser.add_argument("--pairs", type=int, default=5,
                        help="Max pairs per model (default: 5)")
    parser.add_argument("--pair-files", nargs="+", default=None,
                        help="Restrict execution to these exact pair .lp files. "
                             "Useful for batch runs with one task per pair.")
    parser.add_argument("--repeats", type=int, default=1,
                        help="Repeat each timing N times, report mean ± stdev (default: 1)")
    parser.add_argument("--first-only", action="store_true",
                        help="Only compute the first explanation; skip the all-AXps enumeration")
    parser.add_argument("--timeout-first", type=int, default=TIMEOUT_FIRST_DEFAULT,
                        help=f"Timeout (s) for the first-AXp run (default: {TIMEOUT_FIRST_DEFAULT}). "
                             "On timeout the pair is skipped (all-AXps not attempted).")
    parser.add_argument("--timeout-all", type=int, default=None,
                        help=f"Timeout (s) for the all-AXps run "
                             f"(default: {TIMEOUT_ALL_MULTIPLIER}x --timeout-first).")
    parser.add_argument("--output", default=None,
                        help="Base output path (without extension). Default: "
                             "results/explanations_<timestamp>")
    args = parser.parse_args()

    timeout_all = args.timeout_all if args.timeout_all is not None \
        else TIMEOUT_ALL_MULTIPLIER * args.timeout_first

    models = discover_models(args.models_dir, args.datasets)
    if not models:
        raise SystemExit(f"No models found under {args.models_dir} "
                         "(expected <dataset>/t<trees>_d<depth>/random_forest.lp)")

    # Output files (tee print to stdout + .txt; structured results to .json).
    results_dir = os.path.join(BASE_DIR, "results")
    os.makedirs(results_dir, exist_ok=True)
    ts = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    base = args.output or os.path.join(results_dir, f"explanations_{ts}")
    txt_path, json_path = base + ".txt", base + ".json"

    out_file = open(txt_path, "w")
    import builtins
    _orig_print = builtins.print

    def _tee(*a, **kw):
        _orig_print(*a, **kw)
        kw2 = {k: v for k, v in kw.items() if k != "file"}
        _orig_print(*a, file=out_file, **kw2)
        out_file.flush()          # write each row immediately so the .txt can be tailed live

    builtins.print = _tee

    rep = args.repeats
    pair_file_filter = normalize_paths(args.pair_files)
    print("=" * 92)
    print("EXPLANATION EXPERIMENTS  (deletion-based MUS extraction, clingo oracle)")
    print(f"models dir:     {args.models_dir}")
    print(f"models:         {len(models)}   "
          f"({'specific pair files' if pair_file_filter else f'max {args.pairs} pairs each'})")
    print(f"clingo:         {clingo.__version__}")
    print(f"repeats:        {rep}")
    print(f"first only:     {args.first_only}")
    print(f"timeout first:  {args.timeout_first}s   timeout all: "
          f"{'n/a' if args.first_only else f'{timeout_all}s'}")
    print("=" * 92)

    pair_col = 10
    t_col = 22 if rep > 1 else 13
    records = []   # structured results for JSON

    for dataset, config, model_dir in models:
        rf_lp = os.path.join(model_dir, "random_forest.lp")
        if pair_file_filter:
            model_root = os.path.abspath(model_dir) + os.sep
            pairs = sorted(p for p in pair_file_filter
                           if p.startswith(model_root) and os.path.exists(p))
        else:
            pairs = find_pairs(model_dir, args.pairs)
        if not pairs:
            print(f"\n[{dataset}/{config}]  no pair files — skipping")
            continue

        with open(rf_lp) as f:
            rf_content = f.read()

        print(f"\n{'─'*110}")
        print(f"Model: {dataset}/{config}   ({len(pairs)} pairs)")
        print(f"{'─'*110}")
        print(f"  {'Pair':<{pair_col}}  {'Feats':>5}  "
              f"{'1st size':>8}  {'1st time':>{t_col}}  "
              f"{'#AXps':>6}  {'min':>4}  {'max':>4}  {'avg':>5}  {'All time':>{t_col}}")
        print(f"  {'-'*pair_col}  {'-'*5}  {'-'*8}  {'-'*t_col}  "
              f"{'-'*6}  {'-'*4}  {'-'*4}  {'-'*5}  {'-'*t_col}")

        for pair_path in pairs:
            pair_name = os.path.basename(pair_path)
            with open(pair_path) as f:
                pair_content = f.read()

            program_files = [rf_lp, ENCODING_LP, pair_path]
            feat_indices = sorted(set(int(f) for f in re.findall(
                r"bin\(\s*\d+\s*,\s*(\d+)\s*,\s*\d+\s*\)\.", rf_content + pair_content)))
            n_feats = len(feat_indices)

            # --- first explanation: size + time ---
            mf, sf, muses_first, weak_first, to_first, calls_first = repeat_run(
                program_files, n_mus=1, repeats=rep, timeout=args.timeout_first)
            first_size = len(muses_first[0]) if (not to_first and muses_first) else None
            first_axp = muses_first[0] if (not to_first and muses_first) else None

            rec = {
                "dataset": dataset, "config": config, "pair": pair_name,
                "n_features": n_feats,
                "first": {
                    "size": first_size, "axp": first_axp,
                    "time_mean_s": mf, "time_std_s": sf, "timeout": to_first,
                    "weak_axp": weak_first,
                    # One entry per repetition run: grounding time and every
                    # solve call as [subset size, unsat, seconds].
                    "call_log": calls_first,
                },
                "all": None,
            }

            if to_first:
                print(f"  {pair_name:<{pair_col}}  {n_feats:>5}  "
                      f"{'—':>8}  {'TIMEOUT':>{t_col}}  {'—':>6}  {'—':>4}  {'—':>4}  {'—':>5}  {'—':>{t_col}}")
                records.append(rec)
                continue

            s_first = fmt_t(mf, sf, rep)

            if args.first_only:
                print(f"  {pair_name:<{pair_col}}  {n_feats:>5}  "
                      f"{first_size:>8}  {s_first:>{t_col}}  {'—':>6}  {'—':>4}  {'—':>4}  {'—':>5}  {'—':>{t_col}}")
                records.append(rec)
                continue

            # --- set of all explanations: count, sizes, time ---
            ma, sa, muses_all, _, to_all, _ = repeat_run(
                program_files, n_mus=0, repeats=rep, timeout=timeout_all)
            n_axps = len(muses_all)
            mn, mx, av = size_stats(muses_all)
            s_all = fmt_t(ma, sa, rep)
            n_str = f">={n_axps}" if to_all else str(n_axps)

            rec["all"] = {
                "count": n_axps, "count_partial": to_all,
                "min_size": mn, "max_size": mx, "avg_size": av,
                "time_mean_s": ma, "time_std_s": sa, "timeout": to_all,
                "axps": muses_all,
            }
            records.append(rec)

            print(f"  {pair_name:<{pair_col}}  {n_feats:>5}  "
                  f"{first_size:>8}  {s_first:>{t_col}}  "
                  f"{n_str:>6}  {mn:>4}  {mx:>4}  {av:>5.1f}  {s_all:>{t_col}}")

    # ── Per-model summary ──
    print(f"\n{'='*92}")
    print("SUMMARY  (per model, averaged over its non-timed-out pairs)")
    print(f"{'='*92}")
    print(f"  {'Model':<34}  {'Pairs':>5}  {'Avg 1st sz':>10}  "
          f"{'Avg 1st t':>13}  {'Avg #AXps':>9}  {'Avg all t':>13}")
    print(f"  {'-'*34}  {'-'*5}  {'-'*10}  {'-'*13}  {'-'*9}  {'-'*13}")

    by_model = {}
    for r in records:
        by_model.setdefault((r["dataset"], r["config"]), []).append(r)

    for (dataset, config), rs in by_model.items():
        first_sizes = [r["first"]["size"] for r in rs if r["first"]["size"] is not None]
        first_times = [r["first"]["time_mean_s"] for r in rs if r["first"]["time_mean_s"] is not None]
        all_counts = [r["all"]["count"] for r in rs if r["all"] is not None]
        all_times = [r["all"]["time_mean_s"] for r in rs
                     if r["all"] is not None and r["all"]["time_mean_s"] is not None]
        avg_fs = f"{sum(first_sizes)/len(first_sizes):.1f}" if first_sizes else "—"
        avg_ft = fmt_t(sum(first_times)/len(first_times)) if first_times else "TIMEOUT/—"
        avg_ac = f"{sum(all_counts)/len(all_counts):.1f}" if all_counts else "—"
        avg_at = fmt_t(sum(all_times)/len(all_times)) if all_times else "—"
        print(f"  {dataset+'/'+config:<34}  {len(rs):>5}  "
              f"{avg_fs:>10}  {avg_ft:>13}  {avg_ac:>9}  {avg_at:>13}")

    # ── Structured output ──
    with open(json_path, "w") as jf:
        json.dump({
            "generated": ts,
            "params": {
                "models_dir": args.models_dir, "datasets": args.datasets,
                "pair_files": args.pair_files,
                "pairs": args.pairs, "repeats": rep, "first_only": args.first_only,
                "timeout_first": args.timeout_first, "timeout_all": timeout_all,
            },
            "results": records,
        }, jf, indent=2)

    builtins.print = _orig_print
    out_file.close()
    print(f"\nResults saved to:\n  {txt_path}\n  {json_path}")


if __name__ == "__main__":
    main()
