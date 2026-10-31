# Formal Explanations of Machine Learning Ranking Systems via ASP

Code, models and data for the paper *Formal Explanations of Machine Learning
Ranking Systems via Answer Set Programming* by Francesco Chiariello and Joao
Marques-Silva.

This repository contains the main source files for the Random Forest -> ASP -> MUS
explanation pipeline, plus the datasets and selected trained models needed to
run the examples from a clean checkout. MUSes (the abductive explanations) are
computed with the deletion-based algorithm, using clingo as the oracle; all of
them are enumerated with MARCO.

## Contents

- `*.py`, `utils/*.py`: training, ASP conversion, explanation, validation, and
  benchmark scripts.
- `encoding.lp`: dataset-independent ASP rules for tree traversal and voting.
- `requirements.txt`: Python package dependencies.
- `data/`: dataset folders, each with a `config.json`.
- `models/`: selected trained random forests and generated ASP/pair artifacts.
- `running+example+data/` and `running+example+model/`: small paper example.
- `MUS_explanation.md`: background on the MUS formulation.

## Install

```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```

The Python `clingo` package is the only solver needed: `compute_mus.py` uses
its Python API.

## Quick Running Example

From the repository root:

```bash
python3 compute_mus.py running+example+model/random_forest.lp encoding.lp \
  running+example+model/pair.lp
```

Expected result: two MUS/AXp explanations over feature indices `[0, 2]` and
`[0, 1]`, corresponding to `{age, glucose}` and `{age, bmi}` in the running
example. `-n 1` stops after the first, computed by deletion alone.

To check the ASP forest against the pickled sklearn model:

```bash
python3 check_predictions.py running+example+model/random_forest.lp
```

## Rebuild the Running Example

The checked-in model can be regenerated with:

```bash
python3 learn_random_forest.py running+example+data -g \
  --n-estimators 3 --max-depth 2 --min-samples-leaf 8 \
  --ccp-alpha 0.01 --random-state 6 \
  --output-dir running+example+model

python3 model2ASP.py running+example+model/random_forest.pkl \
  --dataset ../running+example+data
```

## Main Pipeline

The models in `models/` follow the setup of Izza and Marques-Silva (IJCAI
2021): 100 trees, entropy criterion, scikit-learn defaults otherwise, 80/20
split, and the maximum depth in 3..8 chosen per dataset. Forests are scored
under hard majority voting (ties to the lowest class), the rule the ASP
encoding explains. `grid_search_config.json` holds this grid; the search trains
every configuration, writes `models/grid_search_performance.txt`, and lists the
highest weighted-F1 model of each dataset (ties: smaller model) in
`models/best_models.txt`:

```bash
python3 grid_search.py --models-root /tmp/grid   # keep the 72 models out of models/
```

Train a single forest:

```bash
python3 learn_random_forest.py data/<dataset> \
  --n-estimators 100 --max-depth 8 --criterion entropy \
  --min-samples-split 2 --min-samples-leaf 1 \
  --output-dir models/<dataset>/t100_d8
```

Convert the trained model to ASP. Bins that no input can reach are merged
(`utils/empty_bins.py`; `--keep-empty-bins` keeps them): on integer-valued
features (every value in the dataset is an integer) the thresholds are moved to
floor(t) + 0.5, on the others to the largest float32 not above t, since the
forest tests float32 inputs; thresholds that coincide become one:

```bash
python3 model2ASP.py models/<dataset>/t100_d8/random_forest.pkl
```

Generate item pairs:

```bash
python3 utils/generate_items.py models/<dataset>/t100_d8/random_forest.pkl --n_pairs 10
```

Compute explanations for one pair:

```bash
python3 compute_mus.py models/<dataset>/t100_d8/random_forest.lp encoding.lp \
  models/<dataset>/t100_d8/pairs/pair_0.lp
```

Run explanation timing over selected models:

```bash
python3 run_explanations.py --models-dir models --pairs 5
```

`voting_performance.py` compares the selected forests under hard and soft
voting; `make_model_table.py` writes the model table with the ground program
sizes.

## Brute-Force Baseline

`benchmark_bruteforce.py` computes the same explanations by exhaustive search,
querying the sklearn forest as a black box under hard majority voting: one AXp
by deletion (`--first`), or all AXps by labelling the whole bin space.
`--validate` cross-checks the results against `encoding.lp` with clingo.

```bash
python3 benchmark_bruteforce.py --first --validate      # first AXp, three small models
python3 benchmark_bruteforce.py <model_dir> --validate  # all AXps (small bin spaces only)
```

The baseline columns of the paper's results table were produced on a SLURM
cluster with the table's protocol (one AXp per pair, 1 h timeout), two pairs
per array task, and summarised in the same layout. Every sufficiency check is
logged with its subset size, verdict, time and combinations labelled:

```bash
mkdir -p results/bruteforce/logs
sbatch --export=ALL,PER_TASK=2 --array=0-499 slurm/bruteforce_table2.sbatch
python3 summarize_bruteforce.py
```

`make_synthetic_models.py` generates forests with a controlled bin space and
number of relevant features, for scaling experiments.

## Paper Results

The ASP columns of the results table and the per-instance figure come from
`slurm/table2_asp.sbatch`: 10 models, 100 pairs, one AXp per pair (deletion),
3 repetitions, with the same timeout. A pair counts as solved only if every
repetition finishes. Each run also logs its grounding time and every solver
call (`call_log` in the JSON: candidate size, verdict, time):

```bash
mkdir -p results/explanations_pair_parts/logs
sbatch --array=0-999 slurm/table2_asp.sbatch
python3 merge_explanation_parts.py
python3 make_table2.py      # results table, with the baseline columns
python3 plot_instances.py   # per-instance figure (time and size of the AXp)
```

## Datasets

The datasets in `data/` are from the UCI Machine Learning Repository
(https://archive.ics.uci.edu), redistributed here for reproducibility; see each
dataset's UCI page for its license and citation.

| Folder | UCI dataset |
|---|---|
| `automobile` | Automobile |
| `bank+marketing` | Bank Marketing |
| `breast+cancer` | Breast Cancer Wisconsin (Diagnostic) |
| `chess` | Chess (King-Rook vs. King) |
| `gamma+telescope` | MAGIC Gamma Telescope |
| `glioma` | Glioma Grading Clinical and Mutation Features |
| `heart+disease` | Heart Disease |
| `income` | Adult |
| `obesity` | Estimation of Obesity Levels Based On Eating Habits and Physical Condition |
| `online+shoppers` | Online Shoppers Purchasing Intention Dataset |
| `students+dropout` | Predict Students' Dropout and Academic Success |
| `wine+quality` | Wine Quality |

## License

The code is released under the MIT license, see `LICENSE`. The datasets keep
their original licenses.
