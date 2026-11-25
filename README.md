# EVA Technology public pages

The support page, privacy policies and terms of service for three Jira apps
(Desk Tools MCP, E-Invoice Kit for Jira and Team Load Radar for Jira), and a
free invoice checker in German, E-Rechnung prüfen.

Served with GitHub Pages at <https://evaoffice.github.io/eva-technology/>.

## Who keeps this

These pages are written and kept by an AI (Claude by Anthropic). The publisher
and legally responsible person is Lucas Acosta, Avenida José Miguel Galván
Bello 29, 38612 El Médano (Santa Cruz de Tenerife), Spain.

Contact: eva.office.app@gmail.com (email only).

## How it is built

Plain HTML and one stylesheet for the English pages. No cookies, analytics or
external requests anywhere.

- `content/*.md` holds the text of each English page.
- `python3 tools/build.py` turns it into the HTML that is committed here
  (needs the `markdown` package).
- `python3 tools/check_links.py` checks every local link.

To change a page, edit its file in `content/`, run both commands and commit
the result.

## The invoice checker and its tax number

`tools/e-rechnung-pruefen.html.tpl` is the finished checker page: one file
with its own styles and script, which runs entirely in the visitor's browser.
It is built and tested in another repository and copied here.

Its legal notice (Impressum) has to show the publisher's tax number. The
number is not in this repository. The file carries the mark `[NIF]` in its
place, and that is why it is stored as a template and not as a page.

`python3 tools/assemble.py --out _site` makes the folder that is served:

- the committed pages, copied as they are;
- with the environment variable `IMPRESSUM_NIF` set: the checker at
  `e-rechnung-pruefen/`, with the number in place, and a link to it on the
  home page;
- without it: no checker and no link. An incomplete legal notice is never
  published.

`python3 tools/assemble.py --selftest` checks both outcomes with a made-up
number.

## Publishing

`.github/workflows/pages.yml` runs on every push to `main`. It runs the
self-test, assembles `_site`, checks the links and writes a summary of what
was included.

- The tax number comes from the repository variable `IMPRESSUM_NIF`
  (Settings, Secrets and variables, Actions, Variables).
- The workflow deploys only when Pages is set to deploy from GitHub Actions
  (Settings, Pages, Source). While the source is still the branch, it only
  builds and checks, and the site is served from the repository root.
