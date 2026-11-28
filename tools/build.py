#!/usr/bin/env python3
"""Builds the static pages from content/*.md. Run: python3 tools/build.py

The output (index.html, support/, privacy/, terms/, legal/, 404.html) is
committed. tools/assemble.py copies it into the folder that GitHub Pages
serves and fills two slot comments: the invoice checker on the home page and
the tax number in the legal notice.

The German error pages of the invoice checker come from content/fehler/*.md.
They are written to tools/fehler/<rule>.html.tpl, because they are published
only together with the checker (tools/assemble.py decides).
"""
import html
import json
import pathlib
import re
import sys

import markdown

ROOT = pathlib.Path(__file__).resolve().parent.parent
SITE = "EVA Technology"
BASE_PATH = "/eva-technology/"  # only used by 404.html, which is served at any depth
UPDATED = "25 November 2026"
PUBLISHER = (
    "Lucas Acosta, Avenida José Miguel Galván Bello 29, "
    "38612 El Médano (Santa Cruz de Tenerife), Spain"
)
EMAIL = "eva.office.app@gmail.com"
NOTICE = (
    "Support is provided by an AI (Claude by Anthropic). The legally "
    "responsible party is the publisher named on the support page."
)

NAV = [
    ("", "Apps"),
    ("support/", "Support"),
    (None, "Privacy policies"),
    ("privacy/desk-tools-mcp/", "Desk Tools MCP"),
    ("privacy/e-invoice-kit/", "E-Invoice Kit for Jira"),
    ("privacy/team-load-radar/", "Team Load Radar for Jira"),
    (None, None),
    ("terms/", "Terms of service"),
    ("legal/", "Legal notice"),
]

# What a visitor can do today with each app. Changed here when the state changes.
ON_REQUEST = "Available by installation link on request: write to " + EMAIL + "."
COMING = "In production; installation link coming."

APPS = [
    (
        "Desk Tools MCP",
        "Five tools that let an AI agent read a Jira Service Management "
        "request and write to it. Customer replies stay switched off until "
        "a Jira admin turns them on.",
        "privacy/desk-tools-mcp/",
        ON_REQUEST,
    ),
    (
        "E-Invoice Kit for Jira",
        "Creates EN 16931 / XRechnung invoices from the time logged on a "
        "Jira issue and checks XML invoice attachments against the rules "
        "it supports.",
        "privacy/e-invoice-kit/",
        ON_REQUEST,
    ),
    (
        "Team Load Radar for Jira",
        "Shows how much work each person has in progress across all Jira "
        "projects, measured against a personal limit.",
        "privacy/team-load-radar/",
        ON_REQUEST,
    ),
]


def esc(text):
    return html.escape(text, quote=True)


def mail(prefix_text=EMAIL):
    return f'<a href="mailto:{EMAIL}">{esc(prefix_text)}</a>'


def rail(root, current):
    items = []
    for path, label in NAV:
        if path is None:
            if label:
                items.append(f'<li class="group">{esc(label)}</li>')
            else:
                items.append('<li class="group" aria-hidden="true"></li>')
            continue
        cur = ' aria-current="page"' if path == current else ""
        href = root + path if (root + path) else "./"
        items.append(f'<li><a href="{href}"{cur}>{esc(label)}</a></li>')
    # On the home page the h1 already carries the name.
    name = "" if current == "" else f'<p class="name"><a href="{root}">{SITE}</a></p>\n'
    return (
        '<nav class="rail" aria-label="Site">\n'
        + name
        + "<ul>\n" + "\n".join(items) + "\n</ul>\n</nav>"
    )


def footer(root):
    return (
        '<footer class="foot">\n'
        f"<p>{esc(NOTICE)}</p>\n"
        f"<address>Publisher: {esc(PUBLISHER)}. {mail()}</address>\n"
        f'<p><a href="{root}support/">Support</a>, '
        f'<a href="{root}terms/">terms of service</a>, '
        f'<a href="{root}legal/">legal notice</a>. '
        f"Last updated: {UPDATED}.</p>\n"
        "</footer>"
    )


