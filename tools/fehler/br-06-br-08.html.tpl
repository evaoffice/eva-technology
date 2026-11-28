<!doctype html>
<html lang="de">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>BR-06 / BR-08: Name oder Anschrift des Verkäufers fehlt</title>
<meta name="description" content="BR-06 und BR-08: Name oder Anschrift des Verkäufers fehlen in der XRechnung. Warum der Firmenname im Kopf nicht genügt und was fehlt.">
<link rel="canonical" href="https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-06-br-08/">
<link rel="icon" href="data:,">
<script type="application/ld+json">{"@context": "https://schema.org", "@type": "BreadcrumbList", "itemListElement": [{"@type": "ListItem", "position": 1, "name": "E-Rechnung prüfen", "item": "https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/"}, {"@type": "ListItem", "position": 2, "name": "BR-06 / BR-08", "item": "https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-06-br-08/"}]}</script>
<script type="application/ld+json">{"@context": "https://schema.org", "@type": "FAQPage", "mainEntity": [{"@type": "Question", "name": "Ich habe meinen Namen doch eingetragen. Warum die Meldung?", "acceptedAnswer": {"@type": "Answer", "text": "Wahrscheinlich steht er nur als Handelsname in cac:PartyName. BR-06 prüft den Namen in cac:PartyLegalEntity."}}, {"@type": "Question", "name": "Gilt das auch für den Käufer?", "acceptedAnswer": {"@type": "Answer", "text": "Ja, mit eigenen Regeln: BR-07 (Name des Käufers) und BR-10 (Anschrift des Käufers)."}}]}</script>
<style>:root {
  color-scheme: light;
  --papier: #f3f0e8;
  --blatt: #fffdf8;
  --tinte: #1b211f;
  --grau: #56605c;
  --linie: #d6cfbf;
  --linie-stark: #b9b09b;
  --gruen: #0f5247;
  --gruen-dunkel: #0a3b33;
  --gruen-hell: #e3efe9;
  --rot: #98281b;
  --rot-hell: #f8e6e1;
  --ocker: #76570a;
  --ocker-hell: #f7eecf;
  --schrift: system-ui, -apple-system, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
  --titel: "Iowan Old Style", "Palatino Linotype", Palatino, "Book Antiqua", Georgia, serif;
  --code: ui-monospace, SFMono-Regular, Menlo, Consolas, "Liberation Mono", monospace;
}

*, *::before, *::after { box-sizing: border-box; }

html { -webkit-text-size-adjust: 100%; scroll-behavior: auto; }

body {
  margin: 0;
  background: var(--papier);
  color: var(--tinte);
  font-family: var(--schrift);
  font-size: 1.0625rem;
  line-height: 1.55;
}

h1, h2, h3, h4, p, ul, dl, dd { margin: 0; }
ul { padding: 0; list-style: none; }

h1, h2 { font-family: var(--titel); font-weight: 600; letter-spacing: -0.01em; line-height: 1.15; }
h1 { font-size: clamp(1.9rem, 4.6vw, 3rem); max-width: 22ch; }
h2 { font-size: clamp(1.4rem, 2.8vw, 1.85rem); }
h3 { font-size: 1.0625rem; font-weight: 700; }
h4 { font-size: 0.8125rem; font-weight: 700; letter-spacing: 0.06em; text-transform: uppercase; color: var(--grau); }

a { color: var(--gruen); text-underline-offset: 0.18em; }
a:hover { color: var(--gruen-dunkel); }

:focus-visible { outline: 3px solid var(--gruen); outline-offset: 3px; border-radius: 2px; }

.rahmen { width: min(100% - 2.5rem, 66rem); margin-inline: auto; }

.nur-vorleser, .unsichtbar {
  position: absolute; width: 1px; height: 1px; padding: 0; margin: -1px;
  overflow: hidden; clip: rect(0 0 0 0); white-space: nowrap; border: 0;
}

.sprung {
  position: absolute; left: 1rem; top: -4rem; z-index: 10;
  background: var(--tinte); color: #fff; padding: 0.6rem 1rem; text-decoration: none;
}
.sprung:focus { top: 1rem; }

.klein { font-size: 0.9rem; color: var(--grau); }

