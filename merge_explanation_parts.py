"""Merge per-pair/per-repetition batch explanation outputs.

The pair-level batch runner writes one JSON/TXT file per task:
    results/explanations_pair_parts/<dataset>/<config>/pair_N_rep_R.txt
    results/explanations_pair_parts/<dataset>/<config>/pair_N_rep_R.json

Older one-task-per-pair outputs named pair_N.txt/json are also accepted and are
treated as a single repetition. The merged JSON contains one aggregate record
per dataset/config/pair, with AXp statistics and timings aggregated across
completed repetitions.
"""

import datetime
import glob
import json
import math
import os
import re


BASE_DIR = os.path.dirname(os.path.abspath(__file__))
PARTS_DIR_ENV = os.environ.get("EXPLANATION_PARTS_DIR")
PARTS_DIR = (
    PARTS_DIR_ENV
    if PARTS_DIR_ENV and os.path.isabs(PARTS_DIR_ENV)
    else os.path.join(BASE_DIR, PARTS_DIR_ENV or os.path.join("results", "explanations_pair_parts"))
)
RESULTS_DIR = os.path.join(BASE_DIR, "results")


def sort_key(path):
    rel = os.path.relpath(path, PARTS_DIR)
    return rel.replace(os.sep, "/")


def mean_std(values):
    values = [v for v in values if v is not None]
    if not values:
        return None, None
    mean = sum(values) / len(values)
    std = math.sqrt(sum((v - mean) ** 2 for v in values) / len(values))
    return mean, std


def fmt_t(mean, std=None, repeats=1):
    if mean is None:
        return "TIMEOUT"
    if repeats > 1 and std is not None:
        return f"{mean * 1000:.1f} +/- {std * 1000:.1f} ms"
    return f"{mean * 1000:.1f} ms"


def latex_escape_model(text):
    return text.replace("+", r"\texttt{+}").replace("_", r"\_")


def latex_time(section):
    if not section:
        return r"\textemdash"
    if section.get("timeout") or section.get("time_mean_s") is None:
        return r"\textsc{timeout}"
    std = section.get("time_std_s")
    if std is None:
        return f"{section['time_mean_s']:.2f}"
    return rf"${section['time_mean_s']:.2f} \pm {std:.2f}$"


def latex_int(value):
    return r"\textemdash" if value is None else str(value)


def latex_avg(value):
    return r"\textemdash" if value is None else f"{float(value):.1f}"


def clean_number(value, decimals=2, integer_when_exact=False):
    if value is None:
        return r"\textemdash"
    if integer_when_exact and abs(value - round(value)) < 1e-9:
        return str(int(round(value)))
    return f"{value:.{decimals}f}"


def latex_stat(mean, std=None, decimals=2, integer_when_exact=False, lower_bound=False):
    if mean is None:
        return r"\textemdash"
    mean_text = clean_number(mean, decimals, integer_when_exact)
    if std is None or abs(std) < 1e-12:
        return rf"$\geq {mean_text}$" if lower_bound else mean_text
    stat = rf"{mean_text} \pm {std:.{decimals}f}"
    return rf"$\geq {stat}$" if lower_bound else rf"${stat}$"


def latex_values(values, decimals=2, integer_when_exact=False):
    values = [v for v in (values or []) if v is not None]
    if not values:
        return r"\textemdash"
    formatted = [clean_number(float(v), decimals, integer_when_exact) for v in values]
    return "(" + ", ".join(formatted) + ")"


def latex_count(section):
    if not section:
        return r"\textemdash"
    count = section.get("count_mean")
    if count is None:
        count = section.get("count")
    if count is None:
        return r"\textemdash"
    return latex_stat(
        count,
        section.get("count_std"),
        decimals=2,
        integer_when_exact=True,
        lower_bound=section.get("count_partial") or section.get("timeout"),
    )


def pair_number(pair_name):
    match = re.search(r"pair_(\d+)\.lp$", pair_name or "")
    return int(match.group(1)) if match else 10**9


