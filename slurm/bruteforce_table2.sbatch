#!/bin/bash
# Brute-force baseline for Table 2, with Table 2's protocol: one array task per
# (model, pair). Task i runs pair i % 10 of the (i / 10)-th model in
# models/*/t*_d* (12 models, 10 pairs each): first AXp with a 2 h timeout, then,
# only if it was found, all AXps with a 5 h timeout. One core of the partition
# used for the paper's experiments; one repetition.
#
# From the repo root on CLEPS:
#   mkdir -p results/bruteforce/logs && sbatch slurm/bruteforce_table2.sbatch
#
# Tasks 10m..10m+9 are the pairs of model m: 0 automobile, 1 bank+marketing,
# 2 breast+cancer, 3 chess, 4 gamma+telescope, 5 glioma, 6 heart+disease,
# 7 income, 8 obesity, 9 online+shoppers, 10 students+dropout, 11 wine+quality.
#SBATCH --job-name=bf_table2
#SBATCH --partition=cpu_homogen
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=07:15:00
#SBATCH --array=0-119
#SBATCH --output=results/bruteforce/logs/%x_%A_%a.log

source /home/$USER/.bashrc
conda activate setta
export OMP_NUM_THREADS=1 OPENBLAS_NUM_THREADS=1

MODELS=(models/*/t*_d*)
MODEL=${MODELS[$((SLURM_ARRAY_TASK_ID / 10))]}
PAIR=$((SLURM_ARRAY_TASK_ID % 10))
NAME=$(basename "$(dirname "$MODEL")")
OUT=results/bruteforce

python benchmark_bruteforce.py "$MODEL" --first --pair "$PAIR" --timeout 7200 \
    --json "$OUT/first_${NAME}_pair${PAIR}.json"

# As in Table 2, all AXps are enumerated only when the first AXp was found.
if python -c 'import json, sys; sys.exit(not json.load(open(sys.argv[1]))[0]["rows"][0]["solved"])' \
        "$OUT/first_${NAME}_pair${PAIR}.json"; then
    python benchmark_bruteforce.py "$MODEL" --pair "$PAIR" --timeout 18000 \
        --json "$OUT/all_${NAME}_pair${PAIR}.json"
else
    echo "first AXp not found: all AXps not attempted"
fi
