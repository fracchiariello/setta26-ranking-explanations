#!/bin/bash
# ASP results for Table 2 and Figure 4, with the paper's protocol: one array task
# per (repetition, model, pair). Task i runs repetition i / 120 + 1 of pair i % 10
# of the ((i % 120) / 10)-th model in models/*/t*_d* (12 models, 10 pairs,
# 3 repetitions): first AXp with a 2 h timeout, then, only if it was found, all
# AXps with a 5 h timeout. Output goes to
# results/explanations_pair_parts/<dataset>/<config>/pair_<k>_rep_<r>.{txt,json},
# the layout merge_explanation_parts.py reads.
#
# Tasks 0-119 are the first repetition of every experiment. SLURM starts an
# array's pending tasks in index order as cores free up, so every experiment
# starts once before any is repeated, and the repetitions start as soon as there
# is room. CONDA_ENV (default base) provides Python and the clingo executable;
# WASP_BIN is the wasp executable if it is not on PATH. From the repo root on
# CLEPS:
#   mkdir -p results/explanations_pair_parts/logs
#   sbatch --export=ALL,CONDA_ENV=<env>,WASP_BIN=<path/to/wasp> slurm/table2_asp.sbatch
# Then: python merge_explanation_parts.py && python make_table2.py && python plot_instances.py
#
# Within a repetition, tasks 10m..10m+9 belong to model m: 0 automobile,
# 1 bank+marketing, 2 breast+cancer, 3 chess, 4 gamma+telescope, 5 glioma,
# 6 heart+disease, 7 income, 8 obesity, 9 online+shoppers, 10 students+dropout,
# 11 wine+quality.
#SBATCH --job-name=table2_asp
#SBATCH --partition=cpu_homogen
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=07:15:00
#SBATCH --array=0-359
#SBATCH --output=results/explanations_pair_parts/logs/%x_%A_%a.log

source /home/$USER/.bashrc
conda activate "${CONDA_ENV:-base}" || exit 1
[ -n "$WASP_BIN" ] && export PATH="$(dirname "$WASP_BIN"):$PATH"
# run_explanations.py records a missing solver as a run without explanations.
for solver in clingo wasp; do
    command -v "$solver" > /dev/null || { echo "$solver not found on PATH" >&2; exit 1; }
done

MODELS=(models/*/t*_d*)
MODEL=${MODELS[$(((SLURM_ARRAY_TASK_ID % 120) / 10))]}
PAIR=$((SLURM_ARRAY_TASK_ID % 10))
REP=$((SLURM_ARRAY_TASK_ID / 120 + 1))
OUT="results/explanations_pair_parts/$(basename "$(dirname "$MODEL")")/$(basename "$MODEL")"
mkdir -p "$OUT"

python run_explanations.py --pair-files "$MODEL/pairs/pair_${PAIR}.lp" --repeats 1 \
    --timeout-first 7200 --timeout-all 18000 --output "$OUT/pair_${PAIR}_rep_${REP}"
