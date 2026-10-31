"""
Exhaustive-search baseline for AXps of rankings, with validation.

compute_axp_bruteforce.py decides every feature subset by enumerating the whole
bin space, but prints every compliant combination, so it only scales to the
running example. This script runs the same exhaustive search quietly, in
chunks, and times it. Bin combinations are labelled by querying the sklearn
forest as a black box under hard majority voting (ties -> lowest class, as
prediction(I,C) in encoding.lp); bins are turned into feature values with the
bin representatives of utils/empty_bins.py, as in utils/generate_items.py.

All AXps (default):

1. ENUMERATE and LABEL every bin combination of the forest's features (the
   product of the bin domains in random_forest.lp), once per model; the labels
   are shared by all its pairs.

2. For every pair, record which classes occur for each agreement pattern (the
   set of candidate features on which a combination has the same bin as item 1,
   resp. item 2), then propagate them to every subset S with a superset pass:
   the item-3 candidates for S are the combinations agreeing with item 1 on at
   least S, the item-4 candidates those agreeing with item 2 on at least S.
   S is sufficient iff the highest item-3 class does not exceed the lowest
   item-4 class (no counterexample with class(3) > class(4), as in encoding.lp).
   AXps are the sufficient sets none of whose one-smaller subsets is sufficient.

First AXp (--first): deletion-based search. Start from all candidate features
and drop each one in turn when the rest is still sufficient. Each check
enumerates only the combinations agreeing with item 1 (resp. item 2) on the
subset and stops at the first counterexample, so the whole space is never
labelled up front. Pairs exceeding --timeout are reported as timeouts.

With --validate it also checks, against clingo and the ASP encoding:
  - that clingo, enumerating a free probe item as compute_axp_bruteforce.py
    does, yields exactly the same combinations with the same labels
    (all AXps only, and only when the space has at most --max-check-space
    combinations);
  - the verdict of every subset, or, beyond --max-check-subsets subsets and
    always with --first, of every AXp and of each of its one-smaller subsets,
    by solving random_forest.lp + encoding.lp + pair with selected(F) set for
    F in S.

Usage:
    python benchmark_bruteforce.py [model_dir ...] [--pairs N] [--validate]
    python benchmark_bruteforce.py --first [model_dir ...] [--timeout S] [--validate]
"""

import argparse
import itertools
import json
import math
import os
import re
import sys
import time

import clingo
import joblib
import numpy as np

BASE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, BASE)
sys.path.insert(0, os.path.join(BASE, "utils"))
from compute_axp_bruteforce import TRAVERSAL_RULES, parse_model_atoms, run_clingo  # noqa: E402
from empty_bins import bin_value  # noqa: E402

ENCODING_LP = os.path.join(BASE, "encoding.lp")
# Labelling the whole bin space (all AXps) is only feasible on small spaces,
# smaller than those of the models in models/; give such a model explicitly.
DEFAULT_FIRST_MODELS = ["models/heart+disease/t100_d3", "models/breast+cancer/t100_d3",
                        "models/glioma/t100_d5"]
DEFAULT_MODELS = DEFAULT_FIRST_MODELS[:1]
CHUNK = 1 << 20
# Largest per-pair table of agreement patterns (2^|F| x classes) in all-AXps mode;
# its bincount needs 8 bytes per entry, ~1 GB here.
MAX_PATTERNS = 1 << 27

DOMAIN_RE = re.compile(r"\{bin\(I,(\d+),B\)\s*:\s*B\s*=\s*0\.\.(\d+)\}\s*=\s*1")
PAIR_BIN_RE = re.compile(r"bin\((1|2)\s*,\s*(\d+)\s*,\s*(\d+)\s*\)\.")


def bin_values(ts):
    """One representative value per bin, inside the bin once cast to float32
    (utils/empty_bins.py)."""
    return np.array([bin_value(ts, b) for b in range(len(ts) + 1)])


