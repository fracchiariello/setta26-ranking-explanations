"""Generate the synthetic running-example dataset.

Stroke risk score from four variables assessed at admission:
  age              int    [20, 90]
  bmi              float  [16.0, 45.0]  (one decimal)
  glucose          float  [70.0, 250.0] (one decimal, mg/dL)
  previous_stroke  int    {0, 1}        (~15% prevalence)

Target: risk in {low, medium, high} (ordered severity), defined by an
additive risk-points score. Each variable contributes points
monotonically, so every feature carries independent signal:

  glucose > 126  -> +1     glucose > 180 -> +1 more
  bmi     > 30   -> +1     bmi     > 40  -> +1 more
  age     > 60   -> +1     age     > 75  -> +1 more
  previous_stroke == 1 -> +3

  high   iff  points >= 4
  medium iff  2 <= points <= 3
  low    otherwise

3% of labels are flipped to an adjacent class (noise).
"""
import numpy as np
import pandas as pd
import os

rng = np.random.default_rng(99)
n = 200

age             = rng.integers(20, 91, size=n)
bmi             = np.round(rng.uniform(16.0, 45.0, size=n), 1)
glucose         = np.round(rng.uniform(70.0, 250.0, size=n), 1)
previous_stroke = (rng.uniform(size=n) < 0.15).astype(int)

points = (
    (glucose > 126).astype(int) + (glucose > 180) +
    (bmi > 30).astype(int) + (bmi > 40) +
    (age > 60).astype(int) + (age > 75) +
    previous_stroke * 3
)
y = np.where(points >= 4, 2, np.where(points >= 2, 1, 0))

# 3% label noise: flip a small fraction of labels to an adjacent class
noise_mask = rng.uniform(size=n) < 0.03
for i in np.where(noise_mask)[0]:
    direction = rng.choice([-1, 1])
    y[i] = max(0, min(2, y[i] + direction))

order_risk = {0: 'low', 1: 'medium', 2: 'high'}
risk = np.array([order_risk[v] for v in y])

df = pd.DataFrame({
    'age': age,
    'bmi': bmi,
    'glucose': glucose,
    'previous_stroke': previous_stroke,
    'risk': risk,
})
out = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'running_example.csv')
df.to_csv(out, index=False)
print(f"Wrote {out}: {df.shape[0]} rows")
print(df['risk'].value_counts())
