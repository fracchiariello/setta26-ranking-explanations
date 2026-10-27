"""Shared categorical-feature encoding driven by a dataset config.

A dataset's config.json may carry an optional "feature_encoding" block:

    "feature_encoding": {
        "0": {"Female": 0, "Male": 1},
        "8": {"no": 0, "Sometimes": 1, "Frequently": 2, "Always": 3}
    }

keyed by the feature's absolute column index (as a string). This module applies
that mapping in-place so every script (training, accuracy, agglomerative merge)
converts the categorical columns identically — the config dict is the single
source of truth. Datasets with only numeric features omit the key and are
unaffected.
"""


def apply_feature_encoding(df, config):
    """Encode any categorical feature columns of `df` in place using the config's
    "feature_encoding" dict, and return `df`.

    Each listed column's string values are mapped to ints. Assigning via isetitem
    replaces the column so its dtype becomes numeric. Raises ValueError if a
    column holds a value with no mapping, naming the offending value(s) — this
    surfaces an incomplete config instead of silently producing NaN.
    """
    for col_key, mapping in config.get("feature_encoding", {}).items():
        col = int(col_key)
        encoded = df.iloc[:, col].astype(str).map(mapping)
        if encoded.isna().any():
            bad = sorted(set(df.iloc[:, col].astype(str)[encoded.isna()]))
            raise ValueError(
                f"feature_encoding for column {col} is missing a mapping for "
                f"value(s) {bad} (check config.json)")
        df.isetitem(col, encoded.astype(int))
    return df
