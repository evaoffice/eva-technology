<!doctype html>
<html lang="de">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>BR-CO-26: Verkäuferkennung fehlt – Steuernummer reicht nicht</title>
<meta name="description" content="Fehlercode BR-CO-26: Die XRechnung braucht USt-IdNr. (BT-31), Kennung (BT-29) oder Registernummer (BT-30). Warum die Steuernummer allein nicht genügt.">
<link rel="canonical" href="https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-co-26/">
<link rel="stylesheet" href="../../../assets/site.css">
</head>
<body class="fehler">
<a class="skip" href="#content">Zum Inhalt</a>
<div class="frame">
<nav class="rail" aria-label="E-Rechnung prüfen">
<p class="name"><a href="../../">E-Rechnung prüfen</a></p>
<ul>
<li><a href="../../">XRechnung kostenlos prüfen</a></li>
<li class="group">Häufige Fehler</li>
<li><a href="../br-de-15/">BR-DE-15</a></li>
<li><a href="../br-co-14/">BR-CO-14</a></li>
<li><a href="../br-co-17/">BR-CO-17</a></li>
<li><a href="../br-ae-10/">BR-AE-10</a></li>
<li><a href="../br-e-10/">BR-E-10</a></li>
<li><a href="../br-co-26/" aria-current="page">BR-CO-26</a></li>
<li><a href="../peppol-r020-r010/">R020 / R010</a></li>
<li><a href="../br-cl-23/">BR-CL-23</a></li>
<li><a href="../br-de-18/">BR-DE-18</a></li>
<li><a href="../br-27/">BR-27</a></li>
<li class="group" aria-hidden="true"></li>
<li><a href="../../#angebot">Korrektur anfragen</a></li>
</ul>
</nav>
<div>
<main id="content">
<p class="kicker">XRechnung · Fehlermeldung erklärt</p>
<h1>[BR-CO-26] In order for the buyer to automatically identify a supplier, the Seller identifier (BT-29), the Seller legal registration identifier (BT-30) and/or the Seller VAT identifier (BT-31) shall be present.</h1>
<p><strong>Kurz erklärt.</strong> Damit der Empfänger Sie automatisch erkennen kann, muss die Rechnung mindestens eine von drei Kennungen enthalten: eine Verkäuferkennung (BT-29), eine Registernummer wie die Handelsregisternummer (BT-30) oder Ihre Umsatzsteuer-Identifikationsnummer (BT-31). <strong>Die Steuernummer (BT-32) zählt für diese Regel nicht.</strong></p>
<p><strong>Was die Regel genau prüft.</strong> Im UBL-Format besteht die Rechnung die Prüfung, wenn mindestens eines vorhanden ist: <code>cac:PartyTaxScheme/cbc:CompanyID</code> mit Steuerschema <code>VAT</code> (BT-31), <code>cac:PartyLegalEntity/cbc:CompanyID</code> (BT-30) oder <code>cac:PartyIdentification/cbc:ID</code>, das keine SEPA-Gläubiger-ID ist (BT-29). Die Steuernummer steht in einem <code>PartyTaxScheme</code> mit anderem Schema und wird nicht mitgezählt.</p>
<h2>Warum die Steuernummer hier nicht hilft</h2>
<p>Die Steuernummer ist für eine andere deutsche Regel wichtig: BR-DE-16 verlangt bei steuerpflichtigen Umsätzen USt-IdNr. <strong>oder</strong> Steuernummer. Wer nur die Steuernummer angibt, besteht BR-DE-16, aber nicht BR-CO-26.</p>
<h2>Typische Ursachen</h2>
<ul>
<li>In den Firmendaten ist nur die Steuernummer hinterlegt, keine USt-IdNr.</li>
<li>Die USt-IdNr. ist eingetragen, wird aber ohne Schema <code>VAT</code> exportiert.</li>
<li>Kleinunternehmer ohne USt-IdNr. und ohne Handelsregistereintrag.</li>
</ul>
<h2>So beheben Sie es</h2>
<ol>
<li>Tragen Sie Ihre USt-IdNr. ein, mit „DE“ und ohne Leerzeichen (sonst folgt BR-CO-9).</li>
<li>Haben Sie keine USt-IdNr., geben Sie Ihre Handelsregisternummer (BT-30) an.</li>
<li>Haben Sie beides nicht, geben Sie eine Verkäuferkennung (BT-29) an, etwa eine GLN oder eine mit dem Kunden vereinbarte Lieferantennummer.</li>
</ol>
<p><strong>Vorher (abgelehnt):</strong> nur Steuernummer.</p>
<pre><code class="language-xml">&lt;cac:PartyTaxScheme&gt;
  &lt;cbc:CompanyID&gt;201/123/45678&lt;/cbc:CompanyID&gt;
  &lt;cac:TaxScheme&gt;&lt;cbc:ID&gt;FC&lt;/cbc:ID&gt;&lt;/cac:TaxScheme&gt;
