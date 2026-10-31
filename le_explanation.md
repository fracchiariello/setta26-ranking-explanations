# How `le` Works (Order Encoding of Bins)

## Bins

For every feature F, `model2ASP.py` collects the thresholds the forest tests
on F and sorts them: θ0 < θ1 < … < θ(K-1). They cut the values of F into
K + 1 bins, numbered 0..K:

| bin | values      |
|-----|-------------|
| 0   | x ≤ θ0      |
| b   | θ(b-1) < x ≤ θb |
| K   | x > θ(K-1)  |

An internal node that tests `x ≤ θb` becomes the fact `node(T,N,F,b)`, and
for any value x:

```
x ≤ θb   iff   bin(x) ≤ b
```

So a node test is a comparison between bin indices. `random_forest.lp` also
gives the largest bin of every feature, `bin_max(F,K)`.


## The Rules (encoding.lp)

```prolog
le(I,F,B)   :- bin(I,F,B).
le(I,F,B+1) :- le(I,F,B), bin_max(F,K), B < K.
```

`le(I,F,b)` means "the bin of item I for feature F is at most b". The first
rule starts at the item's own bin; the second climbs one bin at a time up to
K. So `le(I,F,b)` is true exactly for b ≥ the item's bin, a staircase.

**Example** (the paper's running example): age has thresholds
θ0 = 61.5 and θ1 = 65.5, so 3 bins and `bin_max(1,2)`. An item aged 63 lies
in bin 1:

| atom          | true? | meaning      |
|---------------|-------|--------------|
| `le(I,1,0)`   | no    | age ≤ 61.5   |
| `le(I,1,1)`   | yes   | age ≤ 65.5   |
| `le(I,1,2)`   | yes   | always (top bin) |


## The Traversal

```prolog
next_node(I,T,0)  :- item(I), tree(T).
next_node(I,T,N2) :- next_node(I,T,N1), node(T,N1,F,B), le(I,F,B),     left_node(T,N1,N2).
next_node(I,T,N2) :- next_node(I,T,N1), node(T,N1,F,B), not le(I,F,B), right_node(T,N1,N2).
```

Each node reads one atom: go left if `le(I,F,B)` holds, right otherwise. In
the example, a node `node(T,N,1,0)` (age ≤ 61.5) sends the item right, and a
node `node(T,N,1,1)` (age ≤ 65.5) sends it left.


## Why Not Compare Bins Directly

The earlier encoding compared the item's bin with the node's:

```prolog
next_node(I,T,N2) :- next_node(I,T,N1), node(T,N1,F,B), bin(I,F,Bv), Bv <= B, left_node(T,N1,N2).
next_node(I,T,N2) :- next_node(I,T,N1), node(T,N1,F,B), bin(I,F,Bv), Bv > B,  right_node(T,N1,N2).
```

The grounder cannot know the bin of a free item, so it instantiates these
rules once for every node **and** every bin Bv the item might have: the
program grows with **nodes × bins**.

With `le`, the bin ladder is grounded once per item, feature and bin, and
each node needs only its two traversal rules. The program grows with
**nodes + bins**:

| | ground size per item |
|---|---|
| direct comparison | Σ over nodes of (bins of the tested feature) |
| `le` | Σ over features of (bins) + 2 × nodes |

This matters on deep forests over real-valued features, which have many
thresholds. For example, gamma telescope has 24,466 nodes and about 1,100
thresholds per feature. The direct comparison grounds to tens of millions of
rules (about 56 million). With `le` it grounds to 333,607 rules (Table 1 of
the paper).


## In the Explanation Query

Items 1 and 2 have fixed bins (facts in the pair file). Items 3 and 4 copy
those bins on the selected features and choose them freely on the others
(see `MUS_explanation.md`). Whichever bin the solver picks for a free
feature, the `le` atoms of that item follow from the two rules above, and the
traversal reads them.

A side effect: the solver can reason about whole ranges of bins at once. A
nogood it learns on `le(3,F,b)` covers every bin ≤ b (or > b), not just one.


## Where It Is

- `encoding.lp`: the rules used by the explanation query.
- `compute_axp_bruteforce.py` (`TRAVERSAL_RULES`) and
  `utils/generate_items_clingo.py` (`REASONING_RULES`): the same rules, used
  to label items with clingo.
- `model2ASP.py`: writes the `bin_max(F,K)` facts and maps every threshold to
  its bin index.