/* Kopf ------------------------------------------------------------------- */
.kopf { border-bottom: 1px solid var(--linie); background: var(--blatt); }
.kopf__zeile { display: flex; flex-wrap: wrap; gap: 0.25rem 1.5rem; align-items: baseline; justify-content: space-between; padding-block: 0.9rem; }
.kopf__name { font-family: var(--titel); font-weight: 600; font-size: 1.15rem; display: inline-flex; align-items: center; gap: 0.45rem; }
.kopf__name a { display: inline-flex; align-items: center; gap: 0.45rem; }
.kopf__zeichen { flex: none; }
.kopf__blatt { fill: var(--gruen-hell); stroke: var(--gruen); stroke-width: 1.5; stroke-linejoin: round; }
.kopf__haken { fill: none; stroke: var(--gruen); stroke-width: 2.2; stroke-linecap: round; stroke-linejoin: round; }
.kopf__merkmale { font-size: 0.875rem; color: var(--grau); }
.kopf__dienst { flex-basis: 100%; font-size: 0.9rem; }
.kopf__dienst .adresse, .auftakt__dienst .adresse { overflow-wrap: anywhere; }

/* Auftakt ---------------------------------------------------------------- */
.auftakt { padding-block: clamp(2rem, 6vw, 4rem) clamp(1.25rem, 3vw, 2rem); }
.vorzeile {
  display: inline-block; margin-bottom: 1rem; padding: 0.2rem 0.6rem;
  border: 1px solid var(--tinte); font-size: 0.8125rem; font-weight: 700; letter-spacing: 0.04em; line-height: 1.45; max-width: 64ch;
}
.auftakt__text { margin-top: 1.1rem; max-width: 60ch; font-size: 1.15rem; color: #2d3532; }
.auftakt__dienst { margin-top: 0.9rem; max-width: 60ch; font-size: 0.975rem; color: var(--grau); }

/* Werkzeug --------------------------------------------------------------- */
.werkzeug { padding-bottom: clamp(2rem, 5vw, 3.5rem); }

.ablage {
  display: grid; justify-items: center; gap: 0.6rem; text-align: center;
  padding: clamp(1.75rem, 5vw, 3rem) 1.25rem;
  background: var(--blatt);
  border: 2px dashed var(--linie-stark);
  border-radius: 6px;
  transition: border-color 0.12s, background-color 0.12s;
}
.ablage--aktiv { border-color: var(--gruen); background: var(--gruen-hell); }
.ablage--beschaeftigt { opacity: 0.6; }
.ablage__titel { font-family: var(--titel); font-size: 1.45rem; font-weight: 600; }
.ablage__oder { font-size: 0.9rem; color: var(--grau); }
.ablage__hinweis { margin-top: 0.4rem; font-size: 0.9rem; color: var(--grau); max-width: 46ch; }
.ablage:focus-within { border-color: var(--gruen); }
#datei:focus-visible + .ablage__hinweis { outline: none; }
.ablage:has(#datei:focus-visible) .knopf--haupt { outline: 3px solid var(--gruen); outline-offset: 3px; }

.knopf {
  display: inline-flex; align-items: center; justify-content: center;
  min-height: 2.75rem; padding: 0.55rem 1.1rem;
  font: inherit; font-weight: 600; line-height: 1.2; text-decoration: none; text-align: center;
  border-radius: 4px; border: 1px solid transparent; cursor: pointer;
}
.knopf--haupt { background: var(--gruen); color: #fff; border-color: var(--gruen); }
.knopf--haupt:hover { background: var(--gruen-dunkel); border-color: var(--gruen-dunkel); color: #fff; }
.knopf--leise { background: var(--blatt); color: var(--tinte); border-color: var(--linie-stark); }
.knopf--leise:hover { border-color: var(--tinte); }
.knopf--beispiel { background: transparent; color: var(--tinte); border-color: var(--linie-stark); font-weight: 500; font-size: 0.95rem; }
.knopf--beispiel:hover { background: var(--blatt); border-color: var(--tinte); }

.beispiele { margin-top: 1.1rem; }
.beispiele__titel { font-size: 0.95rem; color: var(--grau); margin-bottom: 0.6rem; }
.beispiele__knoepfe { display: flex; flex-wrap: wrap; gap: 0.5rem; }

.meldung { margin-top: 1rem; padding: 0.9rem 1rem; background: var(--ocker-hell); border-left: 4px solid var(--ocker); }

/* Bericht ---------------------------------------------------------------- */
.ergebnis:empty { display: none; }
.ergebnis { margin-top: 2rem; scroll-margin-top: 1rem; }

.bericht { background: var(--blatt); border: 1px solid var(--linie-stark); border-top: 6px solid var(--grau); border-radius: 4px; scroll-margin-top: 1rem; }
.bericht--gueltig { border-top-color: var(--gruen); }
.bericht--ungueltig { border-top-color: var(--rot); }
.bericht--unlesbar { border-top-color: var(--ocker); }

.bericht__kopf { padding: clamp(1.1rem, 3vw, 1.75rem); display: grid; gap: 0.75rem; }
.bericht__stempel {
  justify-self: start; padding: 0.15rem 0.55rem; font-size: 0.8125rem; font-weight: 700; letter-spacing: 0.08em; text-transform: uppercase;
  border: 2px solid currentColor; border-radius: 3px;
}
.bericht--gueltig .bericht__stempel { color: var(--gruen); }
.bericht--ungueltig .bericht__stempel { color: var(--rot); }
.bericht--unlesbar .bericht__stempel { color: var(--ocker); }
.bericht__kopf h2:focus { outline: none; }
.bericht__erklaerung { max-width: 68ch; }
.bericht__datei { color: var(--grau); font-size: 0.95rem; }

.fakten { display: grid; grid-template-columns: repeat(auto-fit, minmax(15rem, 1fr)); gap: 0 1.5rem; border-top: 1px solid var(--linie); margin-top: 0.25rem; }
.fakten > div { display: grid; grid-template-columns: 7.5rem 1fr; gap: 0.75rem; padding: 0.45rem 0; border-bottom: 1px solid var(--linie); font-size: 0.95rem; }
.fakten dt { color: var(--grau); }
.fakten dd { overflow-wrap: anywhere; }

.bericht__aktionen { display: flex; flex-wrap: wrap; gap: 0.5rem; margin-top: 0.25rem; }

.befunde { display: grid; gap: 0; border-top: 1px solid var(--linie-stark); }
.befund { padding: clamp(1.1rem, 3vw, 1.75rem); display: grid; gap: 0.7rem; border-left: 6px solid var(--grau); border-bottom: 1px solid var(--linie); }
.befund--fehler { border-left-color: var(--rot); }
.befund--hinweis { border-left-color: var(--ocker); }
.befund__kopf { display: flex; flex-wrap: wrap; align-items: center; gap: 0.6rem; }
.marke { padding: 0.1rem 0.5rem; font-size: 0.78rem; font-weight: 700; letter-spacing: 0.06em; text-transform: uppercase; border-radius: 3px; }
.befund--fehler .marke { background: var(--rot-hell); color: var(--rot); }
.befund--hinweis .marke { background: var(--ocker-hell); color: var(--ocker); }
.regel { font-family: var(--code); font-size: 0.85rem; color: var(--grau); white-space: nowrap; }
.befund__anzahl { font-size: 0.85rem; color: var(--grau); }
.befund__titel { font-family: var(--titel); font-size: 1.3rem; font-weight: 600; line-height: 1.25; max-width: 40ch; }
.befund__feld { font-size: 0.9rem; color: var(--grau); }
.befund__konkret { padding: 0.7rem 0.9rem; background: var(--papier); border-radius: 3px; font-variant-numeric: tabular-nums; }
.befund__konkret li + li { margin-top: 0.2rem; }
.befund__teil { display: grid; gap: 0.25rem; max-width: 72ch; }
.befund__mehr { font-size: 0.95rem; }
.befund__original { font-size: 0.875rem; color: var(--grau); }
.befund__original summary { cursor: pointer; }
.befund__original p { margin-top: 0.4rem; font-family: var(--code); font-size: 0.82rem; overflow-wrap: anywhere; }

.bericht__weiter { padding: 1rem clamp(1.1rem, 3vw, 1.75rem); background: var(--gruen-hell); font-weight: 600; }

/* Abschnitte ------------------------------------------------------------- */
.abschnitt { padding-block: clamp(2.25rem, 6vw, 4rem); }
.abschnitt > h2, .abschnitt .rahmen h2 { margin-bottom: 1rem; }
.abschnitt p + p { margin-top: 0.8rem; }
.abschnitt__einleitung { max-width: 66ch; }
.abschnitt--band { background: var(--blatt); border-block: 1px solid var(--linie); }

.spalten { display: grid; gap: 1.5rem 3rem; grid-template-columns: repeat(auto-fit, minmax(17rem, 1fr)); }
.spalten--breit { gap: 2.5rem 4rem; }
.spalten h3 { margin-bottom: 0.5rem; }

.liste { display: grid; gap: 0.5rem; }
.liste li { position: relative; padding-left: 1.2rem; }
.liste li::before { content: ""; position: absolute; left: 0; top: 0.72em; width: 0.5rem; height: 2px; background: var(--tinte); }
.liste--klein { margin-top: 1.5rem; font-size: 0.95rem; color: #2d3532; }
p + .liste, .liste + p { margin-top: 0.8rem; }

.hinweisfeld { margin-top: 1.5rem; padding: 0.9rem 1.1rem; border-left: 4px solid var(--tinte); background: var(--blatt); max-width: 74ch; }

.aufklappen { margin-top: 1.25rem; }
.aufklappen summary { cursor: pointer; font-weight: 600; color: var(--gruen); padding: 0.4rem 0; }
.aufklappen h3 { margin: 1.1rem 0 0.5rem; }
.regelliste { columns: 22rem; column-gap: 2.5rem; font-size: 0.9rem; }
.regelliste li { break-inside: avoid; padding: 0.2rem 0; }
.fehlerliste { list-style: none; padding: 0; margin-top: 1.25rem; columns: 24rem; column-gap: 2.5rem; }
.fehlerliste li { break-inside: avoid; padding: 0.3rem 0; }
.fehlerliste .regel { margin-right: 0.4rem; }

.befundkasten { padding: clamp(1.1rem, 3vw, 1.6rem); border: 1px solid var(--tinte); background: var(--papier); }

.angebote { display: grid; gap: 1rem; grid-template-columns: repeat(auto-fit, minmax(16rem, 1fr)); margin-top: 1.5rem; }
.angebot { display: grid; gap: 0.5rem; align-content: start; padding: 1.25rem; background: var(--blatt); border: 1px solid var(--linie-stark); border-radius: 4px; }
.angebot h3 { font-family: var(--titel); font-size: 1.25rem; font-weight: 600; }
.angebot__preis { font-size: 1.6rem; font-weight: 700; font-variant-numeric: tabular-nums; line-height: 1.1; }
.angebot__frist { font-size: 0.9rem; color: var(--grau); }
#preis-zusatz:empty { display: none; }
#preis-zusatz { margin-top: 0.75rem; }

.garantie { margin-top: 1.5rem; padding: 1rem 1.2rem; background: var(--gruen-hell); border-left: 4px solid var(--gruen); max-width: 74ch; }
.garantie h3 { margin-bottom: 0.25rem; }

.kontakt { margin-top: 1.5rem; display: grid; gap: 0.6rem; justify-items: start; }
.kontakt[hidden] { display: none; }

[hidden] { display: none !important; }

.schritte { margin: 1.25rem 0 0; padding-left: 1.4rem; display: grid; gap: 0.4rem; max-width: 66ch; }
.schritte--eng { margin-top: 0.25rem; }
.angebot__knopf { margin-top: 0.4rem; justify-self: start; }
#demnaechst:empty { display: none; }
#demnaechst { margin-top: 0.75rem; }

.befund__anfrage { margin-top: 0.2rem; }
.verweis { font: inherit; font-weight: 600; color: var(--gruen); background: none; border: 0; padding: 0; cursor: pointer; text-decoration: underline; text-underline-offset: 0.18em; }
.verweis:hover { color: var(--gruen-dunkel); }

.anfrage { margin-top: 1.75rem; padding: clamp(1.1rem, 3vw, 1.75rem); display: grid; gap: 0.8rem; background: var(--blatt); border: 2px solid var(--gruen); border-radius: 4px; scroll-margin-top: 1rem; }
.anfrage h3 { font-family: var(--titel); font-size: 1.35rem; font-weight: 600; }
.anfrage h3:focus { outline: none; }
.feldname { font-weight: 700; font-size: 0.95rem; }
.anfrage__text {
  width: 100%; min-height: 14rem; padding: 0.75rem 0.9rem; resize: vertical;
  font-family: var(--code); font-size: 0.9rem; line-height: 1.5; color: var(--tinte);
  background: #fff; border: 1px solid var(--linie-stark); border-radius: 3px;
}
.anfrage__aktionen { display: flex; flex-wrap: wrap; gap: 0.5rem; }
.adresse { font-family: var(--code); font-size: 0.95em; overflow-wrap: anywhere; user-select: all; }
#anfrage-status:empty { display: none; }

.bedingungen { margin-top: 1rem; padding-top: 0.9rem; border-top: 1px solid var(--linie); font-size: 0.95rem; color: #2d3532; }
.bedingungen p { max-width: 74ch; }
.bedingungen p + p { margin-top: 0.3rem; }

.recht h3 { margin: 1.4rem 0 0.35rem; }
.recht p { max-width: 74ch; }
.recht__adresse { white-space: pre-line; }

/* Fuß -------------------------------------------------------------------- */
.fuss { padding-block: 2rem 3rem; background: var(--tinte); color: #e9e5da; }
.fuss__hinweis { max-width: 74ch; margin-bottom: 0.9rem; }
.fuss__links .adresse { color: #fff; }
.fuss__links a { color: #e9e5da; }
.fuss__links a:hover { color: #fff; }
.fuss .klein { color: #b6b2a6; margin-top: 0.75rem; }

@media (max-width: 34rem) {
  body { font-size: 1rem; }
  .fakten > div { grid-template-columns: 6.5rem 1fr; }
  .knopf { width: 100%; }
  .beispiele__knoepfe { display: grid; }
}

@media (prefers-reduced-motion: reduce) {
  * { transition: none !important; }
}

@media print {
  .kopf, .auftakt, .ablage, .beispiele, .abschnitt, .fuss, .bericht__aktionen, .bericht__weiter, .befund__anfrage, .befund__mehr { display: none; }
  body { background: #fff; }
  .bericht { border: 0; }
}
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
@media print { .weitere, .artikel__pruefen, .artikel__knopf { display: none; } }</style>
</head>
<body>
<a class="sprung" href="#inhalt">Zum Inhalt</a>

<header class="kopf">
  <div class="rahmen kopf__zeile">
    <p class="kopf__name"><a href="../../"><svg class="kopf__zeichen" viewBox="0 0 24 24" width="22" height="22" aria-hidden="true" focusable="false"><path class="kopf__blatt" d="M6.5 2.75h8L19 7.25V19.5a1.75 1.75 0 0 1-1.75 1.75H6.75A1.75 1.75 0 0 1 5 19.5v-15a1.75 1.75 0 0 1 1.5-1.75z"/><path class="kopf__haken" d="M8.6 13.4l2.5 2.5 4.4-5.3"/></svg>E-Rechnung prüfen</a></p>
    <p class="kopf__merkmale">Kostenlos · ohne Anmeldung · ohne Upload</p>
    <p class="kopf__dienst"><a href="../../#angebot">Fehlerursache beheben: 149 € netto, in 3 Werktagen</a> · Kontakt: <span class="adresse">eva.office.app@gmail.com</span></p>
  </div>
</header>

<main id="inhalt">
<article class="artikel rahmen">
<p class="vorzeile">XRechnung · Fehlermeldung erklärt</p>
<h1>BR-06 / BR-08: Name oder Anschrift des Verkäufers fehlt</h1>
<p class="validator"><span class="validator__name">Meldung des Validators:</span> <span class="validator__text" lang="en">[BR-06]-An Invoice shall contain the Seller name (BT-27).<br>[BR-08]-An Invoice shall contain the Seller postal address.</span></p>
<p><strong>Kurz erklärt.</strong> Jede Rechnung muss den Namen des Verkäufers (BT-27) und seine Postanschrift (BG-5) enthalten. Erscheint die Meldung, obwohl Ihr Firmenname auf der Rechnung steht, liegt das fast immer daran, dass er im falschen Feld der XML-Datei steht.</p>
<h2>Was die Regeln genau prüfen</h2>
<ul>
<li><strong>BR-06:</strong> Im UBL-Format muss <code>cac:AccountingSupplierParty/cac:Party/cac:PartyLegalEntity/cbc:RegistrationName</code> vorhanden und nicht leer sein. Der Name in <code>cac:PartyName/cbc:Name</code> ist der Handelsname (BT-28) und zählt für diese Regel <strong>nicht</strong>.</li>
<li><strong>BR-08:</strong> Unter dem Verkäufer muss <code>cac:PostalAddress</code> vorhanden sein. Was darin stehen muss, prüfen weitere Regeln: das Land (BR-09) und in XRechnung zusätzlich Ort und Postleitzahl (BR-DE-3, BR-DE-4).</li>
</ul>
<h2>Typische Ursachen</h2>
<ul>
<li>Der Firmenname wird nur als <code>cac:PartyName</code> ausgegeben, <code>cac:PartyLegalEntity</code> fehlt.</li>
<li>In den Firmendaten des Programms ist keine Anschrift hinterlegt, sie steht nur im Briefkopf des PDF.</li>
<li>Ein Shop-Plugin füllt den Verkäufer aus Feldern, die bei der Einrichtung leer geblieben sind.</li>
<li>Die Anschrift steht unter dem Ansprechpartner (<code>cac:Contact</code>) statt unter dem Verkäufer.</li>
</ul>
<h2>So beheben Sie es</h2>
<ol>
<li>Tragen Sie in den Firmendaten den vollständigen Namen Ihres Unternehmens ein, wie er im Handelsregister oder beim Finanzamt geführt wird.</li>
<li>Hinterlegen Sie die Anschrift mit Straße, Postleitzahl, Ort und Land.</li>
<li>Erzeugen Sie die Rechnung neu und prüfen Sie, ob <code>cac:PartyLegalEntity</code> und <code>cac:PostalAddress</code> in der Datei stehen.</li>
</ol>
<p><strong>Vorher (abgelehnt):</strong> Name nur als Handelsname, keine Anschrift.</p>
<pre><code class="language-xml">&lt;cac:AccountingSupplierParty&gt;
  &lt;cac:Party&gt;
    &lt;cbc:EndpointID schemeID=&quot;EM&quot;&gt;rechnung@muster.de&lt;/cbc:EndpointID&gt;
    &lt;cac:PartyName&gt;&lt;cbc:Name&gt;Muster&lt;/cbc:Name&gt;&lt;/cac:PartyName&gt;
    …
  &lt;/cac:Party&gt;
&lt;/cac:AccountingSupplierParty&gt;
</code></pre>
<p><strong>Nachher</strong></p>
<pre><code class="language-xml">&lt;cac:AccountingSupplierParty&gt;
  &lt;cac:Party&gt;
    &lt;cbc:EndpointID schemeID=&quot;EM&quot;&gt;rechnung@muster.de&lt;/cbc:EndpointID&gt;
    &lt;cac:PartyName&gt;&lt;cbc:Name&gt;Muster&lt;/cbc:Name&gt;&lt;/cac:PartyName&gt;
    &lt;cac:PostalAddress&gt;
      &lt;cbc:StreetName&gt;Musterstraße 1&lt;/cbc:StreetName&gt;
      &lt;cbc:CityName&gt;Berlin&lt;/cbc:CityName&gt;
      &lt;cbc:PostalZone&gt;10115&lt;/cbc:PostalZone&gt;
      &lt;cac:Country&gt;&lt;cbc:IdentificationCode&gt;DE&lt;/cbc:IdentificationCode&gt;&lt;/cac:Country&gt;
    &lt;/cac:PostalAddress&gt;
    &lt;cac:PartyTaxScheme&gt;
      &lt;cbc:CompanyID&gt;DE123456789&lt;/cbc:CompanyID&gt;
      &lt;cac:TaxScheme&gt;&lt;cbc:ID&gt;VAT&lt;/cbc:ID&gt;&lt;/cac:TaxScheme&gt;
    &lt;/cac:PartyTaxScheme&gt;
    &lt;cac:PartyLegalEntity&gt;
      &lt;cbc:RegistrationName&gt;Muster GmbH&lt;/cbc:RegistrationName&gt;
    &lt;/cac:PartyLegalEntity&gt;
    …
  &lt;/cac:Party&gt;
&lt;/cac:AccountingSupplierParty&gt;
</code></pre>
<p>Die Reihenfolge der Elemente ist im UBL-Format fest: Anschrift vor Steuerangaben, Steuerangaben vor <code>cac:PartyLegalEntity</code>.</p>
<p><strong>Häufig zusammen mit:</strong> BR-09 (Ländercode fehlt), <a href="../br-de-3-br-de-4/">BR-DE-3</a> und <a href="../br-de-3-br-de-4/">BR-DE-4</a> (Ort bzw. Postleitzahl fehlen), <a href="../br-de-2/">BR-DE-2</a> (Kontaktdaten des Verkäufers fehlen) und beim Käufer BR-07 / BR-10.</p>
<h2>Häufige Fragen</h2>
<ul>
<li><em>Ich habe meinen Namen doch eingetragen. Warum die Meldung?</em> Wahrscheinlich steht er nur als Handelsname in <code>cac:PartyName</code>. BR-06 prüft den Namen in <code>cac:PartyLegalEntity</code>.</li>
<li><em>Gilt das auch für den Käufer?</em> Ja, mit eigenen Regeln: BR-07 (Name des Käufers) und BR-10 (Anschrift des Käufers).</li>
</ul>
<p class="artikel__pruefen">Unser Prüfwerkzeug zeigt diesen Fehler mit Erklärung an.</p>
<p class="artikel__knopf"><a class="knopf knopf--haupt" href="../../">Datei jetzt prüfen</a></p>
<p class="hinweisfeld">Der Fehler kommt immer wieder? Wir finden heraus, warum Ihre Software oder Ihr Export ihn erzeugt, und liefern die Korrektur: 149 € netto, einmalig, Lieferung in 3 Werktagen ab Eingang vollständiger Daten (Angebot nur für Unternehmer). <a href="../../#angebot">Ursache beheben lassen</a> oder per E-Mail an <span class="adresse">eva.office.app@gmail.com</span>.</p>
</article>

<section class="abschnitt abschnitt--band weitere" aria-labelledby="weitere-titel">
  <div class="rahmen">
    <h2 id="weitere-titel">Weitere häufige Fehler</h2>
<ul class="fehlerliste">
<li><a href="../br-de-15/"><span class="regel">BR-DE-15</span> Käuferreferenz (BT-10) fehlt</a></li>
<li><a href="../br-co-14/"><span class="regel">BR-CO-14</span> Umsatzsteuer-Summe weicht ab</a></li>
<li><a href="../br-co-17/"><span class="regel">BR-CO-17</span> Steuerbetrag passt nicht zur Bemessungsgrundlage</a></li>
<li><a href="../br-ae-10/"><span class="regel">BR-AE-10</span> Reverse Charge ohne Befreiungsgrund</a></li>
<li><a href="../br-e-10/"><span class="regel">BR-E-10</span> Steuerbefreiung ohne Grund (auch Kleinunternehmer)</a></li>
<li><a href="../br-co-26/"><span class="regel">BR-CO-26</span> Verkäuferkennung fehlt</a></li>
<li><a href="../peppol-r020-r010/"><span class="regel">R020 / R010</span> Elektronische Adresse fehlt</a></li>
<li><a href="../br-cl-23/"><span class="regel">BR-CL-23</span> Ungültige Mengeneinheit („Std“, „Stk“)</a></li>
<li><a href="../br-de-18/"><span class="regel">BR-DE-18</span> Skonto im falschen Format</a></li>
<li><a href="../br-27/"><span class="regel">BR-27</span> Negativer Artikelpreis</a></li>
<li><a href="../peppol-r260/"><span class="regel">R260</span> Zahlungsbedingungen brauchen genau ein cbc:Note</a></li>
<li><a href="../peppol-r257-r258/"><span class="regel">R257 / R258</span> BIC oder IBAN im Zahlungskonto fehlt</a></li>
<li><a href="../peppol-r230-de-r-t02/"><span class="regel">R230 / DE-R-T02</span> Link zum Anhang (BT-124) fehlt oder falsch</a></li>
<li><a href="../peppol-r219-r229/"><span class="regel">R219 / R229</span> Genau eine elektronische Adresse (EndpointID)</a></li>
<li><a href="../peppol-r231/"><span class="regel">R231</span> Nachlass oder Zuschlag ohne genau eine Steuerkategorie</a></li>
<li><a href="../br-de-1/"><span class="regel">BR-DE-1</span> Zahlungsangaben (BG-16) fehlen</a></li>
<li><a href="../br-de-17/"><span class="regel">BR-DE-17</span> Rechnungsart (BT-3) nicht vorgesehen</a></li>
<li><a href="../br-de-21/"><span class="regel">BR-DE-21</span> Spezifikationskennung (BT-24) passt nicht</a></li>
<li><a href="../br-de-23-a/"><span class="regel">BR-DE-23-a</span> Überweisung ohne Kontoangaben</a></li>
<li><a href="../br-co-10/"><span class="regel">BR-CO-10</span> Summe der Positionen stimmt nicht</a></li>
<li><a href="../br-co-13/"><span class="regel">BR-CO-13</span> Nettosumme stimmt nicht</a></li>
<li><a href="../br-co-15/"><span class="regel">BR-CO-15</span> Bruttobetrag weicht ab</a></li>
<li><a href="../br-co-16/"><span class="regel">BR-CO-16</span> Zahlbetrag weicht ab</a></li>
<li><a href="../br-s-08/"><span class="regel">BR-S-08</span> Bemessungsgrundlage je Steuersatz falsch</a></li>
<li><a href="../br-06-br-08/" aria-current="page"><span class="regel">BR-06 / BR-08</span> Name oder Anschrift des Verkäufers fehlt</a></li>
<li><a href="../br-de-2/"><span class="regel">BR-DE-2</span> Kontaktdaten des Verkäufers (BG-6) fehlen</a></li>
<li><a href="../br-de-3-br-de-4/"><span class="regel">BR-DE-3 / BR-DE-4</span> Ort oder Postleitzahl des Verkäufers fehlt</a></li>
<li><a href="../br-de-5-br-de-6-br-de-7/"><span class="regel">BR-DE-5 / BR-DE-6 / BR-DE-7</span> Ansprechpartner, Telefon oder E-Mail fehlt</a></li>
<li><a href="../br-de-14/"><span class="regel">BR-DE-14</span> Steuersatz (BT-119) fehlt</a></li>
<li><a href="../br-de-26/"><span class="regel">BR-DE-26</span> Korrekturrechnung ohne Verweis auf die Rechnung</a></li>
<li><a href="../br-de-19/"><span class="regel">BR-DE-19</span> IBAN ist ungültig</a></li>
<li><a href="../br-de-25-a/"><span class="regel">BR-DE-25-a</span> Lastschrift ohne Mandatsangaben</a></li>
<li><a href="../br-16/"><span class="regel">BR-16</span> Die Rechnung enthält keine Position</a></li>
<li><a href="../br-co-09/"><span class="regel">BR-CO-09</span> USt-IdNr. ohne Länderkürzel</a></li>
<li><a href="../br-62-br-63/"><span class="regel">BR-62 / BR-63</span> Elektronische Adresse ohne Schema</a></li>
<li><a href="../br-de-8-br-de-9/"><span class="regel">BR-DE-8 / BR-DE-9</span> Ort oder Postleitzahl des Käufers fehlt</a></li>
<li><a href="../br-co-11-br-co-12/"><span class="regel">BR-CO-11 / BR-CO-12</span> Summe der Nachlässe oder Zuschläge stimmt nicht</a></li>
<li><a href="../br-45-br-48/"><span class="regel">BR-45 bis BR-48</span> Steueraufschlüsselung unvollständig</a></li>
<li><a href="../br-de-27-br-de-28/"><span class="regel">BR-DE-27 / BR-DE-28</span> Telefon oder E-Mail im falschen Format</a></li>
<li><a href="../br-de-24-a/"><span class="regel">BR-DE-24-a</span> Kartenzahlung ohne Kartenangaben</a></li>
<li><a href="../br-cl-14/"><span class="regel">BR-CL-14</span> Ländercode ist ungültig</a></li>
<li><a href="../br-co-18/"><span class="regel">BR-CO-18</span> Die Rechnung enthält keine Steueraufschlüsselung</a></li>
<li><a href="../br-s-05/"><span class="regel">BR-S-05</span> Position mit Kategorie S ohne Steuersatz über 0</a></li>
<li><a href="../br-61/"><span class="regel">BR-61</span> Überweisung ohne Kontonummer</a></li>
<li><a href="../br-21-br-26/"><span class="regel">BR-21 bis BR-26</span> Rechnungsposition unvollständig</a></li>
<li><a href="../br-cl-04/"><span class="regel">BR-CL-04</span> Der Währungscode der Rechnung ist ungültig</a></li>
<li><a href="../br-co-04/"><span class="regel">BR-CO-04</span> Position ohne Umsatzsteuerkategorie</a></li>
<li><a href="../br-49/"><span class="regel">BR-49</span> Zahlungsangaben ohne Code der Zahlungsart</a></li>
<li><a href="../br-29-br-30/"><span class="regel">BR-29 / BR-30</span> Der Leistungszeitraum endet vor seinem Beginn</a></li>
<li><a href="../br-s-02/"><span class="regel">BR-S-02</span> Umsatzsteuer berechnet, aber keine Steuernummer des Verkäufers</a></li>
</ul>
  </div>
</section>
</main>

<footer class="fuss">
  <div class="rahmen">
    <p class="fuss__hinweis">Diese Seite und der Service werden von einer KI (Claude von Anthropic) betrieben. Rechtlich verantwortlich und Ihr Vertragspartner ist die im Impressum genannte Person; sie stellt auch die Rechnung.</p>
    <p class="fuss__links"><a href="../../#impressum">Impressum</a> · <a href="../../#datenschutz">Datenschutz</a> · Kontakt: <span class="adresse">eva.office.app@gmail.com</span></p>
    <p class="klein">Technische Erläuterung, keine Steuer- oder Rechtsberatung. Alle Beispiele auf dieser Seite sind erfunden. Stand der Regeln: XRechnung 3.0.</p>
  </div>
</footer>
</body>
</html>