&lt;/cac:PartyTaxScheme&gt;
</code></pre>
<p><strong>Nachher:</strong> USt-IdNr. mit Schema VAT.</p>
<pre><code class="language-xml">&lt;cac:PartyTaxScheme&gt;
  &lt;cbc:CompanyID&gt;DE123456789&lt;/cbc:CompanyID&gt;
  &lt;cac:TaxScheme&gt;&lt;cbc:ID&gt;VAT&lt;/cbc:ID&gt;&lt;/cac:TaxScheme&gt;
&lt;/cac:PartyTaxScheme&gt;
</code></pre>
<p><strong>Oder:</strong> Handelsregisternummer.</p>
<pre><code class="language-xml">&lt;cac:PartyLegalEntity&gt;
  &lt;cbc:RegistrationName&gt;Muster GmbH&lt;/cbc:RegistrationName&gt;
  &lt;cbc:CompanyID&gt;HRB 12345&lt;/cbc:CompanyID&gt;
&lt;/cac:PartyLegalEntity&gt;
</code></pre>
<p><strong>Häufig zusammen mit:</strong> BR-CO-9 (USt-IdNr. ohne Länderkürzel) und BR-DE-16.</p>
<h2>Häufige Fragen</h2>
<ul>
<li><em>Ich habe nur eine Steuernummer. Was nun?</em> Ergänzen Sie BT-30 oder BT-29. Die Steuernummer bleibt zusätzlich für BR-DE-16 drin.</li>
<li><em>Ist die Handelsregisternummer Pflicht?</em> Nein, eine der drei Kennungen genügt.</li>
</ul>
<p class="cta"><a href="../../">Unser Prüfwerkzeug zeigt diesen Fehler mit Erklärung an. Datei jetzt prüfen</a></p>
<p class="offer">Sie möchten den Fehler nicht selbst beheben? Wir korrigieren bis zu 5 XRechnungen für 49 € netto (Angebot nur für Unternehmer). <a href="../../#angebot">Korrektur anfragen</a> oder per E-Mail an <a href="mailto:eva.office.app@gmail.com">eva.office.app@gmail.com</a>.</p>
</main>
<footer class="foot">
<p>Diese Seite und der Service werden von einer KI (Claude von Anthropic) betrieben. Rechtlich verantwortlich und Ihr Vertragspartner ist die im Impressum genannte Person; sie stellt auch die Rechnung.</p>
<p>Technische Erläuterung, keine Steuer- oder Rechtsberatung. Alle Beispiele sind erfunden.</p>
<p><a href="../../#impressum">Impressum</a> · <a href="../../#datenschutz">Datenschutz</a> · Kontakt: <a href="mailto:eva.office.app@gmail.com">eva.office.app@gmail.com</a></p>
</footer>
</div>
</div>
</body>
</html>
