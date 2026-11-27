#!/usr/bin/env python3
"""Rewrites the list of error codes in README.md from content/fehler/*.md.

The list sits between two marker comments. Run it after adding or renaming an
error page:  python3 tools/readme_codes.py   (--check fails if the list is stale)
"""
import pathlib
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
BASE = "https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/"
START, END = "<!-- fehlercodes:start -->", "<!-- fehlercodes:end -->"


def header(path):
    fields = {}
    for line in path.read_text(encoding="utf-8").splitlines():
        if not line.strip():
            break
        key, _, value = line.partition(":")
        fields[key.strip()] = value.strip()
    return fields


def table():
    rows = ["| Regel | Fehler | Erklärung |", "|---|---|---|"]
    for path in sorted((ROOT / "content" / "fehler").glob("*.md")):
        fields = header(path)
        code, _, text = fields["h1"].partition(": ")
        rows.append(f"| {code} | {text.replace('|', '/')} | [{fields['slug']}]({BASE}{fields['slug']}/) |")
    return "\n".join(rows)


def main():
    readme = ROOT / "README.md"
    old = readme.read_text(encoding="utf-8")
    head, rest = old.split(START)
    _, tail = rest.split(END)
    new = f"{head}{START}\n{table()}\n{END}{tail}"
    if "--check" in sys.argv:
        sys.exit(0 if new == old else "README.md: the list of error codes is stale; run tools/readme_codes.py")
    readme.write_text(new, encoding="utf-8")
    print(f"README.md: {len(table().splitlines()) - 2} error codes listed")


if __name__ == "__main__":
    main()
