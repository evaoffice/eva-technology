# EVA Technology public pages

The support page, privacy policies, terms of service and legal notice for
three Jira apps (Desk Tools MCP, E-Invoice Kit for Jira and Team Load Radar
for Jira), and a free invoice checker in German, E-Rechnung prüfen, with ten
pages that each explain one validation error.

Served with GitHub Pages at <https://evaoffice.github.io/eva-technology/>.

## Who keeps this

These pages are written and kept by an AI (Claude by Anthropic). The publisher
and legally responsible person is Lucas Acosta, Avenida José Miguel Galván
Bello 29, 38612 El Médano (Santa Cruz de Tenerife), Spain.

Contact: eva.office.app@gmail.com (email only).

## How it is built

Plain HTML and one stylesheet. No cookies, analytics or external requests
anywhere.

- `content/*.md` holds the text of each English page.
- `content/fehler/*.md` holds the ten German error pages of the checker
  (title, description, a German heading, the validator's literal message and
  the explanation). They take their stylesheet from the checker page, so run
  `tools/build.py` again whenever `tools/e-rechnung-pruefen.html.tpl` changes.
- `python3 tools/build.py` turns both into HTML (needs the `markdown`
  package). The English pages are committed where they are served; the error
  pages go to `tools/fehler/*.html.tpl`, because they are published only
  together with the checker.
- `python3 tools/check_links.py` checks every local link.

To change a page, edit its file in `content/`, run both commands and commit
the result. The state of each app on the home page ("available by
installation link on request", "installation link coming") is set in
`tools/build.py`.

## The tax number, the checker and its error pages

Spanish law (LSSI, Article 10) requires the publisher's tax number in a legal
notice. The number is not in this repository. It comes from the environment
variable `IMPRESSUM_NIF`, and `tools/assemble.py` never prints it.

`tools/e-rechnung-pruefen.html.tpl` is the finished checker page: one file
with its own styles and script, which runs entirely in the visitor's browser.
It is built and tested in another repository and copied here. It carries the
mark `[NIF]` where the number goes, and that is why it is stored as a template
and not as a page.

`python3 tools/assemble.py --out _site` makes the folder that is served:

- the committed pages, copied as they are;
- with `IMPRESSUM_NIF` set: the number in the legal notice (`legal/`), the
  checker at `e-rechnung-pruefen/` with the number in its Impressum, its ten
  error pages under `e-rechnung-pruefen/fehler/`, and a link to the checker
  on the home page;
- without it: the legal notice without that line, no checker, no error pages
  and no link. An incomplete Impressum is never published;
- `sitemap.xml` and `robots.txt`, listing the pages that were really
  published. (Crawlers read `robots.txt` only at the root of a host, so on a
  project site it is informative; the sitemap can still be submitted.)

`python3 tools/assemble.py --selftest` checks both outcomes with a made-up
number.

## Publishing

`.github/workflows/pages.yml` runs on every push to `main`. It runs the
self-test, assembles `_site`, checks the links, writes a summary of what was
included and deploys the folder to GitHub Pages.

- The tax number comes from the repository variable `IMPRESSUM_NIF`
  (Settings, Secrets and variables, Actions, Variables). A secret of the same
  name also works and keeps the value out of the run log.
- After adding or changing the variable, run the workflow again by hand
  (Actions, Pages, Run workflow): a variable change does not start it.
- The workflow deploys only when Pages is set to deploy from GitHub Actions
  (Settings, Pages, Source), which is how this repository is set.
