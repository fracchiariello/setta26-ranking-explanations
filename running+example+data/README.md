# Running Example — Stroke Risk Score

A deliberately small example for the paper: a random forest that assigns a
stroke risk score to a patient from four variables routinely available at
admission. Small enough that every artifact of the pipeline (forest, ASP
encoding, explanation) can be shown in full.

## Scenario

Four features are recorded for each patient:

| Feature           | Type  | Range              |
|-------------------|-------|--------------------|
| `age`             | int   | 20–90              |
| `bmi`             | float | 16.0–45.0          |
| `glucose`         | float | 70.0–250.0 (mg/dL) |
| `previous_stroke` | {0,1} | 0 = no, 1 = yes    |

The model assigns one of three ordered risk scores:

| Score    | Value |
|----------|-------|
| `low`    | 0     |
| `medium` | 1     |
| `high`   | 2     |

## Dataset

`running_example.csv` — 200 synthetic patients, generated deterministically
by `generate_data.py` (numpy seed 99). Ground truth is an additive
risk-points score; every variable contributes monotonically:

| Condition              | Points |
|------------------------|--------|
| glucose > 126          | +1     |
| glucose > 180          | +1     |
| bmi > 30               | +1     |
| bmi > 40               | +1     |
| age > 60               | +1     |
| age > 75               | +1     |
| previous_stroke = 1    | +3     |

- **high** if points ≥ 4, **medium** if 2–3, **low** otherwise.

3% of labels are randomly flipped to an adjacent class (noise).
Class distribution: low 51 / medium 86 / high 63.

## Trained forest

```bash
python3 learn_random_forest.py running+example+data -g \
  --n-estimators 3 --max-depth 2 --min-samples-leaf 8 \
  --ccp-alpha 0.01 --random-state 6 \
  --output-dir running+example+model
```

3 trees of depth 2, 77.5% test accuracy. The trees are structurally diverse
(distinct root features, 4+3+4 leaves), all four features are used, and every
split is clinically monotone — older age, higher BMI, higher glucose, and a
prior stroke can only increase the predicted risk:

```
Tree 0:  age <= 61.5 ?  [bmi <= 38.85 ? low : medium]
                      :  [glucose <= 178.75 ? medium : high]
Tree 1:  previous_stroke ?  high  :  [glucose <= 172.15 ? medium : high]
Tree 2:  glucose <= 125.5 ?  [age <= 65 ? low : medium]
                          :  [bmi <= 38 ? medium : high]
```

Each tree reads like a distinct clinical heuristic: tree 0 is age-driven,
tree 1 is stroke-history-driven, tree 2 is metabolic (glucose + obesity).
Feature importances: glucose 0.54, bmi 0.20, age 0.15, previous_stroke 0.11.

## ASP encoding

```bash
python3 model2ASP.py running+example+model/random_forest.pkl \
  --dataset ../running+example+data
```

Produces `running+example+model/random_forest.lp`. Feature discretization:

| Feature           | Bins | Thresholds             |
|-------------------|------|------------------------|
| `age`             | 3    | 61.5, 65.0             |
| `bmi`             | 3    | 38.0, 38.85            |
| `glucose`         | 4    | 125.5, 172.15, 178.75  |
| `previous_stroke` | 2    | 0.5 (0 vs 1)           |

## Explanation example

`pair.lp` contains two patients with different predicted scores; patient 2 is
worse on age, BMI, and previous stroke history while glucose stays in the same
low bin:

| Patient | age          | bmi            | glucose          | prev_stroke | Score |
|---------|--------------|----------------|------------------|-------------|-------|
| 1       | ≤61.5        | ≤38.0          | ≤125.5           | 0           | low   |
| 2       | >65.0        | >38.85         | ≤125.5           | 1           | medium |

```bash
python3 compute_mus.py running+example+model/random_forest.lp encoding.lp \
  running+example+model/pair.lp
```

```
MUS #1: selected features = [0, 1]       % age + bmi
MUS #2: selected features = [0, 2]       % age + glucose
```

Two alternative minimal explanations of why patient 2 scores higher:

- **MUS #1 — {age, bmi}**: age and BMI together force the ordering. No matter
  how glucose and previous stroke history are assigned, an item matching
  patient 1's younger/lower-BMI profile cannot be predicted above an item
  matching patient 2's older/higher-BMI profile.

- **MUS #2 — {age, glucose}**: age plus the shared low-glucose bin also forces
  the ordering. The set is minimal: age alone or glucose alone still leaves a
  free-feature assignment under which patient 1's proxy could outrank patient
  2's proxy.

Both explanations include age. Previous stroke history is part of the pair's
difference, but it is not needed in any subset-minimal abductive explanation
for this checked-in pair.
