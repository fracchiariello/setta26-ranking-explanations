"""
Find minimal sets of selected features (MUSes) that make the query UNSAT,
with the deletion-based algorithm and clingo as the oracle.

Usage:
    python compute_mus.py <program.lp> [<program2.lp> ...] [-n N]

The script concatenates all input files, declares selected(F) external for
every feature F found in bin/3 facts, grounds the program once, and decides
each candidate set S with one solve call, setting selected(F) true exactly for
F in S: S is a weak AXp iff the program is UNSAT (no counterexample). Every
call reuses the grounding and the nogoods clingo learned in earlier calls.

One MUS (deletion): start from all the features, a weak AXp whenever
class(1) <= class(2), and drop each feature in turn, in increasing order, when
the rest is still UNSAT. By monotonicity the result is subset-minimal, after
one oracle call per feature.

All MUSes (MARCO): a second clingo program over atoms s(F), the map, holds the
subsets not explored yet. Each seed it returns is grown to a maximal subset of
the map. An UNSAT seed is shrunk to a new MUS by deletion, and later seeds may
not contain that MUS; a SAT seed is a maximal satisfiable subset, so its
complement is a minimal correction subset (MCS), which later seeds must hit.
Every MUS hits every MCS, so all MUSes are found when the map has no model.
The first seed is all the features, so the first MUS is the one computed by
deletion alone.
"""

import argparse
import re
import time

import clingo

FEATURE_RE = re.compile(r"bin\(\s*\d+\s*,\s*(\d+)\s*,\s*\d+\s*\)\.")


def candidate_features(program):
    """Features with a bin/3 fact in the program, i.e. those of the pair."""
    return sorted(set(int(f) for f in FEATURE_RE.findall(program)))


class Oracle:
    """The query, grounded once with selected/1 external; one solve per check.

    ground_s is the time spent grounding; on_call(size, unsat, seconds), if
    set, is called after every solve call with the size of the checked subset,
    its verdict and the time of the call."""

    def __init__(self, program, feats):
        self.feats = feats
        t0 = time.perf_counter()
        self.ctl = clingo.Control(["--models=1"])
        self.ctl.add("base", [], program + "\n"
                     + "\n".join(f"#external selected({f})." for f in feats))
        self.ctl.ground([("base", [])])
        self.ground_s = time.perf_counter() - t0
        self.selected = {f: clingo.Function("selected", [clingo.Number(f)]) for f in feats}
        self.calls = 0
        self.on_call = None

    def unsat(self, subset):
        """True iff fixing the features in subset leaves no counterexample."""
        for f, atom in self.selected.items():
            self.ctl.assign_external(atom, f in subset)
        t0 = time.perf_counter()
        unsat = self.ctl.solve().unsatisfiable
        self.calls += 1
        if self.on_call:
            self.on_call(len(subset), unsat, time.perf_counter() - t0)
        return unsat


def shrink(oracle, seed, mcses=(), on_drop=None):
    """Deletion: drop each feature of an UNSAT seed, in increasing order, while
    the rest stays UNSAT. A rest that misses a known MCS lies inside a maximal
    satisfiable subset, so it is SAT without calling the oracle."""
    mus = sorted(seed)
    for f in list(mus):
        rest = [g for g in mus if g != f]
        if any(mcs.isdisjoint(rest) for mcs in mcses):
            continue
        if oracle.unsat(rest):
            mus = rest
            if on_drop:
                on_drop(mus)
    return mus


def enumerate_muses(oracle, n_mus=0, on_drop=None):
    """Yield up to n_mus MUSes (0 = all) with MARCO, shrinking by deletion.
    on_drop(mus) is called whenever the first shrink drops a feature."""
    feats = oracle.feats
    mapper = clingo.Control(["--models=1"])
    mapper.add("base", [], "\n".join(f"{{s({f})}}." for f in feats))
    mapper.ground([("base", [])])
    lit = {f: mapper.symbolic_atoms[clingo.Function("s", [clingo.Number(f)])].literal
           for f in feats}
    muses, mcses = [], []

    while not n_mus or len(muses) < n_mus:
        seed = None
        with mapper.solve(yield_=True) as handle:
            for model in handle:
                seed = {f for f in feats if model.is_true(lit[f])}
                break
        if seed is None:
            return
        # Grow: an added feature keeps every MCS hit, so it is allowed unless
        # it completes a known MUS.
        for f in feats:
            if f not in seed and not any(mus <= seed | {f} for mus in muses):
                seed.add(f)
        if oracle.unsat(seed):
            mus = shrink(oracle, seed, mcses, on_drop if not muses else None)
            muses.append(set(mus))
            with mapper.backend() as backend:
                backend.add_rule([], [lit[f] for f in mus])
            yield mus
        else:
            mcs = set(feats) - seed
            mcses.append(mcs)
            with mapper.backend() as backend:
                backend.add_rule([], [-lit[f] for f in mcs])


def main():
    parser = argparse.ArgumentParser(
        description="Find minimal sets of selected features (MUSes) that make the program UNSAT."
    )
    parser.add_argument("files", nargs="+", help="ASP files to concatenate")
    parser.add_argument("-n", type=int, default=0, metavar="N",
                        help="Number of MUSes to compute (0 = all, default: 0)")
    parser.add_argument("--progress", action="store_true",
                        help="Print the weak AXp left after each feature the first "
                             "shrink drops, so a timed-out run still reports one")
    args = parser.parse_args()

    parts = []
    for path in args.files:
        with open(path) as f:
            parts.append(f.read())

    program = "\n".join(parts)
    feat_indices = candidate_features(program)
    oracle = Oracle(program, feat_indices)

    def on_drop(mus):
        print(f"  weak AXp: selected features = {mus}", flush=True)

    print(f"Running deletion-based MUS extraction with clingo {clingo.__version__} ...",
          flush=True)
    muses = []
    for mus in enumerate_muses(oracle, args.n, on_drop if args.progress else None):
        muses.append(mus)
        print(f"  MUS #{len(muses)}: selected features = {mus}", flush=True)

    if not muses:
        print("No MUSes found.")
    else:
        print(f"\nFound {len(muses)} MUS(es) with {oracle.calls} oracle calls.")


if __name__ == "__main__":
    main()
