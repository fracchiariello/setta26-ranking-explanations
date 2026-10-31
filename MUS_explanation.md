# How MUS-based Explanation Works

## The Problem

Given a pair of items (item 1, item 2) where the random forest predicts
class(1) <= class(2), we want to find a **minimal set of features** S such
that: if we force items 3 and 4 to agree with items 1 and 2 respectively on
all features in S, then it is **impossible** for item 3 to be predicted with
a strictly higher class than item 4.

In other words: S is a set of features that **explains the class difference**
between items 1 and 2 — constraining those features is sufficient to prevent
a reversal of the prediction order.


## The Encoding (encoding.lp)

The program encodes the query as an ASP constraint:

```prolog
item(3). item(4).

bin(3,F,B) :- selected(F), bin(1,F,B).   % item 3 copies item 1 on selected features
bin(4,F,B) :- selected(F), bin(2,F,B).   % item 4 copies item 2 on selected features

:- prediction(3,C3), prediction(4,C4), C3 <= C4.   % require class(3) > class(4)
```

- On **selected** features, items 3 and 4 inherit bins from items 1 and 2.
- On **non-selected** features, bins of 3 and 4 are free choices (from the
  choice rules in `random_forest.lp`).
- The constraint requires that item 3 is predicted with a strictly higher
  class than item 4.

The program is **SAT** when there exists an assignment of free bins that
satisfies the constraint (i.e., the selected features alone do not force the
class order).

The program is **UNSAT** when no such assignment exists — meaning the selected
features fully determine that class(3) cannot exceed class(4).


## What is a MUS?

A **Minimal Unsatisfiable Subset (MUS)** is a minimal set of assumptions that
makes the program UNSAT.

Here, each assumption is `selected(F)` for a feature F. A MUS is therefore a
minimal set of features S such that:

> Forcing items 3 and 4 to agree with items 1 and 2 on exactly the features
> in S makes it impossible for item 3 to be predicted higher than item 4.

Minimality means: removing any single feature from S would make the program
SAT again (i.e., the constraint could be satisfied).


## Candidate Features

The set of candidate features is derived automatically in `compute_mus.py`
from the `bin/3` facts present in the input files: every feature F that
appears in a `bin(I,F,B).` fact is a candidate. This means only features
actually assigned to the pair are considered — no external specification needed.


## Deletion-based Extraction (compute_mus.py)

`compute_mus.py` grounds the program once with the clingo Python API, with
every candidate `selected(F)` declared external:

```prolog
#external selected(F).   % one per candidate feature F
```

A candidate set S is then checked with one solve call that sets `selected(F)`
true for F in S and false otherwise: S is a weak AXp iff the call is UNSAT.
Every call reuses the grounding and the nogoods clingo learned in earlier
calls.

### One MUS: deletion

```
S := all candidate features            % UNSAT whenever class(1) <= class(2)
for F in S, in increasing order:
    if S \ {F} is UNSAT: S := S \ {F}
return S
```

Weak AXps are monotone (a superset of a weak AXp is one too), so the final S
is subset-minimal: putting back any one feature was needed for UNSAT when it
was tested, and S has only shrunk since. This takes one solve call per
candidate feature.

### All MUSes: MARCO

A second clingo program, the *map*, has one atom `s(F)` per feature and
holds the subsets not explored yet. Each round:

1. Take a model of the map as a seed, and grow it to a maximal subset allowed
   by the map (a feature is added unless it completes a known MUS).
2. If the seed is UNSAT, shrink it to a MUS by deletion, report it, and add
   `:- s(F1), ..., s(Fk).` for its features: no later seed contains it.
3. If the seed is SAT, it is a maximal satisfiable subset, because every
   feature outside it completes a known MUS. Its complement is a minimal
   correction subset (MCS), and `:- not s(F1), ..., not s(Fk).` makes every
   later seed hit it.

Every MUS hits every MCS, so when the map has no model all MUSes have been
reported. The first seed is all the features, so the first MUS is the one
deletion alone computes. During a shrink, a candidate that misses a known
MCS lies inside a maximal satisfiable subset and is SAT without a solve call.

`-n K` stops after K MUSes (`-n 1`: deletion only); `-n 0` (default) finds
them all.


## Interpreting the Output

Each MUS is a minimal set of features. For example:

```
MUS #8: selected features = [0, 19, 22, 27]
```

This means: if items 3 and 4 are constrained to agree with items 1 and 2 on
features 0, 19, 22, and 27, then no matter how the remaining features are
assigned, the forest cannot predict item 3 higher than item 4. Furthermore,
no proper subset of {0, 19, 22, 27} has this property.

Multiple MUSes represent alternative minimal explanations of the class
difference between items 1 and 2.


## Running

```bash
python compute_mus.py \
    models/breast+cancer/t100_d3/random_forest.lp \
    encoding.lp \
    models/breast+cancer/t100_d3/pairs/pair_1.lp
```

`--progress` also prints the weak AXp left after each feature the first
shrink drops, so a run stopped early still has a (non-minimal) explanation.
