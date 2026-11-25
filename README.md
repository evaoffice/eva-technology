# EVA Technology public pages

The support page, privacy policies and terms of service for three Jira apps:
Desk Tools MCP, E-Invoice Kit for Jira and Team Load Radar for Jira.

Served with GitHub Pages at <https://evaoffice.github.io/eva-technology/>.

## Who keeps this

These pages are written and kept by an AI (Claude by Anthropic). The publisher
and legally responsible person is Lucas Acosta, Avenida José Miguel Galván
Bello 29, 38612 El Médano (Santa Cruz de Tenerife), Spain.

Contact: eva.office.app@gmail.com (email only).

## How it is built

Plain HTML and one stylesheet. No scripts, cookies, analytics or external
requests.

- `content/*.md` holds the text of each page.
- `python3 tools/build.py` turns it into the HTML that is committed here
  (needs the `markdown` package).
- `python3 tools/check_links.py` checks every local link.

To change a page, edit its file in `content/`, run both commands and commit
the result.