class Space:
    """The bin space of a forest: mixed-radix enumeration plus black-box labels."""

    def __init__(self, model_dir):
        self.lp = open(os.path.join(model_dir, "random_forest.lp")).read()
        domains = {int(f): int(k) + 1 for f, k in DOMAIN_RE.findall(self.lp)}
        self.feats = sorted(domains)
        self.radices = [domains[f] for f in self.feats]
        self.size = math.prod(self.radices)
        self.forest = joblib.load(os.path.join(model_dir, "random_forest.pkl"))
        with open(os.path.join(model_dir, "split_points.json")) as f:
            split_points = {int(k): sorted(float(t) for t in v)
                            for k, v in json.load(f).items()}
        for f in self.feats:
            assert len(split_points[f]) + 1 == domains[f], f"bin domain mismatch on feature {f}"
        self.values = {f: bin_values(split_points[f]) for f in self.feats}
        self.classes = self.forest.classes_

    def decode(self, start, stop):
        """Bin combinations start..stop-1 (last feature varies fastest)."""
        idx = np.arange(start, stop, dtype=np.int64)
        out = np.empty((stop - start, len(self.feats)), dtype=np.int16)
        for j in range(len(self.feats) - 1, -1, -1):
            idx, out[:, j] = np.divmod(idx, self.radices[j])
        return out

    def combos(self, fixed):
        """Chunks of all combinations with the columns in fixed ({col: bin}) set."""
        free = [j for j in range(len(self.feats)) if j not in fixed]
        total = math.prod(self.radices[j] for j in free)
        for start in range(0, total, CHUNK):
            stop = min(start + CHUNK, total)
            idx = np.arange(start, stop, dtype=np.int64)
            out = np.empty((stop - start, len(self.feats)), dtype=np.int16)
            for j, b in fixed.items():
                out[:, j] = b
            for j in reversed(free):
                idx, out[:, j] = np.divmod(idx, self.radices[j])
            yield out

    def label(self, bins):
        """Hard-vote class INDEX (into forest.classes_) of every combination."""
        X = np.zeros((len(bins), self.forest.n_features_in_))
        for j, f in enumerate(self.feats):
            X[:, f] = self.values[f][bins[:, j]]
        # The cast sklearn would do anyway, done once rather than per tree.
        X = X.astype(np.float32)
        counts = np.zeros((len(bins), len(self.classes)), dtype=np.int16)
        rows = np.arange(len(bins))
        for est in self.forest.estimators_:
            counts[rows, est.predict(X).astype(np.intp)] += 1
        # argmax returns the first maximum, i.e. the lowest class index.
        return counts.argmax(axis=1)


class Pair:
    """Per-pair accumulator of the classes seen for each agreement pattern."""

    def __init__(self, path, space):
        self.path = path
        self.text = open(path).read()
        bins = {1: {}, 2: {}}
        for i, f, b in PAIR_BIN_RE.findall(self.text):
            bins[int(i)][int(f)] = int(b)
        assert set(bins[1]) == set(bins[2]), "items 1 and 2 bin different features"
        # Candidate features: those with bin/3 facts, as in compute_mus.py.
        self.cand = sorted(bins[1])
        self.cols = [space.feats.index(f) for f in self.cand]
        self.v1 = np.array([bins[1][f] for f in self.cand], dtype=np.int16)
        self.v2 = np.array([bins[2][f] for f in self.cand], dtype=np.int16)
        self.weights = 1 << np.arange(len(self.cand), dtype=np.int64)
        self.k = len(space.classes)
        self.seen1 = self.seen2 = None
        self.time = 0.0

    def update(self, bins, cls):
        t0 = time.perf_counter()
        if self.seen1 is None:
            self.seen1 = np.zeros((1 << len(self.cand)) * self.k, dtype=bool)
            self.seen2 = np.zeros_like(self.seen1)
        sub = bins[:, self.cols]
        for v, seen in ((self.v1, self.seen1), (self.v2, self.seen2)):
            pattern = (sub == v).astype(np.int64) @ self.weights
            seen |= np.bincount(pattern * self.k + cls, minlength=seen.size) > 0
        self.time += time.perf_counter() - t0

    def finish(self):
        """Sufficiency of every subset (bitmask over self.cand) and the AXps."""
        t0 = time.perf_counter()
        n, k = len(self.cand), self.k
        seen1 = self.seen1.reshape(-1, k)
        seen2 = self.seen2.reshape(-1, k)
        # Highest item-3 class / lowest item-4 class per exact pattern.
        hi = np.where(seen1.any(1), k - 1 - seen1[:, ::-1].argmax(1), -1)
        lo = np.where(seen2.any(1), seen2.argmax(1), k)
        # Superset pass: a combination with pattern T is a candidate for every S <= T.
        for j in range(n):
            a = hi.reshape(-1, 2, 1 << j)
            a[:, 0] = np.maximum(a[:, 0], a[:, 1])
            b = lo.reshape(-1, 2, 1 << j)
            b[:, 0] = np.minimum(b[:, 0], b[:, 1])
        self.sufficient = hi <= lo
        masks = np.arange(1 << n)
        minimal = self.sufficient.copy()
        for j in range(n):
            minimal &= ((masks >> j) & 1 == 0) | ~self.sufficient[masks ^ (1 << j)]
        self.axps = [int(s) for s in np.nonzero(minimal)[0]]
        self.time += time.perf_counter() - t0

    def features(self, mask):
        return [f for j, f in enumerate(self.cand) if mask >> j & 1]


