#!/bin/bash
# Brute-force baseline for Table 2, with Table 2's protocol: one AXp (the first,
# by deletion) per (model, pair), with a 1 h timeout; one repetition, on one
# core of the partition used for the paper's experiments. Array task j runs the
# PER_TASK consecutive pairs i = (OFFSET + j) * PER_TASK + k, k < PER_TASK, and
# pair i is pair i % PAIRS of the (i / PAIRS)-th model in models/*/t*_d*
# (10 models, PAIRS = 100 pairs each). A pair that already has a result is
# skipped. With FIRST = n > 0, pairs n, n+1, ... of a model are skipped when
# its first n pairs all have a result and none was solved: submit the first n
# pairs of every model, then the others with --dependency=afterany on them.
#
# SLURM caps array indices at 1000 and CLEPS queues at most 2000 jobs per user,
# so the 1000 pairs go two per task, next to the 1000 ASP tasks.
# CONDA_ENV (default base) provides Python with the packages of
# requirements.txt. From the repo root on CLEPS:
#   mkdir -p results/bruteforce/logs
#   sbatch --export=ALL,CONDA_ENV=<env>,PER_TASK=2 --array=0-499 slurm/bruteforce_table2.sbatch
# or, skipping the models whose first 10 pairs all fail:
#   sbatch --export=ALL,CONDA_ENV=<env>,PER_TASK=2 --array=0-4,50-54,...,450-454 slurm/bruteforce_table2.sbatch
#   sbatch --export=ALL,CONDA_ENV=<env>,PER_TASK=2,FIRST=10 --dependency=afterany:<first job> \
#          --array=5-49,55-99,...,455-499 slurm/bruteforce_table2.sbatch
#
# Pairs 100m..100m+99 are those of model m: 0 automobile, 1 bank+marketing,
# 2 breast+cancer, 3 gamma+telescope, 4 glioma, 5 heart+disease, 6 income,
# 7 obesity, 8 online+shoppers, 9 students+dropout.
#SBATCH --job-name=bf_table2
#SBATCH --partition=cpu_homogen
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --time=02:15:00
#SBATCH --output=results/bruteforce/logs/%x_%A_%a.log

source /home/$USER/.bashrc
conda activate "${CONDA_ENV:-base}" || exit 1
export OMP_NUM_THREADS=1 OPENBLAS_NUM_THREADS=1

PAIRS=${PAIRS:-100}
PER_TASK=${PER_TASK:-1}
MODELS=(models/*/t*_d*)
OUT=results/bruteforce

for K in $(seq 0 $((PER_TASK - 1))); do
    TASK=$(((${OFFSET:-0} + SLURM_ARRAY_TASK_ID) * PER_TASK + K))
    MODEL=${MODELS[$((TASK / PAIRS))]}
    PAIR=$((TASK % PAIRS))
    NAME=$(basename "$(dirname "$MODEL")")
    if [ -s "$OUT/first_${NAME}_pair${PAIR}.json" ]; then
        echo "$NAME pair $PAIR: already done"
        continue
    fi
    if [ "${FIRST:-0}" -gt 0 ] && [ "$PAIR" -ge "$FIRST" ] && python - "$OUT" "$NAME" "$FIRST" <<'PYCHECK'
import json, os, sys
out, name, n = sys.argv[1], sys.argv[2], int(sys.argv[3])
files = [os.path.join(out, f"first_{name}_pair{k}.json") for k in range(n)]
done = all(os.path.exists(f) for f in files)
sys.exit(0 if done and not any(json.load(open(f))[0]["rows"][0]["solved"] for f in files) else 1)
PYCHECK
    then
        echo "$NAME pair $PAIR: skipped, the first $FIRST pairs all failed"
        continue
    fi
    python benchmark_bruteforce.py "$MODEL" --first --pair "$PAIR" --timeout 3600 \
        --json "$OUT/first_${NAME}_pair${PAIR}.json"
done
