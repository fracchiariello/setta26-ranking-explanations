#!/bin/bash
# ASP results for Table 2 and Figure 4, with the paper's protocol: one array task
# per (model, pair). Task i runs pair i % PAIRS of the (i / PAIRS)-th model in
# models/*/t*_d* (10 models, PAIRS = 100 pairs each), with i = OFFSET +
# SLURM_ARRAY_TASK_ID: one AXp (the first, by deletion) with a 1 h timeout,
# repeated REPEATS = 3 times in a row. A pair counts as solved only if every
# repetition finishes, so run_explanations.py stops at the first timeout.
# Output goes to
# results/explanations_pair_parts/<dataset>/<config>/pair_<k>_rep_1.{txt,json},
# the layout merge_explanation_parts.py reads.
#
# SLURM caps array indices at 1000; OFFSET runs tasks beyond it.
# CONDA_ENV (default base) provides Python and the clingo package
# (requirements.txt). From the repo root on CLEPS:
#   mkdir -p results/explanations_pair_parts/logs
#   sbatch --export=ALL,CONDA_ENV=<env> --array=0-999 slurm/table2_asp.sbatch
# Then: python merge_explanation_parts.py && python make_table2.py && python plot_instances.py
#
# Tasks 100m..100m+99 belong to model m: 0 automobile, 1 bank+marketing,
# 2 breast+cancer, 3 gamma+telescope, 4 glioma, 5 heart+disease, 6 income,
# 7 obesity, 8 online+shoppers, 9 students+dropout.
#SBATCH --job-name=table2_asp
#SBATCH --partition=cpu_homogen
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=03:15:00
#SBATCH --output=results/explanations_pair_parts/logs/%x_%A_%a.log

source /home/$USER/.bashrc
conda activate "${CONDA_ENV:-base}" || exit 1
python -c "import clingo" || { echo "clingo Python package not found" >&2; exit 1; }

PAIRS=${PAIRS:-100}
REPEATS=${REPEATS:-3}
TASK=$((${OFFSET:-0} + SLURM_ARRAY_TASK_ID))
MODELS=(models/*/t*_d*)
MODEL=${MODELS[$((TASK / PAIRS))]}
PAIR=$((TASK % PAIRS))
OUT="results/explanations_pair_parts/$(basename "$(dirname "$MODEL")")/$(basename "$MODEL")"
mkdir -p "$OUT"

python run_explanations.py --pair-files "$MODEL/pairs/pair_${PAIR}.lp" --repeats "$REPEATS" \
    --first-only --timeout-first 3600 --output "$OUT/pair_${PAIR}_rep_1"
