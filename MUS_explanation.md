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


## The WASP Encoding (compute_mus.py)

WASP finds MUSes via the `--mus` flag. To use it, each assumption must be
wrapped in a `__debug__` choice rule:

```prolog
selected(F) :- __debug__(selected(F)).
{__debug__(selected(F))}.
```

This lets WASP control which `selected(F)` facts are active. It then searches
for minimal subsets of `__debug__` atoms whose activation makes the program
UNSAT.

The full pipeline is:

```
clingo --output=smodels program.lp | wasp --mus=__debug__ -n0
```

### `clingo --output=smodels program.lp`

Clingo grounds the ASP program (instantiates all variables with concrete
values) but does not solve it. Instead, `--output=smodels` serialises the
grounded program in the **smodels format** — a low-level numeric encoding of
rules and atoms that WASP can read. The result is piped directly to WASP.

### `wasp --mus=__debug__ -n0`

WASP receives the grounded program and searches for MUSes.

- `--mus=__debug__` tells WASP which atoms are the **assumptions**: only atoms
  whose predicate name is `__debug__` are treated as the candidate set. WASP
  looks for minimal subsets of these atoms whose joint activation makes the
  program UNSAT.
- `-n0` means **find all MUSes** (0 = no limit). Use `-n1` for just the first.


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
    model/breast+cancer+wisconsin+diagnostic/random_forest.lp \
    encoding.lp \
    model/breast+cancer+wisconsin+diagnostic/pair_1.lp
```