def check_labels(space, labels):
    """clingo enumeration of a free probe item vs the black-box labels."""
    _, models = run_clingo(space.lp + TRAVERSAL_RULES, all_models=True)
    strides = np.cumprod([1] + space.radices[:0:-1])[::-1]
    seen = np.zeros(space.size, dtype=bool)
    wrong = 0
    for m in models:
        bins, _, pred, _ = parse_model_atoms(m, (0,))
        idx = int(sum(bins[0][f] * s for f, s in zip(space.feats, strides)))
        seen[idx] = True
        wrong += int(space.classes[labels[idx]]) != pred[0]
    return len(models), int(seen.sum()), wrong


def axp_neighbourhood(pair):
    """Each AXp (sufficient) and each of its one-smaller subsets (not sufficient)."""
    n = len(pair.cand)
    verdicts = {}
    for a in pair.axps:
        verdicts[a] = True
        verdicts.update({a ^ (1 << j): False for j in range(n) if a >> j & 1})
    return verdicts


def check_verdicts(pair, space, verdicts):
    """Re-decide subsets ({mask: sufficient}) with the ASP encoding.

    selected/1 is declared external, so the program is grounded once per pair
    and each subset is a solve under assumptions on it.
    Returns (checked, mismatches).
    """
    ctl = clingo.Control(["--models=1"])
    ctl.add("base", [], "\n".join([space.lp, open(ENCODING_LP).read(), pair.text]
                                  + [f"#external selected({f})." for f in pair.cand]))
    ctl.ground([("base", [])])
    mismatches = []
    for mask, sufficient in verdicts.items():
        for j, f in enumerate(pair.cand):
            ctl.assign_external(clingo.Function("selected", [clingo.Number(f)]),
                                bool(mask >> j & 1))
        if ctl.solve().satisfiable == sufficient:
            mismatches.append(pair.features(mask))
    return len(verdicts), mismatches


class Timeout(Exception):
    pass


def is_sufficient(space, pair, mask, deadline):
    """Exhaustive check of one subset, stopping at the first counterexample.

    Item 3 ranges over the combinations agreeing with item 1 on the subset,
    item 4 over those agreeing with item 2; the subset is sufficient iff the
    highest item-3 class never exceeds the lowest item-4 class. The two sides
    are enumerated in step, so a counterexample is usually found early.
    Returns (sufficient, combinations labelled).
    """
    picked = [j for j in range(len(pair.cand)) if mask >> j & 1]
    sides = [space.combos({pair.cols[j]: int(v[j]) for j in picked})
             for v in (pair.v1, pair.v2)]
    # Items 1 and 2 are candidates for items 3 and 4 themselves.
    hi, lo = pair.c1, pair.c2
    labelled = 0
    for chunk3, chunk4 in itertools.zip_longest(*sides):
        if chunk3 is not None:
            hi = max(hi, int(space.label(chunk3).max()))
            labelled += len(chunk3)
        if chunk4 is not None:
            lo = min(lo, int(space.label(chunk4).min()))
            labelled += len(chunk4)
        if hi > lo:
            return False, labelled
        if time.perf_counter() > deadline:
            raise Timeout
    return True, labelled


