#!/usr/bin/env python3
"""Checks that every local href and stylesheet link in the built pages exists.
Run: python3 tools/check_links.py"""
import pathlib
import re
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
BASE = "/eva-technology/"
bad = 0
count = 0
for page in sorted(ROOT.rglob("*.html")):
    text = page.read_text(encoding="utf-8")
    ids = set(re.findall(r'id="([^"]+)"', text))
    for href in re.findall(r'href="([^"]+)"', text):
        if href.startswith(("mailto:", "http://", "https://")):
            continue
        count += 1
        if href.startswith("#"):
            ok = href[1:] in ids
        else:
            path, _, frag = href.partition("#")
            if path.startswith(BASE):
                target = ROOT / path[len(BASE):]
            else:
                target = (page.parent / path).resolve()
            if target.is_dir():
                target = target / "index.html"
            ok = target.is_file() and ROOT in target.parents
            if ok and frag:
                ok = f'id="{frag}"' in target.read_text(encoding="utf-8")
        if not ok:
            bad += 1
            print(f"BROKEN {page.relative_to(ROOT)} -> {href}")
print(f"{count} local links checked, {bad} broken")
sys.exit(1 if bad else 0)
