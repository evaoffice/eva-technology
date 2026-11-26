#!/usr/bin/env python3
"""Assembles the folder that GitHub Pages serves.

    python3 tools/assemble.py --out _site
    python3 tools/assemble.py --selftest

The pages committed in this repository are copied as they are. Three things
are decided on the way, all by one environment variable, IMPRESSUM_NIF, which
the workflow fills from the repository variable (or secret) of the same name.
It holds the publisher's tax number, which Spanish law (LSSI, Article 10)
requires in a legal notice and which is not stored in this repository.

With the number:
  - the legal notice (legal/) shows it;
  - the German invoice checker is published at e-rechnung-pruefen/, with the
    number in its Impressum, and the home page links to it;
  - the German error pages are published under e-rechnung-pruefen/fehler/.

Without the number:
  - the legal notice is published without that line (the site is already
    online and is not taken down for it);
  - the checker and its error pages are left out, and nothing links to them,
    so an incomplete Impressum is never published.

sitemap.xml and robots.txt list the pages that were really published.
This script never prints the number.

Two small files for search engines are copied to the root of the folder in
both cases and are not listed in sitemap.xml: the Google Search Console
verification file and the IndexNow key file. Neither is a secret: both are
meant to be read by anyone.
"""
import argparse
import os
import pathlib
import re
import shutil
import sys
import tempfile

ROOT = pathlib.Path(__file__).resolve().parent.parent
PAGES = ["index.html", "404.html", ".nojekyll", "assets", "support", "privacy", "terms", "legal"]
SITE_URL = "https://evaoffice.github.io/eva-technology/"

# Files that search engines fetch from the root of the site, with the exact
# content each must have (no line break at the end). The IndexNow key is
# public by design; the workflow sends the same key with the list of pages.
INDEXNOW_KEY = "977e02fa6dbb436198c34b9fcfec81c1"
ROOT_FILES = {
    "googlef94abb039ed3206f.html": "google-site-verification: googlef94abb039ed3206f.html",
    f"{INDEXNOW_KEY}.txt": INDEXNOW_KEY,
}

TOOL_DIR = "e-rechnung-pruefen"
TOOL_TEMPLATE = ROOT / "tools" / "e-rechnung-pruefen.html.tpl"
ERROR_DIR = "fehler"
ERROR_TEMPLATES = ROOT / "tools" / "fehler"
ERROR_PAGES = 40
# Pages about rules that the checker does not check. They say so, and they do
# not carry the sentence that the checker shows the error.
NOT_CHECKED = ("peppol-r260", "peppol-r257-r258", "peppol-r230-de-r-t02", "peppol-r219-r229", "peppol-r231")
NIF_MARK = "[NIF]"
# Same rule as src/nif.js of the checker: letters and digits, with dots,
# hyphens, slashes or spaces only in between.
NIF_FORM = re.compile(r"[A-Za-z0-9][A-Za-z0-9 ./-]{3,22}[A-Za-z0-9]")

# tools/build.py writes these comments. They are replaced or removed here.
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
LEGAL_SLOT = "<!-- slot: nif -->\n"
LEGAL_LINE = '<p>Tax identification number (NIF): <span id="legal-nif">{nif}</span></p>\n'


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


def error_templates():
    return sorted(ERROR_TEMPLATES.glob("*.html.tpl"))


def fill(path, slot, block, name):
    text = path.read_text(encoding="utf-8")
    if text.count(slot) != 1:
        raise SystemExit(f"{name}: the slot {slot.strip()} is missing. Run tools/build.py.")
    path.write_text(text.replace(slot, block), encoding="utf-8")


def write_index_files(out):
    """sitemap.xml and robots.txt, from the pages that are in the folder."""
    urls = []
    for page in sorted(out.rglob("index.html")):
        rel = page.parent.relative_to(out).as_posix()
        urls.append(SITE_URL if rel == "." else f"{SITE_URL}{rel}/")
    lines = ['<?xml version="1.0" encoding="UTF-8"?>', '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">']
    lines += [f"  <url><loc>{url}</loc></url>" for url in urls]
    lines.append("</urlset>")
    (out / "sitemap.xml").write_text("\n".join(lines) + "\n", encoding="utf-8")
    (out / "robots.txt").write_text(f"User-agent: *\nAllow: /\n\nSitemap: {SITE_URL}sitemap.xml\n", encoding="utf-8")
    return urls


def assemble(out, nif_value):
    """Writes the site to `out`. Returns a dict that says what was published."""
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
    for name, content in ROOT_FILES.items():
        if (ROOT / name).read_bytes() != content.encode("ascii"):
            raise SystemExit(f"{name}: the content is not the expected one")
        shutil.copy2(ROOT / name, out / name)

    try:
        nif = checked_nif(nif_value)
        reason = ""
    except NifError as error:
        nif, reason = None, str(error)

    fill(out / "index.html", HOME_SLOT, HOME_BLOCK if nif else "", "index.html")
    fill(out / "legal" / "index.html", LEGAL_SLOT, LEGAL_LINE.format(nif=nif) if nif else "", "legal/index.html")

    errors = []
    if nif:
        target = out / TOOL_DIR / "index.html"
        target.parent.mkdir()
        target.write_text(tool_page(nif), encoding="utf-8")
        for template in error_templates():
            slug = template.name[: -len(".html.tpl")]
            page = out / TOOL_DIR / ERROR_DIR / slug / "index.html"
            page.parent.mkdir(parents=True)
            shutil.copy2(template, page)
            errors.append(slug)

    urls = write_index_files(out)
    return {"tool": bool(nif), "reason": reason, "errors": errors, "urls": urls}