def first_axp(space, pair, timeout):
    """Deletion-based search for one AXp: drop each candidate feature in turn
    while the rest stays sufficient. Sufficiency is monotone, so the result is
    subset-minimal. Returns (sufficiency checks, combinations labelled).

    Every finished check is appended to pair.checks as [subset size,
    sufficient, seconds, combinations labelled], also when the search then
    times out; pair.weak is the sufficient subset reached so far (a weak AXp,
    whose size bounds that of the AXp being computed)."""
    t0 = time.perf_counter()
    assert sorted(pair.cols) == list(range(len(space.feats))), "pair does not bin every feature"
    v = np.zeros((2, len(space.feats)), dtype=np.int16)
    v[0, pair.cols], v[1, pair.cols] = pair.v1, pair.v2
    pair.c1, pair.c2 = (int(c) for c in space.label(v))
    assert pair.c1 <= pair.c2, "item 1 is ranked above item 2"
    mask = (1 << len(pair.cand)) - 1
    checks = labelled = 0
    pair.checks = []
    pair.weak = mask
    for j in range(len(pair.cand)):
        t_check = time.perf_counter()
        ok, n = is_sufficient(space, pair, mask & ~(1 << j), t0 + timeout)
        pair.checks.append([bin(mask).count("1") - 1, ok, time.perf_counter() - t_check, n])
        checks += 1
        labelled += n
        if ok:
            mask &= ~(1 << j)
            pair.weak = mask
    pair.axps = [mask]
    pair.time = time.perf_counter() - t0
    return checks, labelled


def load(model_dir, n_pairs, only_pair=None):
    name = os.path.relpath(model_dir, os.path.join(BASE, "models"))
    if name.startswith(".."):
        name = os.path.join(*model_dir.split(os.sep)[-2:])
    space = Space(model_dir)
    pair_dir = os.path.join(model_dir, "pairs")
    files = sorted(os.listdir(pair_dir), key=lambda s: int(re.findall(r"\d+", s)[0]))
    files = [f"pair_{only_pair}.lp"] if only_pair is not None else files[:n_pairs]
    pairs = [Pair(os.path.join(pair_dir, p), space) for p in files]
    print(f"\n== {name}: {len(space.feats)} features, {space.size:,} bin combinations, "
          f"{len(space.forest.estimators_)} trees, {len(pairs)} pairs", flush=True)
    return name, space, pairs


def run_model_first(model_dir, n_pairs, validate, timeout, only_pair=None):
    name, space, pairs = load(model_dir, n_pairs, only_pair)
    rows = []
    for p in pairs:
        pair = os.path.basename(p.path)
        try:
            checks, labelled = first_axp(space, p, timeout)
        except Timeout:
            print(f"  {pair:<10} timeout ({timeout:g}s)", flush=True)
            weak = getattr(p, "weak", None)
            rows.append({"pair": pair, "solved": False, "reason": "timeout",
                         "checks": getattr(p, "checks", []),
                         "weak_axp": p.features(weak) if weak is not None else None,
                         "size_ub": bin(weak).count("1") if weak is not None else len(p.cand)})
            continue
        axp = p.axps[0]
        row = {"pair": pair, "solved": True, "axp": p.features(axp),
               "size": bin(axp).count("1"), "time": p.time, "labelled": labelled,
               "checks": p.checks}
        line = (f"  {pair:<10} AXp={p.features(axp)}  size={row['size']}  "
                f"time={p.time:.3f}s  checks={checks}  labelled={labelled:,}")
        if validate:
            checked, bad = check_verdicts(p, space, axp_neighbourhood(p))
            line += f"  verdicts: {checked} checked, {len(bad)} mismatches"
            row["mismatches"] = len(bad)
        print(line, flush=True)
        rows.append(row)
    return {"model": name, "size": space.size, "rows": rows,
            "domains": dict(zip(space.feats, space.radices))}


