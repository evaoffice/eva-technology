<!doctype html>
<html lang="de">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>BR-DE-15: Käuferreferenz (BT-10) fehlt – was eintragen?</title>
<meta name="description" content="Fehler BR-DE-15 in der XRechnung: Die Käuferreferenz (BT-10) fehlt. Was Behörden (Leitweg-ID) und Firmen dort erwarten und wie Sie das Feld füllen.">
<link rel="canonical" href="https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-de-15/">
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
<li><a href="../br-de-15/" aria-current="page">BR-DE-15</a></li>
<li><a href="../br-co-14/">BR-CO-14</a></li>
<li><a href="../br-co-17/">BR-CO-17</a></li>
<li><a href="../br-ae-10/">BR-AE-10</a></li>
<li><a href="../br-e-10/">BR-E-10</a></li>
<li><a href="../br-co-26/">BR-CO-26</a></li>
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
<h1>[BR-DE-15] Das Element &quot;Buyer reference&quot; (BT-10) muss übermittelt werden.</h1>
<p><strong>Kurz erklärt.</strong> Jede XRechnung muss eine Käuferreferenz enthalten. Fehlt sie oder ist das Feld leer, lehnt der Validator die Rechnung ab. Die Regel stammt aus dem deutschen Regelwerk XRechnung, nicht aus der europäischen Norm EN 16931. Deshalb führen manche Programme, die „nur“ EN 16931 erzeugen, das Feld nicht als Pflichtfeld.</p>
<p><strong>Was die Regel genau prüft.</strong> Im UBL-Format muss <code>cbc:BuyerReference</code> vorhanden sein und darf nicht nur aus Leerzeichen bestehen. Welcher Wert darin steht, prüft der Validator nicht. Ob der Wert zum Empfänger passt, merkt erst der Empfänger.</p>
<h2>Welcher Wert gehört hinein?</h2>
<ul>
<li><strong>Öffentliche Auftraggeber:</strong> die Leitweg-ID, die Ihnen die Behörde nennt, zum Beispiel <code>04011000-12345-34</code>. Ohne korrekte Leitweg-ID kann die Rechnung im Portal nicht zugestellt werden.</li>
<li><strong>Unternehmen:</strong> die Referenz, die Ihr Kunde für die Zuordnung verlangt, etwa Bestellnummer, Kostenstelle oder Ansprechpartner-Kürzel. Hat Ihr Kunde keine Vorgabe, stimmen Sie mit ihm einen Wert ab, zum Beispiel seine Kundennummer bei Ihnen. „n/a“ besteht zwar die Prüfung, hilft dem Empfänger aber nicht.</li>
</ul>
<h2>Typische Ursachen</h2>
<ul>
<li>Das Feld für Leitweg-ID oder Käuferreferenz ist im Kundenstamm leer.</li>
<li>Das Programm füllt BT-10 nur, wenn der Kunde als Behörde markiert ist.</li>
<li>Die Referenz steht im Freitext oder nur im PDF, nicht im XML.</li>
<li>Bei Shop-Systemen (zum Beispiel WooCommerce mit einem E-Rechnungs-Plugin) gibt es pro Bestellung kein Feld für die Referenz, und das Plugin lässt BT-10 leer.</li>
</ul>
<h2>So beheben Sie es</h2>
<ol>
<li>Fragen Sie Ihren Kunden, welche Referenz er erwartet. Behörden nennen Ihnen ihre Leitweg-ID.</li>
<li>Tragen Sie den Wert im Kundenstamm in das Feld für Leitweg-ID oder Käuferreferenz ein.</li>
<li>Erzeugen Sie die Rechnung neu und prüfen Sie sie erneut.</li>
</ol>
<p><strong>Vorher (abgelehnt)</strong></p>
<pre><code class="language-xml">&lt;cbc:BuyerReference&gt;&lt;/cbc:BuyerReference&gt;
</code></pre>
<p><strong>Nachher</strong></p>
<pre><code class="language-xml">&lt;cbc:BuyerReference&gt;04011000-12345-34&lt;/cbc:BuyerReference&gt;
</code></pre>
<p><strong>Häufig zusammen mit:</strong> PEPPOL-EN16931-R010 (elektronische Adresse des Käufers fehlt), weil beide Angaben im Kundenstamm fehlen.</p>
<h2>Häufige Fragen</h2>
<ul>
<li><em>Reicht die Bestellnummer im Feld „Order reference“ (BT-13)?</em> Nein. BT-13 ist ein anderes Feld; BR-DE-15 verlangt BT-10.</li>
<li><em>Muss die Leitweg-ID auch bei Firmenkunden stehen?</em> Nein. Die Leitweg-ID ist für öffentliche Auftraggeber. Bei Firmen genügt eine abgestimmte Referenz.</li>
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