def report(result):
    lines = ["## EVA Technology site", ""]
    lines.append("- Apps, support, privacy, terms and legal notice pages: included.")
    if result["tool"]:
        lines.append("- Legal notice: **with** the tax number.")
        lines.append(f"- `{TOOL_DIR}/`: **included**, with the tax number in its legal notice, and linked from the home page.")
        lines.append(f"- `{TOOL_DIR}/{ERROR_DIR}/`: **{len(result['errors'])} error pages included**.")
    else:
        hint = (
            "To change that, add the repository variable `IMPRESSUM_NIF` under Settings, "
            "Secrets and variables, Actions, Variables, and run this workflow again."
        )
        lines.append(f"- Legal notice: published **without the tax number** ({result['reason']}).")
        lines.append(
            f"- `{TOOL_DIR}/` and its error pages: **not published** ({result['reason']}). "
            f"The home page does not link to them. {hint}"
        )
    lines.append(f"- `sitemap.xml` and `robots.txt`: {len(result['urls'])} pages listed.")
    lines.append("- Google verification file and IndexNow key file: at the root, not in the sitemap.")
    text = "\n".join(lines) + "\n"
    print(text)
    summary = os.environ.get("GITHUB_STEP_SUMMARY")
    if summary:
        with open(summary, "a", encoding="utf-8") as handle:
            handle.write(text)