def first_completed(records, section):
    for rec in records:
        value = rec.get(section)
        if value and not value.get("timeout"):
            return value
    for rec in records:
        value = rec.get(section)
        if value:
            return value
    return None


def aggregate_section(records, section):
    sections = [r.get(section) for r in records if r.get(section) is not None]
    if not sections:
        return None

    available_repetitions = len(sections)
    # A timed-out all-AXPs computation is a censored result. If at least one
    # repetition completed, aggregate only the completed repetitions. If none
    # completed, keep one representative timeout iteration. The raw part
    # records remain available in the merged JSON for provenance.
    if section == "all":
        completed_sections = [s for s in sections if not s.get("timeout")]
        timed_out_sections = [s for s in sections if s.get("timeout")]
        if completed_sections:
            sections = completed_sections
        elif timed_out_sections:
            sections = timed_out_sections[:1]

    completed = [s for s in sections if not s.get("timeout")]
    source = sections[0] if section == "all" else first_completed(records, section)
    mean, std = mean_std(s.get("time_mean_s") for s in completed)
    timed_out = any(s.get("timeout") for s in sections)
    completed_or_partial = completed or sections

    if section == "first":
        return {
            "size": source.get("size") if source else None,
            "size_values": [s.get("size") for s in completed_or_partial],
            "axp": source.get("axp") if source else None,
            "time_mean_s": mean,
            "time_std_s": std,
            "timeout": timed_out,
            "timeout_repetitions": sum(1 for s in sections if s.get("timeout")),
            "completed_repetitions": len(completed),
            "considered_repetitions": len(sections),
            "available_repetitions": available_repetitions,
        }

    return {
        "count": source.get("count") if source else 0,
        "count_mean": mean_std(s.get("count") for s in completed)[0],
        "count_std": mean_std(s.get("count") for s in completed)[1],
        "count_partial": any(s.get("count_partial") for s in sections),
        "min_size": source.get("min_size") if source else 0,
        "min_size_values": [s.get("min_size") for s in completed_or_partial],
        "min_size_mean": mean_std(s.get("min_size") for s in completed)[0],
        "min_size_std": mean_std(s.get("min_size") for s in completed)[1],
        "max_size": source.get("max_size") if source else 0,
        "max_size_values": [s.get("max_size") for s in completed_or_partial],
        "max_size_mean": mean_std(s.get("max_size") for s in completed)[0],
        "max_size_std": mean_std(s.get("max_size") for s in completed)[1],
        "avg_size": source.get("avg_size") if source else 0.0,
        "avg_size_values": [s.get("avg_size") for s in completed_or_partial],
        "avg_size_mean": mean_std(s.get("avg_size") for s in completed)[0],
        "avg_size_std": mean_std(s.get("avg_size") for s in completed)[1],
        "time_mean_s": mean,
        "time_std_s": std,
        "timeout": timed_out,
        "timeout_repetitions": sum(1 for s in sections if s.get("timeout")),
        "completed_repetitions": len(completed),
        "considered_repetitions": len(sections),
        "available_repetitions": available_repetitions,
        "axps": source.get("axps") if source else [],
    }


def aggregate_records(records):
    grouped = {}
    for rec in records:
        key = (rec.get("dataset"), rec.get("config"), rec.get("pair"))
        grouped.setdefault(key, []).append(rec)

    aggregated = []
    for key in sorted(grouped):
        reps = grouped[key]
        first = aggregate_section(reps, "first")
        all_axps = aggregate_section(reps, "all")
        aggregated.append({
            "dataset": key[0],
            "config": key[1],
            "pair": key[2],
            "n_features": reps[0].get("n_features"),
            "repetitions": len(reps),
            "first": first,
            "all": all_axps,
            "part_records": [
                {
                    "source": r.get("_source"),
                    "first_timeout": (r.get("first") or {}).get("timeout"),
                    "all_timeout": (r.get("all") or {}).get("timeout"),
                }
                for r in reps
            ],
        })
    return aggregated


