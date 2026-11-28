# EVA Technology public pages

The support page, privacy policies, terms of service and legal notice for
three Jira apps (Desk Tools MCP, E-Invoice Kit for Jira and Team Load Radar
for Jira), and a free invoice checker in German, E-Rechnung prüfen, with fifty
pages that each explain one validation error.

Served with GitHub Pages at <https://evaoffice.github.io/eva-technology/>.

## E-Rechnung prüfen

Ein kostenloses Prüfwerkzeug für XRechnungen im UBL-Format: [evaoffice.github.io/eva-technology/e-rechnung-pruefen/](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/). Sie ziehen die XML-Datei in das Fenster, und das Werkzeug prüft sie direkt im Browser. Die Datei wird nicht hochgeladen; die Seite stellt dabei keine Netzwerkanfragen. Geprüft werden 87 einzelne Regeln der EN 16931 und der XRechnung, 14 Regeln zu Dezimalstellen und 6 Regelfamilien für 9 Umsatzsteuerkategorien. Zu jedem Fehler zeigt das Werkzeug die Regel-ID (zum Beispiel BR-CO-14) und eine Erklärung, wie man ihn behebt. Es ersetzt nicht den offiziellen KoSIT-Validator und prüft weder ZUGFeRD noch CII.

Diese Seite und der Service werden von einer KI (Claude von Anthropic) betrieben. Rechtlich verantwortlich und Ihr Vertragspartner ist die im Impressum genannte Person; sie stellt auch die Rechnung.

### Fehlercodes der XRechnung, einzeln erklärt

Zu jedem dieser Fehler aus dem Prüfbericht (EN 16931, XRechnung, Peppol) gibt es eine eigene Seite auf Deutsch: was die Regel prüft, typische Ursachen, die Korrektur Schritt für Schritt und ein XML-Beispiel vorher und nachher.

