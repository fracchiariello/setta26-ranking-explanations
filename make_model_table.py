"""Regenerate the per-dataset best-model LaTeX table, including ASP program size.

For each pruned best model (models/<dataset>/t*_d*/), this:
  - reads model_statistics.txt for the model facts and weighted-F1;
  - reports the realized maximum tree depth from the Forest Size section, not
    the configured --max-depth cap;
  - grounds the FULL ASP program (encoding.lp + random_forest.lp + pairs/pair_0.lp,
    with selected(F) asserted for pair_0 features) and parses the grounded size
    (#rules, #atoms);
  - writes a booktabs LaTeX table to models/model_info_table.tex.

Program size uses a single representative pair (pairs/pair_0.lp), so the model's
pairs must already be generated (utils/generate_items.py). The size
reflects the full program actually solved: encoding + forest + pair_0 items,
plus selected(F) facts for every feature in pair_0.

Run from the repo root:
    python make_model_table.py
Requires clingo on PATH.
"""
import glob
import os
import re
import subprocess

BASE = os.path.dirname(os.path.abspath(__file__))
ENCODING = os.path.join(BASE, "encoding.lp")
PAIR = "pair_0.lp"          # representative pair used for the program size
CLINGO_TIMEOUT = 180        # seconds per dataset; None entries marked "--"


def grab(text, pat, cast=str):
    m = re.search(pat, text)
    return cast(m.group(1)) if m else None


def model_stats(stats_path):
    t = open(stats_path).read()
    um = re.search(r"Used \((\d+)/(\d+)\)", t)
    forest_size = re.search(r"Forest Size:\n(?P<body>.*?)(?:\n\n|$)", t, re.S)
    forest_text = forest_size.group("body") if forest_size else t
    return dict(
        trees=grab(t, r"Number of trees:\s*(\d+)", int),
        actual_depth=grab(forest_text, r"Max depth:\s*(\d+)\s*\(avg", int),
        nodes=grab(t, r"Total nodes:\s*(\d+)", int),
        avgsplit=grab(t, r"Avg split points per feature:\s*([\d.]+)", float),
        used=int(um.group(1)) if um else None,
        nfeat=grab(t, r"Number of features:\s*(\d+)", int),
        ncls=grab(t, r"Number of classes:\s*(\d+)", int),
        predcls=grab(t, r"Classes predicted:\s*(\d+)", int),
        wf1=grab(t, r"weighted avg\s+[\d.]+\s+[\d.]+\s+([\d.]+)", float),
    )


def program_size(rf_lp, pair_lp):
    """Ground encoding+forest+pair_0; return (rules, atoms) or (None, None) on
    timeout/failure.

    selected(F) is asserted for EVERY feature the pair assigns (the F's in its
    bin(_,F,_) facts), so the explanation machinery (the item 3/4 derivations
    in encoding.lp, guarded by selected(F)) actually grounds — otherwise
    selected/1 is undefined and those rules collapse to nothing. Feature
    derivation matches compute_mus.py.
    """
    pair_text = open(pair_lp).read()
    feats = sorted(set(int(f) for f in re.findall(
        r"bin\(\s*\d+\s*,\s*(\d+)\s*,\s*\d+\s*\)\.", pair_text)))
    selected_facts = "\n".join(f"selected({f})." for f in feats) + "\n"
    # Ground only (--mode=gringo, aspif output), with NO solving, so the program
    # is not simplified. With selected(F) for every pair feature the program is
    # UNSAT, which would make the solver report Atoms=0 (no Original count kept);
    # the grounder's aspif output gives the true size regardless of SAT/UNSAT.
    try:
        out = subprocess.run(
            ["clingo", "--mode=gringo", ENCODING, rf_lp, pair_lp, "-"],
            input=selected_facts,
            capture_output=True, text=True, timeout=CLINGO_TIMEOUT,
        ).stdout
    except subprocess.TimeoutExpired:
        return None, None
    # Parse the aspif stream. Rule statements start with "1"; atom IDs are dense
    # from 1, so the max atom ID over all statement tokens equals the number of
    # atoms INCLUDING auxiliaries (choice/aggregate atoms clingo introduces) —
    # matching the solver's pre-simplification atom count.
    rules = 0
    max_atom = 0
    for ln in out.splitlines():
        toks = ln.split()
        if not toks or not toks[0].isdigit():
            continue
        if toks[0] == "1":            # rule statement
            rules += 1
        for tok in toks[1:]:
            if tok.lstrip("-").isdigit():
                max_atom = max(max_atom, abs(int(tok)))
    return rules, max_atom


def main():
    rows = []
    for rf_lp in sorted(glob.glob(os.path.join(BASE, "models", "*", "t*_d*", "random_forest.lp"))):
        mdir = os.path.dirname(rf_lp)
        ds = os.path.basename(os.path.dirname(mdir))
        stats = os.path.join(mdir, "model_statistics.txt")
        if not os.path.exists(stats):
            continue
        info = model_stats(stats)
        pair_lp = os.path.join(mdir, "pairs", PAIR)
        if os.path.exists(pair_lp):
            info["rules"], info["atoms"] = program_size(rf_lp, pair_lp)
        else:
            info["rules"] = info["atoms"] = None
            print(f"[warn] {ds}: {pair_lp} missing — size left blank")
        info["ds"] = ds
        rows.append(info)
        print(f"{ds:22s} rules={info['rules']} atoms={info['atoms']}")

    def num(v):
        return str(v) if v is not None else "--"

    L = [
        r"\begin{table}[t]",
        r"\centering",
        r"\caption{Best random forest per dataset (selected by weighted $F_1$) and "
        r"the size of the full ASP program "
        r"(\texttt{encoding.lp} + forest + \texttt{pair\_0.lp}, with "
        r"$\mathit{selected}(F)$ asserted for every feature in \texttt{pair\_0.lp}). "
        r"$T$: trees; $D_{\max}$: realized maximum tree depth; "
        r"Feat: features used by the forest (dataset features in parentheses); "
        r"$C$: classes predicted on the test set (dataset classes in parentheses); "
        r"Nodes: forest nodes; Split: avg.\ split points per feature; "
        r"$F_1^{W}$: weighted $F_1$ on the test set; "
        r"Rules: ground rules; Atoms: ground atoms incl.\ auxiliaries (both "
        r"pre-simplification, from the grounder).}",
        r"\label{tab:model-info}",
        r"\small",
        r"\begin{tabular}{lrrrrrrrrr}",
        r"\toprule",
        r"Dataset & $T$ & $D_{\max}$ & Feat & $C$ & Nodes & Split & $F_1^{W}$ & Rules & Atoms \\",
        r"\midrule",
    ]
    for r in rows:
        L.append(
            f"{r['ds']} & {r['trees']} & {r['actual_depth']} & "
            f"{r['used']} ({r['nfeat']}) & {r['predcls']} ({r['ncls']}) & "
            f"{r['nodes']} & {r['avgsplit']:.1f} & "
            f"{r['wf1']:.3f} & {num(r['rules'])} & {num(r['atoms'])} \\\\")
    L += [r"\bottomrule", r"\end{tabular}", r"\end{table}"]

    out = "\n".join(L) + "\n"
    out_path = os.path.join(BASE, "models", "model_info_table.tex")
    open(out_path, "w").write(out)
    print(f"\nWrote {out_path}")


if __name__ == "__main__":
    main()
