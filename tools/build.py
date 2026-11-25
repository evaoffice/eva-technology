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
        COMING,
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
LINK_ZEIGT = "Unser Prüfwerkzeug zeigt diesen Fehler mit Erklärung an. Datei jetzt prüfen"
LINK_ALLGEMEIN = "Prüfen Sie Ihre Datei kostenlos im Browser"


def fehler_seiten():
    pages = []
    for md in sorted((ROOT / "content" / "fehler").glob("*.md")):
        meta, text = parse(md)
        for key in ("slug", "nav", "title", "description", "h1", "detects"):
            if not meta.get(key):
                raise SystemExit(f"{md.name}: '{key}' is missing")
        if meta["detects"] not in ("yes", "no"):
            raise SystemExit(f"{md.name}: detects must be yes or no")
        pages.append((meta, text))
    return pages


def fehler_rail(pages, current):
    items = ['<li><a href="../../">XRechnung kostenlos prüfen</a></li>', '<li class="group">Häufige Fehler</li>']
    for meta, _ in pages:
        cur = ' aria-current="page"' if meta["slug"] == current else ""
        items.append(f'<li><a href="../{meta["slug"]}/"{cur}>{esc(meta["nav"])}</a></li>')
    items.append('<li class="group" aria-hidden="true"></li>')
    items.append('<li><a href="../../#angebot">Korrektur anfragen</a></li>')
    return (
        '<nav class="rail" aria-label="E-Rechnung prüfen">\n'
        '<p class="name"><a href="../../">E-Rechnung prüfen</a></p>\n'
        "<ul>\n" + "\n".join(items) + "\n</ul>\n</nav>"
    )


def render_fehler(pages, meta, text):
    slug_ = meta["slug"]
    body = markdown.markdown(text, extensions=["fenced_code", "tables", "sane_lists"], output_format="html5")
    link = LINK_ZEIGT if meta["detects"] == "yes" else LINK_ALLGEMEIN
    html_ = f"""<!doctype html>
<html lang="de">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>{esc(meta["title"])}</title>
<meta name="description" content="{esc(meta["description"])}">
<link rel="canonical" href="{SITE_URL}e-rechnung-pruefen/fehler/{slug_}/">
<link rel="stylesheet" href="../../../assets/site.css">
</head>
<body class="fehler">
<a class="skip" href="#content">Zum Inhalt</a>
<div class="frame">
{fehler_rail(pages, slug_)}
<div>
<main id="content">
<p class="kicker">XRechnung · Fehlermeldung erklärt</p>
<h1>{esc(meta["h1"])}</h1>
{body}
<p class="cta"><a href="../../">{esc(link)}</a></p>
<p class="offer">Sie möchten den Fehler nicht selbst beheben? Wir korrigieren bis zu 5 XRechnungen für 49 € netto (Angebot nur für Unternehmer). <a href="../../#angebot">Korrektur anfragen</a> oder per E-Mail an {mail()}.</p>
</main>
<footer class="foot">
<p>{esc(KI_HINWEIS)}</p>
<p>Technische Erläuterung, keine Steuer- oder Rechtsberatung. Alle Beispiele sind erfunden.</p>
<p><a href="../../#impressum">Impressum</a> · <a href="../../#datenschutz">Datenschutz</a> · Kontakt: {mail()}</p>
</footer>
</div>
</div>
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
    for meta, text in pages:
        written.append(render_fehler(pages, meta, text))
    (ROOT / ".nojekyll").write_text("", encoding="utf-8")
    for path in written:
        print(path.relative_to(ROOT))
    return 0


if __name__ == "__main__":
    sys.exit(main())