<!-- fehlercodes:start -->
| Regel | Fehler | Erklärung |
|---|---|---|
| BR-DE-15 | Käuferreferenz (BT-10) fehlt | [br-de-15](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-de-15/) |
| BR-CO-14 | Umsatzsteuer-Summe weicht ab | [br-co-14](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-co-14/) |
| BR-CO-17 | Steuerbetrag passt nicht zur Bemessungsgrundlage | [br-co-17](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-co-17/) |
| BR-AE-10 | Reverse Charge ohne Befreiungsgrund | [br-ae-10](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-ae-10/) |
| BR-E-10 | Steuerbefreiung ohne Grund (auch Kleinunternehmer) | [br-e-10](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-e-10/) |
| BR-CO-26 | Verkäuferkennung fehlt | [br-co-26](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-co-26/) |
| PEPPOL-EN16931-R020 / R010 | Elektronische Adresse fehlt | [peppol-r020-r010](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/peppol-r020-r010/) |
| BR-CL-23 | Ungültige Mengeneinheit („Std“, „Stk“) | [br-cl-23](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-cl-23/) |
| BR-DE-18 | Skonto im falschen Format | [br-de-18](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-de-18/) |
| BR-27 | Negativer Artikelpreis | [br-27](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-27/) |
| PEPPOL-EN16931-R260 | Zahlungsbedingungen brauchen genau ein cbc:Note | [peppol-r260](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/peppol-r260/) |
| PEPPOL-EN16931-R257 / R258 | BIC oder IBAN im Zahlungskonto fehlt | [peppol-r257-r258](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/peppol-r257-r258/) |
| PEPPOL-EN16931-R230 / DE-R-T02 | Link zum Anhang (BT-124) fehlt oder falsch | [peppol-r230-de-r-t02](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/peppol-r230-de-r-t02/) |
| PEPPOL-EN16931-R219 / R229 | Genau eine elektronische Adresse (EndpointID) | [peppol-r219-r229](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/peppol-r219-r229/) |
| PEPPOL-EN16931-R231 | Nachlass oder Zuschlag ohne genau eine Steuerkategorie | [peppol-r231](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/peppol-r231/) |
| BR-DE-1 | Zahlungsangaben (BG-16) fehlen | [br-de-1](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-de-1/) |
| BR-DE-17 (Warnung) | Rechnungsart (BT-3) nicht vorgesehen | [br-de-17](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-de-17/) |
| BR-DE-21 (Warnung) | Spezifikationskennung (BT-24) passt nicht | [br-de-21](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-de-21/) |
| BR-DE-23-a | Überweisung ohne Kontoangaben | [br-de-23-a](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-de-23-a/) |
| BR-CO-10 | Summe der Positionen stimmt nicht | [br-co-10](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-co-10/) |
| BR-CO-13 | Nettosumme stimmt nicht | [br-co-13](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-co-13/) |
| BR-CO-15 | Bruttobetrag weicht ab | [br-co-15](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-co-15/) |
| BR-CO-16 | Zahlbetrag weicht ab | [br-co-16](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-co-16/) |
| BR-S-08 | Bemessungsgrundlage je Steuersatz falsch | [br-s-08](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-s-08/) |
| BR-06 / BR-08 | Name oder Anschrift des Verkäufers fehlt | [br-06-br-08](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-06-br-08/) |
| BR-DE-2 | Kontaktdaten des Verkäufers (BG-6) fehlen | [br-de-2](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-de-2/) |
| BR-DE-3 / BR-DE-4 | Ort oder Postleitzahl des Verkäufers fehlt | [br-de-3-br-de-4](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-de-3-br-de-4/) |
| BR-DE-5 / BR-DE-6 / BR-DE-7 | Ansprechpartner, Telefon oder E-Mail fehlt | [br-de-5-br-de-6-br-de-7](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-de-5-br-de-6-br-de-7/) |
| BR-DE-14 | Steuersatz (BT-119) fehlt | [br-de-14](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-de-14/) |
| BR-DE-26 (Warnung) | Korrekturrechnung ohne Verweis auf die Rechnung | [br-de-26](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-de-26/) |
| BR-DE-19 (Warnung) | IBAN ist ungültig | [br-de-19](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-de-19/) |
| BR-DE-25-a | Lastschrift ohne Mandatsangaben | [br-de-25-a](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-de-25-a/) |
| BR-16 | Die Rechnung enthält keine Position | [br-16](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-16/) |
| BR-CO-09 | USt-IdNr. ohne Länderkürzel | [br-co-09](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-co-09/) |
| BR-62 / BR-63 | Elektronische Adresse ohne Schema | [br-62-br-63](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-62-br-63/) |
| BR-DE-8 / BR-DE-9 | Ort oder Postleitzahl des Käufers fehlt | [br-de-8-br-de-9](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-de-8-br-de-9/) |
| BR-CO-11 / BR-CO-12 | Summe der Nachlässe oder Zuschläge stimmt nicht | [br-co-11-br-co-12](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-co-11-br-co-12/) |
| BR-45 bis BR-48 | Steueraufschlüsselung unvollständig | [br-45-br-48](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-45-br-48/) |
| BR-DE-27 / BR-DE-28 (Warnung) | Telefon oder E-Mail im falschen Format | [br-de-27-br-de-28](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-de-27-br-de-28/) |
| BR-DE-24-a | Kartenzahlung ohne Kartenangaben | [br-de-24-a](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-de-24-a/) |
| BR-CL-14 | Ländercode ist ungültig | [br-cl-14](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-cl-14/) |
| BR-CO-18 | Die Rechnung enthält keine Steueraufschlüsselung | [br-co-18](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-co-18/) |
| BR-S-05 | Position mit Kategorie S ohne Steuersatz über 0 | [br-s-05](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-s-05/) |
| BR-61 | Überweisung ohne Kontonummer | [br-61](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-61/) |
| BR-21 bis BR-26 | Rechnungsposition unvollständig | [br-21-br-26](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-21-br-26/) |
| BR-CL-04 | Der Währungscode der Rechnung ist ungültig | [br-cl-04](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-cl-04/) |
| BR-CO-04 | Position ohne Umsatzsteuerkategorie | [br-co-04](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-co-04/) |
| BR-49 | Zahlungsangaben ohne Code der Zahlungsart | [br-49](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-49/) |
| BR-29 / BR-30 | Der Leistungszeitraum endet vor seinem Beginn | [br-29-br-30](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-29-br-30/) |
| BR-S-02 | Umsatzsteuer berechnet, aber keine Steuernummer des Verkäufers | [br-s-02](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-s-02/) |
<!-- fehlercodes:end -->

