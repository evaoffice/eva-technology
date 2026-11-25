#!/usr/bin/env python3
"""Assembles the folder that GitHub Pages serves.

    python3 tools/assemble.py --out _site
    python3 tools/assemble.py --selftest

The pages committed in this repository are copied as they are. One page is
added on the way: the German invoice checker at e-rechnung-pruefen/. Spanish
law requires its legal notice (Impressum) to show the publisher's tax number.
That number is not stored in this repository. It comes from the environment
variable IMPRESSUM_NIF, which the workflow fills from the repository variable
of the same name.

Without the number the checker is left out and the home page does not link to
it, so an incomplete legal notice is never published. This script never
prints the number.
"""
import argparse
import os
import pathlib
import re
import shutil
import sys
import tempfile

ROOT = pathlib.Path(__file__).resolve().parent.parent
PAGES = ["index.html", "404.html", ".nojekyll", "assets", "support", "privacy", "terms"]

TOOL_DIR = "e-rechnung-pruefen"
TOOL_TEMPLATE = ROOT / "tools" / "e-rechnung-pruefen.html.tpl"
NIF_MARK = "[NIF]"
# Same rule as src/nif.js of the checker: letters and digits, with dots,
# hyphens, slashes or spaces only in between.
NIF_FORM = re.compile(r"[A-Za-z0-9][A-Za-z0-9 ./-]{3,22}[A-Za-z0-9]")

# tools/build.py writes this comment into the home page. It is replaced by the
# block below when the checker is published, and removed when it is not.
HOME_SLOT = "<!-- slot: e-rechnung-pruefen -->\n"
HOME_BLOCK = """<h2 id="tools">Free tool</h2>
<ul class="apps">
<li>
<h3 lang="de">E-Rechnung prüfen</h3>
<p>Checks a German XRechnung invoice (XML, UBL 2.1) in your browser and explains every error it finds in plain German, with how to correct it. No sign-up, and the file is not uploaded. The page is in German.</p>
<p class="more"><a href="e-rechnung-pruefen/" hreflang="de">Open E-Rechnung prüfen</a></p>
</li>
</ul>
"""


class NifError(ValueError):
    """The message never repeats the value."""


def checked_nif(value):
    nif = (value or "").strip()
    if not nif:
        raise NifError("IMPRESSUM_NIF is empty")
    if not NIF_FORM.fullmatch(nif):
        raise NifError(
            "IMPRESSUM_NIF has an unexpected form (5 to 24 letters and digits; "
            "dots, hyphens, slashes or spaces only in between)"
        )
    return nif


def tool_page(nif):
    text = TOOL_TEMPLATE.read_text(encoding="utf-8")
    found = text.count(NIF_MARK)
    if found != 1:
        raise SystemExit(f"{TOOL_TEMPLATE.name}: the mark {NIF_MARK} must appear exactly once, found {found}")
    return text.replace(NIF_MARK, nif)


def assemble(out, nif_value):
    """Writes the site to `out`. Returns (tool_published, reason)."""
    out = pathlib.Path(out)
    if out.exists():
        shutil.rmtree(out)
    out.mkdir(parents=True)
    for name in PAGES:
        source = ROOT / name
        if source.is_dir():
            shutil.copytree(source, out / name)
        else:
            shutil.copy2(source, out / name)

    try:
        nif = checked_nif(nif_value)
        reason = ""
    except NifError as error:
        nif, reason = None, str(error)

    home = out / "index.html"
    text = home.read_text(encoding="utf-8")
    if text.count(HOME_SLOT) != 1:
        raise SystemExit("index.html: the slot for the tool is missing. Run tools/build.py.")
    home.write_text(text.replace(HOME_SLOT, HOME_BLOCK if nif else ""), encoding="utf-8")

    if nif:
        target = out / TOOL_DIR / "index.html"
        target.parent.mkdir()
        target.write_text(tool_page(nif), encoding="utf-8")
    return bool(nif), reason


def report(published, reason):
    lines = ["## EVA Technology site", ""]
    lines.append("- Apps, support, privacy and terms pages: included.")
    if published:
        lines.append(f"- `{TOOL_DIR}/`: **included**, with the tax number in its legal notice, and linked from the home page.")
    else:
        lines.append(
            f"- `{TOOL_DIR}/`: **not published** ({reason}). The home page does not link to it. "
            "To publish it, add the repository variable `IMPRESSUM_NIF` under Settings, "
            "Secrets and variables, Actions, Variables, and run this workflow again."
        )
    text = "\n".join(lines) + "\n"
    print(text)
    summary = os.environ.get("GITHUB_STEP_SUMMARY")
    if summary:
        with open(summary, "a", encoding="utf-8") as handle:
            handle.write(text)


def selftest():
    """Both outcomes, with a made-up number, in a temporary folder."""
    fake = "TEST-00000"
    with tempfile.TemporaryDirectory() as folder:
        folder = pathlib.Path(folder)

        for bad in ("", "   ", "abc", "<b>1234567</b>", '1234567"8', "x" * 40, NIF_MARK):
            published, reason = assemble(folder / "without", bad)
            assert not published and reason.startswith("IMPRESSUM_NIF"), bad
            assert bad.strip() == "" or bad not in reason
            assert not (folder / "without" / TOOL_DIR).exists()
            home = (folder / "without" / "index.html").read_text(encoding="utf-8")
            assert TOOL_DIR not in home and "slot:" not in home
            assert home == (ROOT / "index.html").read_text(encoding="utf-8").replace(HOME_SLOT, "")

        published, reason = assemble(folder / "with", f"  {fake} ")
        assert published and reason == ""
        page = (folder / "with" / TOOL_DIR / "index.html").read_text(encoding="utf-8")
        assert f'Steuernummer (NIF): <span id="impressum-nif">{fake}</span>' in page
        assert NIF_MARK not in page and '<html lang="de">' in page
        assert page == TOOL_TEMPLATE.read_text(encoding="utf-8").replace(NIF_MARK, fake)
        home = (folder / "with" / "index.html").read_text(encoding="utf-8")
        assert home.count(f'href="{TOOL_DIR}/"') == 1 and "slot:" not in home

        for name in ("support", "privacy", "terms", "assets"):
            assert (folder / "with" / name).is_dir(), name
        for site in ("with", "without"):
            for path in (folder / site).rglob("*"):
                assert path.suffix != ".tpl" and "tools" not in path.parts, path
    print("selftest: ok (the tool is left out without a number and published with one)")


def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--out", default="_site")
    parser.add_argument("--selftest", action="store_true")
    args = parser.parse_args()
    if args.selftest:
        selftest()
        return 0
    published, reason = assemble(args.out, os.environ.get("IMPRESSUM_NIF", ""))
    report(published, reason)
    return 0


if __name__ == "__main__":
    sys.exit(main())