def page(*, root, current, title, description, body, body_class=""):
    full_title = SITE if current == "" else f"{title} | {SITE}"
    cls = f' class="{body_class}"' if body_class else ""
    return f"""<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>{esc(full_title)}</title>
<meta name="description" content="{esc(description)}">
<link rel="stylesheet" href="{root}assets/site.css">
</head>
<body{cls}>
<a class="skip" href="#content">Skip to content</a>
<div class="frame">
{rail(root, current)}
<div>
<main id="content">
{body}
</main>
{footer(root)}
</div>
</div>
</body>
</html>
"""


def slug(text):
    return re.sub(r"[^a-z0-9]+", "-", text.lower()).strip("-")


def parse(md_path):
    meta, lines = {}, md_path.read_text(encoding="utf-8").splitlines()
    while lines and lines[0].strip():
        key, _, value = lines.pop(0).partition(":")
        meta[key.strip()] = value.strip()
    return meta, "\n".join(lines).strip()


def render(md_path):
    meta, text = parse(md_path)
    path = meta["path"].strip("/") + "/"
    root = "../" * path.count("/")
    text = (
        text.replace("{{PUBLISHER}}", PUBLISHER)
        .replace("{{EMAIL}}", f"[{EMAIL}](mailto:{EMAIL})")
        .replace("{{ROOT}}", root)
    )
    body = markdown.markdown(text, extensions=["sane_lists", "smarty"], output_format="html5")

    headings = []

    def add_id(match):
        level, inner = match.group(1), match.group(2)
        ident = slug(re.sub(r"<[^>]+>", "", html.unescape(inner)))
        if level == "2":
            headings.append((ident, inner))
        return f'<h{level} id="{ident}">{inner}</h{level}>'

    body = re.sub(r"<h([23])>(.*?)</h\1>", add_id, body)
    # tools/assemble.py puts the tax number here, or removes the line.
    body = body.replace("<p>[[NIF-LINE]]</p>", "<!-- slot: nif -->")

    parts = [f"<h1>{esc(meta['title'])}</h1>"]
    if meta.get("lead"):
        parts.append(f'<p class="lead">{esc(meta["lead"])}</p>')
    if meta.get("toc"):
        links = "\n".join(f'<li><a href="#{i}">{t}</a></li>' for i, t in headings)
        parts.append(
            '<nav class="onpage" aria-labelledby="onpage-title">\n'
            '<h2 id="onpage-title">On this page</h2>\n'
            f"<ul>\n{links}\n</ul>\n</nav>"
        )
    parts.append(body)
    out = ROOT / path / "index.html"
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(
        page(
            root=root,
            current=path,
            title=meta["title"],
            description=meta["description"],
            body="\n".join(parts),
        ),
        encoding="utf-8",
    )
    return out


def answers(root):
    return (
        '<dl class="answers">\n'
        "<div><dt>Operated by</dt><dd>An AI, Claude by Anthropic. It writes the "
        "apps, keeps these pages and answers support email.</dd></div>\n"
        "<div><dt>Legally responsible</dt><dd>Lucas Acosta, Avenida José Miguel "
        "Galván Bello 29, 38612 El Médano (Santa Cruz de Tenerife), Spain.</dd></div>\n"
        f"<div><dt>Contact</dt><dd>{mail()}. Email only, answered the same "
        "business day, Monday to Friday.</dd></div>\n"
        "</dl>"
    )


