"""
Find minimal sets of selected features (MUSes) that make the query UNSAT.

Usage:
    python compute_mus.py <program.lp> [<program2.lp> ...]

The script concatenates all input files, appends __debug__ wrappers for every
feature found in bin/3 facts, and pipes through:
    clingo --output=smodels | wasp --mus=__debug__ -n0

By default, wasp is resolved from PATH. A custom executable can be supplied with
--wasp-bin or the WASP_BIN environment variable.
"""

import argparse
import os
import re
import subprocess
import sys

import shutil

BASE_DIR = os.path.dirname(os.path.abspath(__file__))


def resolve_executable(candidate):
    """Return an executable path for either a command name or filesystem path."""
    if not candidate:
        return None
    expanded = os.path.expanduser(candidate)
    has_path_part = os.path.sep in expanded or (os.path.altsep and os.path.altsep in expanded)
    if has_path_part:
        return expanded if os.path.isfile(expanded) and os.access(expanded, os.X_OK) else None
    return shutil.which(expanded)


def resolve_wasp_bin(cli_path=None):
    """Resolve wasp without relying on any machine-specific fallback path."""
    candidates = [
        ("--wasp-bin", cli_path),
        ("WASP_BIN", os.environ.get("WASP_BIN")),
        ("PATH", "wasp"),
    ]
    for source, candidate in candidates:
        resolved = resolve_executable(candidate)
        if resolved:
            return resolved

    raise SystemExit(
        "wasp executable not found. Install WASP and either put `wasp` on PATH, "
        "set WASP_BIN=/path/to/wasp, or pass --wasp-bin /path/to/wasp."
    )


def add_debug_wrappers(program: str, feat_indices: list) -> str:
    lines = [program.strip(), ""]
    for f in feat_indices:
        lines.append(f"selected({f}) :- __debug__(selected({f})).")
        lines.append(f"{{__debug__(selected({f}))}}.")
    lines.append("#show __debug__/1.")
    return "\n".join(lines)


def run_wasp_streaming(program: str, wasp_bin: str, n_mus: int = 0, extra_wasp: list = None):
    """Run clingo | wasp --mus, yielding (mus_number, features) as each MUS is found.

    Streams wasp's stdout line by line so intermediate MUSes are printed immediately
    rather than buffered until the end. Any extra_wasp flags (e.g. --print-mcses,
    --stats=2) are appended to the wasp command and their output is echoed live.
    """
    clingo_cmd = ["clingo", "--output=smodels", "-"]
    wasp_cmd = [wasp_bin, "--mus=__debug__", f"-n{n_mus}"] + (extra_wasp or [])

    clingo_proc = subprocess.Popen(
        clingo_cmd, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE,
    )
    stdout_clingo, stderr_clingo = clingo_proc.communicate(input=program.encode())

    if clingo_proc.returncode not in (0, 10, 20, 30):
        print(f"[clingo stderr]\n{stderr_clingo.decode()}", file=sys.stderr)
        raise RuntimeError(f"clingo exited with code {clingo_proc.returncode}")

    wasp_proc = subprocess.Popen(
        ["stdbuf", "-oL"] + wasp_cmd, stdin=subprocess.PIPE, stdout=subprocess.PIPE, stderr=subprocess.PIPE,
    )
    # Feed smodels output and close stdin so wasp starts solving immediately
    wasp_proc.stdin.write(stdout_clingo)
    wasp_proc.stdin.close()

    for raw_line in wasp_proc.stdout:
        line = raw_line.decode()
        m = re.match(r"\[MUS #(\d+)\]:(.*)", line)
        if m:
            idx = int(m.group(1))
            feats = sorted(int(f) for f in re.findall(r"__debug__\(selected\((\d+)\)\)", m.group(2)))
            yield idx, feats
        elif line.strip():
            # Echo intermediate wasp output (e.g. MCSes, stats) live.
            print(line, end="", flush=True)

    wasp_proc.wait()
    stderr_out = wasp_proc.stderr.read().decode()
    if stderr_out.strip():
        print(f"[wasp stderr]\n{stderr_out}", file=sys.stderr)


def main():
    parser = argparse.ArgumentParser(
        description="Find minimal sets of selected features (MUSes) that make the program UNSAT."
    )
    parser.add_argument("files", nargs="+", help="ASP files to concatenate")
    parser.add_argument("-n", type=int, default=0, metavar="N",
                        help="Number of MUSes to compute (0 = all, default: 0)")
    parser.add_argument("--print-mcses", action="store_true",
                        help="Pass --print-mcses to wasp (prints MCSes during MUS computation)")
    parser.add_argument("--stats", nargs="?", const="", default=None, metavar="V",
                        help="Pass --stats[=V] to wasp (V=0 basic, 1 more, 2 dynamic)")
    parser.add_argument("--query-verbosity", type=int, default=None, metavar="V",
                        help="Pass --query-verbosity=V to wasp (0..4, higher = more detail)")
    parser.add_argument("--wasp-bin", default=None, metavar="PATH",
                        help="Path or command name for the wasp executable. "
                             "Defaults to WASP_BIN, then `wasp` on PATH.")
    args = parser.parse_args()

    wasp_bin = resolve_wasp_bin(args.wasp_bin)

    extra_wasp = []
    if args.print_mcses:
        extra_wasp.append("--print-mcses")
    if args.stats is not None:
        extra_wasp.append("--stats" + (f"={args.stats}" if args.stats else ""))
    if args.query_verbosity is not None:
        extra_wasp.append(f"--query-verbosity={args.query_verbosity}")

    parts = []
    for path in args.files:
        with open(path) as f:
            parts.append(f.read())

    program = "\n".join(parts)

    # Derive candidate features from bin/3 facts present in the program
    feat_indices = sorted(set(int(f) for f in re.findall(r"bin\(\s*\d+\s*,\s*(\d+)\s*,\s*\d+\s*\)\.", program)))

    program = add_debug_wrappers(program, feat_indices)

    print(f"Running clingo | wasp --mus ...")
    muses = []
    for idx, feats in run_wasp_streaming(program, wasp_bin, args.n, extra_wasp):
        print(f"  MUS #{idx}: selected features = {feats}", flush=True)
        muses.append(feats)

    if not muses:
        print("No MUSes found.")
    else:
        print(f"\nFound {len(muses)} MUS(es).")


if __name__ == "__main__":
    main()