def unsolved(name, space, pairs, reason):
    return {"model": name, "size": space.size, "label_time": None,
            "rows": [{"pair": os.path.basename(p.path), "solved": False, "reason": reason}
                     for p in pairs]}


def run_model(model_dir, n_pairs, validate, max_space, max_subsets, only_pair=None,
              timeout=None):
    name, space, pairs = load(model_dir, n_pairs, only_pair)
    deadline = time.perf_counter() + timeout if timeout else math.inf

    # Each pair keeps two (2^|F| x classes) tables of agreement patterns.
    patterns = max((1 << len(p.cand)) * len(space.classes) for p in pairs)
    if patterns > MAX_PATTERNS:
        print(f"not attempted: {patterns:,} agreement patterns per pair exceed {MAX_PATTERNS:,}")
        return unsolved(name, space, pairs, "memory")

    keep = validate and space.size <= max_space
    labels = np.empty(space.size, dtype=np.int16) if keep else None
    label_time = 0.0
    for start in range(0, space.size, CHUNK):
        if time.perf_counter() > deadline:
            print(f"timeout ({timeout:g}s) after labelling {start:,} of {space.size:,} "
                  f"combinations", flush=True)
            return unsolved(name, space, pairs, "timeout")
        stop = min(start + CHUNK, space.size)
        t0 = time.perf_counter()
        bins = space.decode(start, stop)
        cls = space.label(bins)
        label_time += time.perf_counter() - t0
        if keep:
            labels[start:stop] = cls
        for p in pairs:
            p.update(bins, cls)
    for p in pairs:
        p.finish()
    print(f"enumerate + label (once per model): {label_time:.3f}s")

    if validate:
        if keep:
            n_models, distinct, wrong = check_labels(space, labels)
            ok = n_models == distinct == space.size and wrong == 0
            print(f"clingo probe enumeration: {n_models:,} answer sets, {distinct:,} distinct "
                  f"combinations, {wrong} label disagreements -> {'OK' if ok else 'FAIL'}")
        else:
            print(f"clingo probe enumeration skipped (space > {max_space:,})")

    rows = []
    for p in pairs:
        sizes = [bin(a).count("1") for a in p.axps]
        row = {"pair": os.path.basename(p.path), "solved": True, "n": len(p.cand),
               "axps": len(p.axps), "size": sum(sizes) / len(sizes) if sizes else float("nan"),
               "pair_time": p.time, "total": label_time + p.time,
               "axp_list": [p.features(a) for a in p.axps]}
        line = (f"  {row['pair']:<10} |F|={row['n']:<3} AXps={row['axps']:<4} "
                f"avg size={row['size']:.2f}  pair={p.time:.3f}s  total={row['total']:.3f}s")
        if validate:
            if (1 << len(p.cand)) <= max_subsets:
                verdicts = {m: bool(p.sufficient[m]) for m in range(1 << len(p.cand))}
            else:
                verdicts = axp_neighbourhood(p)
            checked, bad = check_verdicts(p, space, verdicts)
            line += f"  verdicts: {checked} checked, {len(bad)} mismatches"
            row["mismatches"] = len(bad)
            if bad:
                line += f" {bad[:5]}"
            line += f"\n             AXps: {[p.features(a) for a in p.axps]}"
        print(line)
        rows.append(row)
    return {"model": name, "size": space.size, "label_time": label_time, "rows": rows}