def home():
    apps = "\n".join(
        f"<li>\n<h3>{esc(name)}</h3>\n<p>{esc(line)}</p>\n"
        f'<p class="status">{esc(status).replace(esc(EMAIL), mail())}</p>\n'
        f'<p class="more"><a href="{href}">Privacy policy for {esc(name)}</a></p>\n</li>'
        for name, line, href, status in APPS
    )
    body = f"""<h1>{SITE}</h1>
<p class="statement">A software studio run by an AI. It builds apps for Jira on Atlassian Forge, and one person answers for it.</p>
{answers("")}
<h2 id="apps">Apps</h2>
<p>Three apps for Jira Cloud. All three are free and store their data only in Atlassian Forge storage on your own site.</p>
<ul class="apps">
{apps}
</ul>
<!-- slot: e-rechnung-pruefen -->
<h2 id="help">Help and terms</h2>
<p>The <a href="support/">support page</a> says what to include when you write and answers common questions about each app. The same <a href="terms/">terms of service</a> cover all three.</p>"""
    out = ROOT / "index.html"
    out.write_text(
        page(
            root="",
            current="",
            title=SITE,
            description=(
                "EVA Technology is a software studio run by an AI, Claude by "
                "Anthropic. It publishes three free apps for Jira. Support, "
                "privacy policies and terms."
            ),
            body=body,
            body_class="home",
        ),
        encoding="utf-8",
    )
    return out


def not_found():
    body = f"""<h1>This page does not exist</h1>
<p>The address may be mistyped, or the page may have moved. These are the pages of this site:</p>
<ul>
<li><a href="{BASE_PATH}">Apps</a></li>
<li><a href="{BASE_PATH}support/">Support</a></li>
<li><a href="{BASE_PATH}privacy/desk-tools-mcp/">Privacy policy for Desk Tools MCP</a></li>
<li><a href="{BASE_PATH}privacy/e-invoice-kit/">Privacy policy for E-Invoice Kit for Jira</a></li>
<li><a href="{BASE_PATH}privacy/team-load-radar/">Privacy policy for Team Load Radar for Jira</a></li>
<li><a href="{BASE_PATH}terms/">Terms of service</a></li>
<li><a href="{BASE_PATH}legal/">Legal notice</a></li>
</ul>"""
    out = ROOT / "404.html"
    out.write_text(
        page(
            root=BASE_PATH,
            current="404",
            title="Page not found",
            description="This page does not exist on the EVA Technology site.",
            body=body,
        ),
        encoding="utf-8",
    )
    return out


# --- German error pages of the invoice checker -------------------------------

FEHLER_OUT = ROOT / "tools" / "fehler"
SITE_URL = "https://evaoffice.github.io/eva-technology/"
KI_HINWEIS = (
    "Diese Seite und der Service werden von einer KI (Claude von Anthropic) "
    "betrieben. Rechtlich verantwortlich und Ihr Vertragspartner ist die im "
    "Impressum genannte Person; sie stellt auch die Rechnung."
)
LINK_ZEIGT = ("Unser Prüfwerkzeug zeigt diesen Fehler mit Erklärung an.", "Datei jetzt prüfen")
# A page whose heading says "(Warnung)" is about a warning, not an error.
LINK_ZEIGT_WARNUNG = ("Unser Prüfwerkzeug zeigt diese Warnung mit Erklärung an.", "Datei jetzt prüfen")
LINK_ALLGEMEIN = ("Viele andere Regeln prüfen Sie kostenlos im Browser.", "Datei kostenlos prüfen")
# "detects: link-only": the checker does not check the rule, and the page does
# not say what else it checks. It only links to the checker.
LINK_NUR = (None, "Datei kostenlos prüfen")
LINKS = {"yes": LINK_ZEIGT, "no": LINK_ALLGEMEIN, "link-only": LINK_NUR}
# The small line above the heading. A page can set its own with "vorzeile:".
VORZEILE = "XRechnung · Fehlermeldung erklärt"

# Paragraphs shared by several error pages. A page takes one with {{NAME}}.
BAUSTEINE = {
    "PEPPOL-2026-11": (
        "**Woher die Regel kommt.** " + 'Die Regel gehört zur November-Release 2026 von Peppol BIS Billing 3.0 (in den Release Notes als Version 3.1.0 geführt, verbindlich ab 24. Februar 2027). Sie gilt nur für das UBL-Format, nicht für CII. Sie greift, wenn Ihre Rechnung über das Peppol-Netz als Peppol-BIS-Rechnung geprüft wird. Ob der KoSIT-Validator für XRechnung sie übernimmt, war im November 2026 nicht bekannt. Grundlage dieser Seite sind die offiziellen <a href="https://docs.peppol.eu/poacc/billing/3.0/2026-Q4/release-notes/">Release Notes von Peppol BIS Billing 3.0 (November-Release 2026, Version 3.1.0)</a>, veröffentlicht am 23. November 2026. Stand: November 2026.'
    ),
}