def write_summary(out, records):
    out.write("=" * 92 + "\n")
    out.write("AGGREGATED EXPLANATION EXPERIMENTS  (per-pair repetitions)\n")
    out.write("=" * 92 + "\n\n")

    by_model = {}
    for rec in records:
        by_model.setdefault((rec["dataset"], rec["config"]), []).append(rec)

    pair_col = 10
    t_col = 24
    for (dataset, config), rows in sorted(by_model.items()):
        out.write("\n" + "-" * 110 + "\n")
        out.write(f"Model: {dataset}/{config}   ({len(rows)} pairs)\n")
        out.write("-" * 110 + "\n")
        out.write(f"  {'Pair':<{pair_col}}  {'Rep':>3}  {'Feats':>5}  "
                  f"{'1st size':>8}  {'1st time':>{t_col}}  "
                  f"{'#AXps':>6}  {'min':>4}  {'max':>4}  {'avg':>5}  {'All time':>{t_col}}\n")
        out.write(f"  {'-'*pair_col}  {'-'*3}  {'-'*5}  {'-'*8}  {'-'*t_col}  "
                  f"{'-'*6}  {'-'*4}  {'-'*4}  {'-'*5}  {'-'*t_col}\n")
        for rec in rows:
            first = rec.get("first") or {}
            all_axps = rec.get("all") or {}
            rep = rec.get("repetitions", 1)
            first_time = fmt_t(first.get("time_mean_s"), first.get("time_std_s"), rep)
            all_time = fmt_t(all_axps.get("time_mean_s"), all_axps.get("time_std_s"), rep) if all_axps else "-"
            count = all_axps.get("count") if all_axps else "-"
            if all_axps and all_axps.get("count_partial"):
                count = f">={count}"
            out.write(f"  {rec['pair']:<{pair_col}}  {rep:>3}  {rec.get('n_features', '-'):>5}  "
                      f"{str(first.get('size', '-')):>8}  {first_time:>{t_col}}  "
                      f"{str(count):>6}  {str(all_axps.get('min_size', '-')):>4}  "
                      f"{str(all_axps.get('max_size', '-')):>4}  "
                      f"{float(all_axps.get('avg_size', 0.0)):>5.1f}  {all_time:>{t_col}}\n")


def write_latex_table(out, records):
    out.write(r"\begin{landscape}" + "\n")
    out.write(r"\begin{longtable}{@{}lrrrrrrr@{}}" + "\n")
    out.write(r"\caption{Explanation experiment results for all model--pair instances. Times are reported in seconds.}" + "\n")
    out.write(r"\label{tab:explanation-results-seconds}\\" + "\n")
    out.write(r"\toprule" + "\n")
    out.write(r"Model & 1st size & 1st time & \#AXps & Min & Max & Avg & All time \\" + "\n")
    out.write(r"\midrule" + "\n")
    out.write(r"\endfirsthead" + "\n")
    out.write(r"\multicolumn{8}{c}{\tablename\ \thetable\ -- continued from previous page} \\" + "\n")
    out.write(r"\toprule" + "\n")
    out.write(r"Model & 1st size & 1st time & \#AXps & Min & Max & Avg & All time \\" + "\n")
    out.write(r"\midrule" + "\n")
    out.write(r"\endhead" + "\n")
    out.write(r"\midrule" + "\n")
    out.write(r"\multicolumn{8}{r}{Continued on next page} \\" + "\n")
    out.write(r"\endfoot" + "\n")
    out.write(r"\bottomrule" + "\n")
    out.write(r"\endlastfoot" + "\n")

    by_model = {}
    for rec in records:
        by_model.setdefault((rec["dataset"], rec["config"]), []).append(rec)

    for model_index, ((dataset, config), rows) in enumerate(sorted(by_model.items())):
        if model_index:
            out.write(r"\addlinespace" + "\n")
        model = latex_escape_model(f"{dataset}/{config}")
        for row_index, rec in enumerate(sorted(rows, key=lambda r: pair_number(r.get("pair")))):
            first = rec.get("first") or {}
            all_axps = rec.get("all") or {}
            model_cell = model if row_index == 0 else ""
            first_size = latex_values(first.get("size_values"), decimals=2, integer_when_exact=True)
            first_time = latex_time(first)
            count = latex_count(all_axps)
            min_size = latex_values(all_axps.get("min_size_values") if all_axps else None,
                                    decimals=2, integer_when_exact=True)
            max_size = latex_values(all_axps.get("max_size_values") if all_axps else None,
                                    decimals=2, integer_when_exact=True)
            avg_size = latex_values(all_axps.get("avg_size_values") if all_axps else None,
                                    decimals=2)
            all_time = latex_time(all_axps) if all_axps else r"\textemdash"
            out.write(
                f"{model_cell} & {first_size} & {first_time} & {count} & "
                f"{min_size} & {max_size} & {avg_size} & {all_time} " + r"\\" + "\n"
            )

    out.write(r"\end{longtable}" + "\n")
    out.write(r"\end{landscape}" + "\n")