def summary(results):
    lines = [f"{'Model':<22}{'Combinations':>15}{'Label [s]':>11}{'Pair [s]':>10}"
             f"{'Total [s]':>11}{'#AXps':>8}{'Size':>7}",
             "-" * 84]
    for r in results:
        rows = [x for x in r["rows"] if x["solved"]]
        if not rows:
            lines.append(f"{r['model']:<22}{r['size']:>15,}  not solved "
                         f"({r['rows'][0]['reason']})")
            continue
        mean = lambda key: sum(x[key] for x in rows) / len(rows)  # noqa: E731
        lines.append(f"{r['model']:<22}{r['size']:>15,}{r['label_time']:>11.3f}"
                     f"{mean('pair_time'):>10.3f}{mean('total'):>11.3f}"
                     f"{mean('axps'):>8.1f}{mean('size'):>7.2f}")
    lines.append("")
    lines.append("Label = enumerate and label the whole bin space (once per model); "
                 "Pair = per-pair search over all subsets;")
    lines.append("Total = Label + Pair, i.e. one instance run alone; "
                 "#AXps and Size = per-pair means.")
    return "\n".join(lines)


def summary_first(results, timeout):
    lines = [f"{'Model':<22}{'Combinations':>17}{'Solved':>8}{'Size':>7}"
             f"{'Time [s]':>11}{'Labelled':>17}",
             "-" * 82]
    for r in results:
        rows = [x for x in r["rows"] if x["solved"]]
        mean = lambda key: sum(x[key] for x in rows) / len(rows) if rows else float("nan")  # noqa: E731
        lines.append(f"{r['model']:<22}{r['size']:>17,}{len(rows):>5}/{len(r['rows']):<2}"
                     f"{mean('size'):>7.1f}{mean('time'):>11.3f}{mean('labelled'):>17,.0f}")
    lines.append("")
    lines.append("First AXp by deletion: one exhaustive sufficiency check per candidate feature.")
    lines.append(f"Size, Time and Labelled (combinations labelled) are means over solved pairs; "
                 f"timeout {timeout:g}s per pair.")
    return "\n".join(lines)


def main():
    parser = argparse.ArgumentParser(
        description="Time and validate exhaustive search for AXps of rankings.",
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
        # No prefix matching: an older copy without --pair took it for --pairs.
        allow_abbrev=False)
    parser.add_argument("model_dirs", nargs="*",
                        help=f"Model dirs (default: {' '.join(DEFAULT_MODELS)})")
    parser.add_argument("--pairs", type=int, default=10, help="Pairs per model")
    parser.add_argument("--validate", action="store_true",
                        help="Cross-check labels and verdicts with clingo")
    parser.add_argument("--max-check-space", type=int, default=1_000_000,
                        help="Largest space whose clingo enumeration is checked")
    parser.add_argument("--max-check-subsets", type=int, default=1024,
                        help="Check all subsets up to this many, else AXps only")
    parser.add_argument("--first", action="store_true",
                        help="Compute one AXp per pair by deletion instead of all AXps")
    parser.add_argument("--timeout", type=float, default=None,
                        help="Timeout in seconds: per pair with --first (default 600), for "
                             "labelling and searching all pairs together otherwise (default none)")
    parser.add_argument("--json", help="Also write the per-pair results to this JSON file")
    parser.add_argument("--pair", type=int, help="Run only pairs/pair_<PAIR>.lp")
    args = parser.parse_args()

    defaults = DEFAULT_FIRST_MODELS if args.first else DEFAULT_MODELS
    model_dirs = args.model_dirs or [os.path.join(BASE, d) for d in defaults]
    if args.first:
        timeout = args.timeout if args.timeout is not None else 600
        results = [run_model_first(os.path.abspath(d), args.pairs, args.validate, timeout,
                                   args.pair)
                   for d in model_dirs]
        text = summary_first(results, timeout)
    else:
        results = [run_model(os.path.abspath(d), args.pairs, args.validate,
                             args.max_check_space, args.max_check_subsets, args.pair,
                             args.timeout)
                   for d in model_dirs]
        text = summary(results)
    print("\n" + text)
    if args.json:
        with open(args.json, "w") as f:
            json.dump(results, f, indent=1)
    if not args.model_dirs:
        path = os.path.join(BASE, "models", "bruteforce_first_performance.txt" if args.first
                            else "bruteforce_performance.txt")
        open(path, "w").write(text + "\n")
        print(f"\nWrote {path}")


if __name__ == "__main__":
    main()