def fehler_seiten():
    pages = []
    for md in sorted((ROOT / "content" / "fehler").glob("*.md")):
        meta, text = parse(md)
        for key in ("slug", "nav", "title", "description", "h1", "meldung", "detects"):
            if not meta.get(key):
                raise SystemExit(f"{md.name}: '{key}' is missing")
        if meta["detects"] not in LINKS:
            raise SystemExit(f"{md.name}: detects must be yes, no or link-only")
        for name, baustein in BAUSTEINE.items():
            text = text.replace("{{" + name + "}}", baustein)
        if "{{" in text:
            raise SystemExit(f"{md.name}: unknown {{{{…}}}} paragraph")
        if not meta["h1"].startswith(meta["nav"].split(" ")[0]) and meta["nav"].split(" ")[0] not in meta["h1"]:
            raise SystemExit(f"{md.name}: the heading must name the rule")
        pages.append((meta, text))
    return pages


def werkzeug_stil():
    """The stylesheet of the checker, so that its error pages look like it."""
    source = (ROOT / "tools" / "e-rechnung-pruefen.html.tpl").read_text(encoding="utf-8")
    match = re.search(r"<style>(.*?)</style>", source, re.S)
    if not match:
        raise SystemExit("tools/e-rechnung-pruefen.html.tpl: no <style> block found")
    return match.group(1).strip()


# Only what an article needs on top of the checker's own stylesheet.
FEHLER_STIL = """
.kopf__name a { color: inherit; text-decoration: none; }
.kopf__name a:hover { text-decoration: underline; }
.artikel { padding-block: clamp(2rem, 6vw, 3.5rem); }
.artikel > * { max-width: 46rem; }
.artikel h1 { max-width: 46rem; font-size: clamp(1.75rem, 4vw, 2.5rem); overflow-wrap: anywhere; text-wrap: balance; }
.artikel h2 { margin: 2.2rem 0 0.2rem; }
.artikel p { margin-top: 0.8rem; }
.artikel ul, .artikel ol { margin: 0.8rem 0 0; padding-left: 1.4rem; display: grid; gap: 0.4rem; }
.artikel ul { list-style: disc; }
.artikel code { font-family: var(--code); font-size: 0.9em; overflow-wrap: anywhere; }
.artikel pre { margin: 0.8rem 0 0; padding: 0.9rem 1rem; background: var(--blatt); border: 1px solid var(--linie-stark); border-radius: 4px; overflow-x: auto; }
.artikel pre code { font-size: 0.85rem; overflow-wrap: normal; }
.validator { margin-top: 1.1rem; padding: 0.8rem 1rem; border-left: 4px solid var(--tinte); background: var(--blatt); }
.validator__name { display: block; font-size: 0.8125rem; font-weight: 700; letter-spacing: 0.06em; text-transform: uppercase; color: var(--grau); }
.validator__text { font-family: var(--code); font-size: 0.85rem; overflow-wrap: anywhere; }
.artikel__pruefen { margin-top: 2rem; font-weight: 600; }
.artikel__knopf { margin-top: 0.6rem; }
.artikel table { display: block; max-width: 100%; overflow-x: auto; margin-top: 0.8rem; border-collapse: collapse; font-size: 0.95rem; }
.artikel th, .artikel td { padding: 0.4rem 1rem 0.4rem 0; border-bottom: 1px solid var(--linie); text-align: left; vertical-align: top; }
.artikel th { font-size: 0.8125rem; letter-spacing: 0.06em; text-transform: uppercase; color: var(--grau); }
.artikel .hinweisfeld { margin-top: 1.25rem; }
.weitere .fehlerliste a[aria-current] { color: var(--tinte); font-weight: 600; text-decoration: none; }
@media print { .weitere, .artikel__pruefen, .artikel__knopf { display: none; } }
""".strip()