## E-Rechnung prüfen (XRechnung checker)

A free checker for XRechnung invoices in UBL syntax: [evaoffice.github.io/eva-technology/e-rechnung-pruefen/](https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/). Drop the XML file into the page and it is checked in your browser. The file is not uploaded, and the page makes no network requests while checking. It covers 87 individual EN 16931 and XRechnung rules, 14 decimal-place rules and 6 rule families across 9 VAT categories. Each finding shows the rule ID (for example BR-CO-14) and how to fix it. It does not replace the official KoSIT validator and does not check ZUGFeRD or CII.

Support is provided by an AI (Claude by Anthropic). The legally responsible party is the publisher named on the support page.

## Who keeps this

These pages are written and kept by an AI (Claude by Anthropic). The publisher
and legally responsible person is Lucas Acosta, Avenida José Miguel Galván
Bello 29, 38612 El Médano (Santa Cruz de Tenerife), Spain.

Contact: eva.office.app@gmail.com (email only).

## How it is built

Plain HTML and one stylesheet. No cookies, analytics or external requests
anywhere.

- `content/*.md` holds the text of each English page.
- `content/fehler/*.md` holds the fifty German error pages of the checker
  (title, description, a German heading, the validator's literal message and
  the explanation). They take their stylesheet from the checker page, so run
  `tools/build.py` again whenever `tools/e-rechnung-pruefen.html.tpl` changes.
  After adding a page, `tools/readme_codes.py` rewrites the list of codes in
  this README.
  In the paragraph "Häufig zusammen mit" a rule that has its own page is linked
  to it by `tools/build.py`, which also writes the JSON-LD of each page
  (breadcrumb and its questions).
  The line `detects:` says what the page may claim: `yes` (the checker shows
  this error), `no`, or `link-only` for a rule the checker does not check,
  where the page only links to the checker. An optional line `vorzeile:` sets
  the small line above the heading. Files 11 to 15 are of that kind:
  five rules of the November 2026 release of Peppol BIS Billing (R260,
  R257/R258, R230/DE-R-T02, R219/R229 and R231). Their shared paragraph on
  where the rules come from is kept once, in `tools/build.py`
  (`{{PEPPOL-2026-11}}`).
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
  checker at `e-rechnung-pruefen/` with the number in its Impressum, its
  fifty error pages under `e-rechnung-pruefen/fehler/`, and a link to the checker
  on the home page;
- without it: the legal notice without that line, no checker, no error pages
  and no link. An incomplete Impressum is never published;
- `sitemap.xml` and `robots.txt`, listing the pages that were really
  published. (Crawlers read `robots.txt` only at the root of a host, so on a
  project site it is informative; the sitemap can still be submitted.)
- two small files for search engines at the root, in both cases and not in
  the sitemap: `googlef94abb039ed3206f.html` (Google Search Console
  verification) and `977e02fa6dbb436198c34b9fcfec81c1.txt` (the IndexNow
  key, which is public by design).

`python3 tools/assemble.py --selftest` checks both outcomes with a made-up
number.

## Publishing

`.github/workflows/pages.yml` runs on every push to `main`. It runs the
self-test, assembles `_site`, checks the links, writes a summary of what was
included and deploys the folder to GitHub Pages. About a minute after the
deployment it reads the published `sitemap.xml` and sends the list of pages to
IndexNow (`api.indexnow.org`), which passes it on to Bing and the other
search engines that take part. The summary shows the HTTP status and the
number of pages; a refusal does not fail the run.

- The tax number comes from the repository variable `IMPRESSUM_NIF`
  (Settings, Secrets and variables, Actions, Variables). A secret of the same
  name also works and keeps the value out of the run log.
- After adding or changing the variable, run the workflow again by hand
  (Actions, Pages, Run workflow): a variable change does not start it.
- The workflow deploys only when Pages is set to deploy from GitHub Actions
  (Settings, Pages, Source), which is how this repository is set.

## Licence

The code in this repository is under the MIT licence (see `LICENSE`). The
licence covers the code, not the legal texts (privacy policies, terms of
service, legal notice) or the publisher's personal details.
