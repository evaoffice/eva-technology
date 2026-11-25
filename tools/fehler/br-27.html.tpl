<!doctype html>
<html lang="de">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>BR-27: Negativer Artikelpreis – Rabatt richtig abbilden</title>
<meta name="description" content="BR-27: Der Artikelpreis in der XRechnung darf nicht negativ sein. Wie Sie Rabatte und Abzüge stattdessen als Nachlass oder negative Menge angeben.">
<link rel="canonical" href="https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-27/">
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
<li><a href="../br-co-26/">BR-CO-26</a></li>
<li><a href="../peppol-r020-r010/">R020 / R010</a></li>
<li><a href="../br-cl-23/">BR-CL-23</a></li>
<li><a href="../br-de-18/">BR-DE-18</a></li>
<li><a href="../br-27/" aria-current="page">BR-27</a></li>
<li class="group" aria-hidden="true"></li>
<li><a href="../../#angebot">Korrektur anfragen</a></li>
</ul>
</nav>
<div>
<main id="content">
<p class="kicker">XRechnung · Fehlermeldung erklärt</p>
<h1>[BR-27] The Item net price (BT-146) shall NOT be negative.</h1>
<p><strong>Kurz erklärt.</strong> Der Nettopreis einer Position (BT-146) darf nicht negativ sein. Wer Rabatte, Rücknahmen oder Gutschriften mit einem Minuspreis abbildet, erhält diese Meldung. Oft folgt BR-CO-16, weil der Zahlbetrag dann nicht mehr aufgeht.</p>
<p><strong>Was die Regel genau prüft.</strong> <code>cac:Price/cbc:PriceAmount</code> jeder Position muss 0 oder größer sein. Eine negative <strong>Menge</strong> ist dagegen erlaubt.</p>
<h2>Typische Ursachen</h2>
<ul>
<li>Ein Rabatt oder eine Rücknahme wird als Position mit negativem Preis erfasst.</li>
<li>Eine Korrekturrechnung übernimmt alle Beträge mit Minuszeichen.</li>
<li>Ein Gutschein im Shop wird als Artikel mit Minuspreis exportiert.</li>
</ul>
<h2>So beheben Sie es</h2>
<ol>
<li>Lassen Sie den Preis positiv und setzen Sie die Menge negativ.</li>
<li>Rabatte auf die ganze Rechnung bilden Sie als Nachlass auf Belegebene ab (<code>cac:AllowanceCharge</code> mit <code>ChargeIndicator</code> = <code>false</code>).</li>
<li>Für echte Gutschriften verwenden Sie, wenn Ihr Programm es kann, die dafür vorgesehene Belegart.</li>
<li>Prüfen Sie danach die Summen: Zahlbetrag = Bruttobetrag − bereits gezahlt + Rundung.</li>
</ol>
<p><strong>Vorher (abgelehnt)</strong></p>
<pre><code class="language-xml">&lt;cbc:InvoicedQuantity unitCode=&quot;H87&quot;&gt;1&lt;/cbc:InvoicedQuantity&gt;
&lt;cbc:LineExtensionAmount currencyID=&quot;EUR&quot;&gt;-50.00&lt;/cbc:LineExtensionAmount&gt;
…
&lt;cac:Price&gt;&lt;cbc:PriceAmount currencyID=&quot;EUR&quot;&gt;-50.00&lt;/cbc:PriceAmount&gt;&lt;/cac:Price&gt;
</code></pre>
<p><strong>Nachher</strong></p>
<pre><code class="language-xml">&lt;cbc:InvoicedQuantity unitCode=&quot;H87&quot;&gt;-1&lt;/cbc:InvoicedQuantity&gt;
&lt;cbc:LineExtensionAmount currencyID=&quot;EUR&quot;&gt;-50.00&lt;/cbc:LineExtensionAmount&gt;
…
&lt;cac:Price&gt;&lt;cbc:PriceAmount currencyID=&quot;EUR&quot;&gt;50.00&lt;/cbc:PriceAmount&gt;&lt;/cac:Price&gt;
</code></pre>
<p><strong>Häufig zusammen mit:</strong> BR-CO-16 (Zahlbetrag) und BR-CO-10 (Summe der Positionen).</p>
<h2>Häufige Fragen</h2>
<ul>
<li><em>Darf der Positionsbetrag negativ sein?</em> Ja, der Positionsbetrag (BT-131) darf negativ sein, nur der Preis nicht.</li>
<li><em>Rabatt als Position oder auf Belegebene?</em> Für einen Rabatt auf die ganze Rechnung ist der Nachlass auf Belegebene sauberer.</li>
</ul>
<p>Hinweis: Unser Prüfwerkzeug liest Gutschriften (CreditNote) derzeit nicht.</p>
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