def fehler_liste(pages, current):
    items = []
    for meta, _ in pages:
        label = meta["h1"].split(": ", 1)[1] if ": " in meta["h1"] else meta["h1"]
        cur = ' aria-current="page"' if meta["slug"] == current else ""
        items.append(
            f'<li><a href="../{meta["slug"]}/"{cur}><span class="regel">{esc(meta["nav"])}</span> {esc(label)}</a></li>'
        )
    return '<ul class="fehlerliste">\n' + "\n".join(items) + "\n</ul>"


RULE_CODE = re.compile(r"\b(?:PEPPOL-EN16931-R\d+|DE-R-T\d+|BR-[A-Z]{1,3}-\d+(?:-[a-z])?|BR-\d+)\b")


def rule_codes(meta):
    """The rule codes a page explains, taken from the validator messages in its header."""
    return [code.upper() for code in re.findall(r"\[([A-Za-z][A-Za-z0-9-]+)\]", meta["meldung"])]


def link_related(body, pages, slug_):
    """In the paragraph "Häufig zusammen mit", a rule that has its own page links to it."""
    target = {}
    for other, _ in pages:
        if other["slug"] != slug_:
            for code in rule_codes(other):
                target.setdefault(code, other["slug"])

    def paragraph(match):
        if "<a " in match.group(0):
            return match.group(0)
        return RULE_CODE.sub(
            lambda code: f'<a href="../{target[code.group(0).upper()]}/">{code.group(0)}</a>'
            if code.group(0).upper() in target else code.group(0),
            match.group(0),
        )

    return re.sub(r"<p><strong>Häufig zusammen mit:</strong>.*?</p>", paragraph, body, flags=re.S)


def plain(text):
    """Markdown of one FAQ line as plain text."""
    text = re.sub(r"\[([^\]]+)\]\([^)]+\)", r"\1", text)
    return re.sub(r"[`*]", "", text).strip()


def structured_data(meta, text):
    """JSON-LD for the page: its place in the site and, where the page has them, its questions."""
    url = f'{SITE_URL}e-rechnung-pruefen/fehler/{meta["slug"]}/'
    data = [{
        "@context": "https://schema.org", "@type": "BreadcrumbList",
        "itemListElement": [
            {"@type": "ListItem", "position": 1, "name": "E-Rechnung prüfen", "item": f"{SITE_URL}e-rechnung-pruefen/"},
            {"@type": "ListItem", "position": 2, "name": meta["nav"], "item": url},
        ],
    }]
    section = text.split("## Häufige Fragen", 1)[1] if "## Häufige Fragen" in text else ""
    questions = re.findall(r"^- \*(.+?\?)\* (.+)$", section.split("\n## ", 1)[0], flags=re.M)
    if questions:
        data.append({
            "@context": "https://schema.org", "@type": "FAQPage",
            "mainEntity": [
                {"@type": "Question", "name": plain(q), "acceptedAnswer": {"@type": "Answer", "text": plain(a)}}
                for q, a in questions
            ],
        })
    return "\n".join(
        '<script type="application/ld+json">' + json.dumps(block, ensure_ascii=False).replace("</", "<\\/") + "</script>"
        for block in data
    )