def selftest():
    """Both outcomes, with a made-up number, in a temporary folder."""
    fake = "TEST-00000"
    templates = error_templates()
    assert len(templates) == ERROR_PAGES, f"{len(templates)} error pages; run tools/build.py"
    sources = sorted((ROOT / "content" / "fehler").glob("*.md"))
    assert len(sources) == ERROR_PAGES, f"{len(sources)} sources in content/fehler"
    with tempfile.TemporaryDirectory() as folder:
        folder = pathlib.Path(folder)

        for bad in ("", "   ", "abc", "<b>1234567</b>", '1234567"8', "x" * 40, NIF_MARK):
            result = assemble(folder / "without", bad)
            assert not result["tool"] and result["reason"].startswith("IMPRESSUM_NIF"), bad
            assert bad.strip() == "" or bad not in result["reason"]
            assert result["errors"] == []
            assert not (folder / "without" / TOOL_DIR).exists()
            home = (folder / "without" / "index.html").read_text(encoding="utf-8")
            assert TOOL_DIR not in home and "slot:" not in home
            assert home == (ROOT / "index.html").read_text(encoding="utf-8").replace(HOME_SLOT, "")
            legal = (folder / "without" / "legal" / "index.html").read_text(encoding="utf-8")
            assert "slot:" not in legal and "NIF" not in legal and "Lucas Acosta" in legal
            sitemap = (folder / "without" / "sitemap.xml").read_text(encoding="utf-8")
            assert TOOL_DIR not in sitemap and f"<loc>{SITE_URL}legal/</loc>" in sitemap
            assert f"<loc>{SITE_URL}</loc>" in sitemap and "404" not in sitemap

        result = assemble(folder / "with", f"  {fake} ")
        assert result["tool"] and result["reason"] == "" and len(result["errors"]) == ERROR_PAGES
        page = (folder / "with" / TOOL_DIR / "index.html").read_text(encoding="utf-8")
        assert f'Steuernummer (NIF): <span id="impressum-nif">{fake}</span>' in page
        assert NIF_MARK not in page and '<html lang="de">' in page
        assert page == TOOL_TEMPLATE.read_text(encoding="utf-8").replace(NIF_MARK, fake)
        home = (folder / "with" / "index.html").read_text(encoding="utf-8")
        assert home.count(f'href="{TOOL_DIR}/"') == 1 and "slot:" not in home
        legal = (folder / "with" / "legal" / "index.html").read_text(encoding="utf-8")
        assert f'Tax identification number (NIF): <span id="legal-nif">{fake}</span>' in legal and "slot:" not in legal

        notice = (
            "Diese Seite und der Service werden von einer KI (Claude von Anthropic) betrieben. "
            "Rechtlich verantwortlich und Ihr Vertragspartner ist die im Impressum genannte Person; "
            "sie stellt auch die Rechnung."
        )
        sitemap = (folder / "with" / "sitemap.xml").read_text(encoding="utf-8")
        assert f"<loc>{SITE_URL}{TOOL_DIR}/</loc>" in sitemap
        for slug in result["errors"]:
            error_page = (folder / "with" / TOOL_DIR / ERROR_DIR / slug / "index.html").read_text(encoding="utf-8")
            assert '<html lang="de">' in error_page and notice in error_page, slug
            assert 'href="../../#impressum"' in error_page and 'href="../../"' in error_page, slug
            assert fake not in error_page and NIF_MARK not in error_page, slug
            assert not re.search(r"menschliche[rn]? (Aufsicht|Prüfung|Kontrolle)", error_page), slug
            assert f'href="{ERROR_DIR}/{slug}/"' in page, f"the checker does not link to {slug}"
            assert f"<loc>{SITE_URL}{TOOL_DIR}/{ERROR_DIR}/{slug}/</loc>" in sitemap, slug
            assert "Ursache beheben lassen</a>" in error_page and "149 € netto, einmalig" in error_page, slug
            assert error_page.count("Meldung des Validators:") == 1, slug
            if slug in NOT_CHECKED:
                assert re.search(r"<p>Hinweis: Unser Prüfwerkzeug prüft diese Regeln? derzeit nicht\.</p>", error_page), slug
                assert "Unser Prüfwerkzeug zeigt diesen Fehler" not in error_page, slug
                assert "<strong>Woher die Regel kommt.</strong> Die Regel gehört zur November-Release 2026" in error_page, slug
                assert "{{" not in error_page and "&lt;cac:" in error_page and "<cac:" not in error_page, slug
                assert '<p class="vorzeile">Peppol BIS · Fehlermeldung erklärt</p>' in error_page, slug
                assert (
                    'Grundlage dieser Seite sind die offiziellen <a href="https://docs.peppol.eu/poacc/billing/3.0/2026-Q4/release-notes/">'
                    "Release Notes von Peppol BIS Billing 3.0 (November-Release 2026, Version 3.1.0)</a>, veröffentlicht am 23. November 2026."
                ) in error_page, slug
                assert "Release-Zweig" not in error_page, slug
            else:
                assert '<p class="vorzeile">XRechnung · Fehlermeldung erklärt</p>' in error_page, slug
                assert "docs.peppol.eu" not in error_page, slug
            assert "Alle anderen Regeln" not in error_page, slug
            assert '">Fehlerursache beheben: 149 € netto, in 3 Werktagen</a> · Kontakt:' in error_page, slug
        assert ">Fehlerursache beheben: 149 € netto, in 3 Werktagen</a> · Kontakt:" in page
        # The checker reports BR-S-08 at one cent, the official rule only from 1.00 on: the page must say whose report counts.
        s08 = (folder / "with" / TOOL_DIR / ERROR_DIR / "br-s-08" / "index.html").read_text(encoding="utf-8")
        assert "Maßgeblich ist der Bericht des Validators, den Sie oder Ihr Empfänger verwenden." in s08
        # Both rules have an official tolerance below 1.00; the checker shows a note inside it and an error from 1.00 on.
        co17 = (folder / "with" / TOOL_DIR / ERROR_DIR / "br-co-17" / "index.html").read_text(encoding="utf-8")
        for tolerant in (s08, co17):
            assert (
                "Unser Prüfwerkzeug meldet einen Fehler, wenn die Abweichung 1,00 oder mehr beträgt. Liegt sie darunter, "
                "zeigt es einen Hinweis und empfiehlt, den Betrag zu korrigieren. Maßgeblich ist der Bericht des Validators, "
                "den Sie oder Ihr Empfänger verwenden."
            ) in tolerant
        assert set(NOT_CHECKED) <= set(result["errors"])
        robots = (folder / "with" / "robots.txt").read_text(encoding="utf-8")
        assert f"Sitemap: {SITE_URL}sitemap.xml" in robots

        for name in ("support", "privacy", "terms", "legal", "assets"):
            assert (folder / "with" / name).is_dir(), name
        for site in ("with", "without"):
            for path in (folder / site).rglob("*"):
                assert path.suffix != ".tpl" and "tools" not in path.parts, path
            # The two files for search engines: at the root, exact content, not in the sitemap.
            sitemap = (folder / site / "sitemap.xml").read_text(encoding="utf-8")
            assert len(ROOT_FILES) == 2
            for name, content in ROOT_FILES.items():
                assert (folder / site / name).read_bytes() == content.encode("ascii"), name
                assert name not in sitemap and name.rsplit(".", 1)[0] not in sitemap, name
            assert (folder / site / f"{INDEXNOW_KEY}.txt").read_text(encoding="ascii") == INDEXNOW_KEY
            locs = re.findall(r"<loc>([^<]+)</loc>", sitemap)
            assert locs and all(loc.startswith(SITE_URL) and loc.endswith("/") for loc in locs), site
    print("selftest: ok (without a number: no checker, no error pages, legal notice without the line; with one: all published)")


def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("--out", default="_site")
    parser.add_argument("--selftest", action="store_true")
    args = parser.parse_args()
    if args.selftest:
        selftest()
        return 0
    report(assemble(args.out, os.environ.get("IMPRESSUM_NIF", "")))
    return 0


if __name__ == "__main__":
    sys.exit(main())
