# Formal Explanations of Machine Learning Ranking Systems via ASP

Code, models and data for the paper *Formal Explanations of Machine Learning
Ranking Systems via Answer Set Programming* by Francesco Chiariello and Joao
Marques-Silva.

This repository contains the main source files for the Random Forest -> ASP -> MUS
explanation pipeline, plus the datasets and selected trained models needed to
run the examples from a clean checkout.

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

The MUS/explanation commands also require the external `wasp` binary. The
Python `clingo` package installs the Python API and normally provides the
`clingo` command-line executable; `wasp` must be installed separately. Put
`wasp` on `PATH`, or run `compute_mus.py` with one of:

```bash
export WASP_BIN=/path/to/wasp
python3 compute_mus.py --wasp-bin /path/to/wasp ...
```

## Quick Running Example

From the repository root:

```bash
python3 compute_mus.py running+example+model/random_forest.lp encoding.lp \
  running+example+model/pair.lp
```

Expected result: two MUS/AXp explanations over feature indices `[0, 1]` and
`[0, 2]`, corresponding to `{age, bmi}` and `{age, glucose}` in the running
example.

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

Train a forest for any dataset folder:

```bash
python3 learn_random_forest.py data/<dataset> \
  --n-estimators 10 --max-depth 3 \
  --output-dir models/<dataset>/t10_d3
```

Convert the trained model to ASP:

```bash
python3 model2ASP.py models/<dataset>/t10_d3/random_forest.pkl
```

Generate item pairs:

```bash
python3 utils/generate_items.py models/<dataset>/t10_d3/random_forest.pkl --n_pairs 10
```

Compute explanations for one pair:

```bash
python3 compute_mus.py models/<dataset>/t10_d3/random_forest.lp encoding.lp \
  models/<dataset>/t10_d3/pairs/pair_0.lp
```

Run explanation timing over selected models:

```bash
python3 run_explanations.py --models-dir models --pairs 5
```

## Brute-Force Baseline

`benchmark_bruteforce.py` computes the same explanations by exhaustive search,
querying the sklearn forest as a black box under hard majority voting: one AXp
by deletion (`--first`), or all AXps by labelling the whole bin space.
`--validate` cross-checks the results against `encoding.lp` with clingo.

```bash
python3 benchmark_bruteforce.py --validate              # all AXps, chess and heart disease
python3 benchmark_bruteforce.py --first --validate      # first AXp, four small models
```

The baseline columns of the paper's results table were produced on a SLURM
cluster with the table's protocol (2 h first-AXp timeout, then 5 h for all
AXps if the first was found), and summarised in the same layout:

```bash
mkdir -p results/bruteforce/logs && sbatch slurm/bruteforce_table2.sbatch
python3 summarize_bruteforce.py
```

`make_synthetic_models.py` generates forests with a controlled bin space and
number of relevant features, for scaling experiments; `voting_performance.py`
compares the selected forests' test performance under hard and soft voting.

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