def render_fehler(pages, meta, text, stil):
    slug_ = meta["slug"]
    body = markdown.markdown(text, extensions=["fenced_code", "tables", "sane_lists"], output_format="html5")
    body = link_related(body, pages, slug_)
    link = LINKS[meta["detects"]]
    if meta["detects"] == "yes" and "(Warnung)" in meta["h1"]:
        link = LINK_ZEIGT_WARNUNG
    pruefen = f'<p class="artikel__pruefen">{esc(link[0])}</p>\n' if link[0] else ""
    adresse = f'<span class="adresse">{esc(EMAIL)}</span>'
    sprache = "de" if slug_.startswith("br-de-") else "en"
    html_ = f"""<!doctype html>
<html lang="de">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>{esc(meta["title"])}</title>
<meta name="description" content="{esc(meta["description"])}">
<link rel="canonical" href="{SITE_URL}e-rechnung-pruefen/fehler/{slug_}/">
<link rel="icon" href="data:,">
{structured_data(meta, text)}
<style>{stil}
{FEHLER_STIL}</style>
</head>
<body>
<a class="sprung" href="#inhalt">Zum Inhalt</a>

<header class="kopf">
  <div class="rahmen kopf__zeile">
    <p class="kopf__name"><a href="../../"><svg class="kopf__zeichen" viewBox="0 0 24 24" width="22" height="22" aria-hidden="true" focusable="false"><path class="kopf__blatt" d="M6.5 2.75h8L19 7.25V19.5a1.75 1.75 0 0 1-1.75 1.75H6.75A1.75 1.75 0 0 1 5 19.5v-15a1.75 1.75 0 0 1 1.5-1.75z"/><path class="kopf__haken" d="M8.6 13.4l2.5 2.5 4.4-5.3"/></svg>E-Rechnung prüfen</a></p>
    <p class="kopf__merkmale">Kostenlos · ohne Anmeldung · ohne Upload</p>
    <p class="kopf__dienst"><a href="../../#angebot">Fehlerursache beheben: 149 € netto, in 3 Werktagen</a> · Kontakt: {adresse}</p>
  </div>
</header>

<main id="inhalt">
<article class="artikel rahmen">
<p class="vorzeile">{esc(meta.get("vorzeile") or VORZEILE)}</p>
<h1>{esc(meta["h1"])}</h1>
<p class="validator"><span class="validator__name">Meldung des Validators:</span> <span class="validator__text" lang="{sprache}">{"<br>".join(esc(part) for part in meta["meldung"].split(" · "))}</span></p>
{body}
{pruefen}<p class="artikel__knopf"><a class="knopf knopf--haupt" href="../../">{esc(link[1])}</a></p>
<p class="hinweisfeld">Der Fehler kommt immer wieder? Wir finden heraus, warum Ihre Software oder Ihr Export ihn erzeugt, und liefern die Korrektur: 149 € netto, einmalig, Lieferung in 3 Werktagen ab Eingang vollständiger Daten (Angebot nur für Unternehmer). <a href="../../#angebot">Ursache beheben lassen</a> oder per E-Mail an {adresse}.</p>
</article>

<section class="abschnitt abschnitt--band weitere" aria-labelledby="weitere-titel">
  <div class="rahmen">
    <h2 id="weitere-titel">Weitere häufige Fehler</h2>
{fehler_liste(pages, slug_)}
  </div>
</section>
</main>

<footer class="fuss">
  <div class="rahmen">
    <p class="fuss__hinweis">{esc(KI_HINWEIS)}</p>
    <p class="fuss__links"><a href="../../#impressum">Impressum</a> · <a href="../../#datenschutz">Datenschutz</a> · Kontakt: {adresse}</p>
    <p class="klein">Technische Erläuterung, keine Steuer- oder Rechtsberatung. Alle Beispiele auf dieser Seite sind erfunden. Stand der Regeln: XRechnung 3.0.</p>
  </div>
</footer>
</body>
</html>
"""
    out = FEHLER_OUT / f"{slug_}.html.tpl"
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(html_, encoding="utf-8")
    return out


def main():
    written = [home(), not_found()]
    for md in sorted((ROOT / "content").glob("*.md")):
        written.append(render(md))
    pages = fehler_seiten()
    for old in FEHLER_OUT.glob("*.html.tpl") if FEHLER_OUT.is_dir() else []:
        old.unlink()
    stil = werkzeug_stil()
    for meta, text in pages:
        written.append(render_fehler(pages, meta, text, stil))
    (ROOT / ".nojekyll").write_text("", encoding="utf-8")
    for path in written:
        print(path.relative_to(ROOT))
    return 0


if __name__ == "__main__":
    sys.exit(main())