def main():
    os.makedirs(RESULTS_DIR, exist_ok=True)
    json_parts = sorted(
        glob.glob(os.path.join(PARTS_DIR, "*", "*", "pair_*.json")),
        key=sort_key,
    )
    txt_parts = sorted(
        glob.glob(os.path.join(PARTS_DIR, "*", "*", "pair_*.txt")),
        key=sort_key,
    )
    if not json_parts and not txt_parts:
        raise SystemExit(f"No per-pair result files found under {PARTS_DIR}")

    ts = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
    out_json = os.path.join(RESULTS_DIR, f"explanations_pair_merged_{ts}.json")
    out_txt = os.path.join(RESULTS_DIR, f"explanations_pair_merged_{ts}.txt")
    out_tex = os.path.join(RESULTS_DIR, f"explanations_pair_merged_{ts}.tex")

    records = []
    part_meta = []
    for path in json_parts:
        with open(path) as f:
            data = json.load(f)
        rel = os.path.relpath(path, BASE_DIR)
        results = data.get("results", [])
        part_meta.append({
            "path": rel,
            "generated": data.get("generated"),
            "params": data.get("params", {}),
            "n_results": len(results),
        })
        for rec in results:
            rec["_source"] = rel
            records.append(rec)

    aggregated = aggregate_records(records)

    with open(out_json, "w") as f:
        json.dump({
            "generated": ts,
            "parts_dir": os.path.relpath(PARTS_DIR, BASE_DIR),
            "n_parts": len(json_parts),
            "n_raw_results": len(records),
            "n_results": len(aggregated),
            "parts": part_meta,
            "results": aggregated,
        }, f, indent=2)

    with open(out_txt, "w") as out:
        write_latex_table(out, aggregated)
        out.write("\n\n" + "=" * 92 + "\n")
        out.write("RAW PART OUTPUTS\n")
        out.write("=" * 92 + "\n")
        out.write(f"Generated: {ts}\n")
        out.write(f"Parts: {len(txt_parts)} text files, {len(json_parts)} json files\n")
        out.write(f"Raw records: {len(records)}   Aggregated records: {len(aggregated)}\n")
        for path in txt_parts:
            rel = os.path.relpath(path, BASE_DIR)
            out.write("\n" + "#" * 92 + "\n")
            out.write(f"# {rel}\n")
            out.write("#" * 92 + "\n")
            with open(path) as f:
                out.write(f.read())
            out.write("\n")

    with open(out_tex, "w") as out:
        write_latex_table(out, aggregated)

    print(f"Merged {len(json_parts)} json parts and {len(txt_parts)} text parts")
    print(f"Aggregated {len(records)} raw records into {len(aggregated)} pair records")
    print(f"Wrote:\n  {os.path.relpath(out_txt, BASE_DIR)}\n  {os.path.relpath(out_tex, BASE_DIR)}\n  {os.path.relpath(out_json, BASE_DIR)}")


if __name__ == "__main__":
    main()
