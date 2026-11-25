<!doctype html>
<html lang="de">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>BR-DE-18: Skonto in der XRechnung richtig angeben</title>
<meta name="description" content="BR-DE-18: Skonto steht in der XRechnung im falschen Format. Wie die Zeile #SKONTO#TAGE=…#PROZENT=…# aussehen muss, mit Beispiel zum Kopieren.">
<link rel="canonical" href="https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-de-18/">
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
<li><a href="../br-de-18/" aria-current="page">BR-DE-18</a></li>
<li><a href="../br-27/">BR-27</a></li>
<li class="group" aria-hidden="true"></li>
<li><a href="../../#angebot">Korrektur anfragen</a></li>
</ul>
</nav>
<div>
<main id="content">
<p class="kicker">XRechnung · Fehlermeldung erklärt</p>
<h1>[BR-DE-18] Skonto Zeilen in … müssen diesem regulärem Ausdruck entsprechen: …</h1>
<p><em>Vollständiger Originaltext (XRechnung-Schematron, am Anfang gekürzt):</em> „Die Informationen zur Gewährung von Skonto müssen wie folgt im Element "Payment terms" (BT-20) übermittelt werden: Anzugeben ist im ersten Segment "SKONTO", im zweiten "TAGE=n", im dritten "PROZENT=n". …“</p>
<p><strong>Kurz erklärt.</strong> Wenn Sie Skonto gewähren, muss die Angabe in den Zahlungsbedingungen (BT-20) einem festen Muster folgen, damit der Empfänger sie automatisch verarbeiten kann. Ein freier Satz wie „2 % Skonto bei Zahlung in 14 Tagen“ genügt nicht, sobald eine Zeile mit <code>#</code> beginnt.</p>
<p><strong>Was die Regel genau prüft.</strong> Jede Zeile in BT-20, die mit <code>#</code> beginnt, muss so aussehen: <code>#SKONTO#TAGE=14#PROZENT=2.00#</code>, optional mit <code>#BASISBETRAG=1000.00#</code>. Prozent mit Punkt und genau zwei Nachkommastellen, alles in Großbuchstaben, keine Leerzeichen. Nach der letzten Skontozeile muss ein Zeilenumbruch folgen. Freier Text ohne <code>#</code> am Zeilenanfang wird nicht geprüft.</p>
<h2>Typische Ursachen</h2>
<ul>
<li>Prozentsatz mit Komma (<code>2,00</code>) oder ohne zwei Nachkommastellen (<code>2</code>).</li>
<li>Leerzeichen oder Kleinbuchstaben (<code>#Skonto#</code>).</li>
<li>Der abschließende Zeilenumbruch fehlt, oft weil das Programm Leerzeichen am Ende abschneidet.</li>
<li>Zwei Skontostufen in einer Zeile.</li>
</ul>
<h2>So beheben Sie es</h2>
<ol>
<li>Schreiben Sie jede Skontostufe in eine eigene Zeile.</li>
<li>Prozent immer mit Punkt und zwei Stellen: <code>PROZENT=2.00</code>.</li>
<li>Beenden Sie die Angabe mit einem Zeilenumbruch.</li>
</ol>
<p><strong>Vorher (abgelehnt)</strong></p>
<pre><code class="language-xml">&lt;cbc:Note&gt;#SKONTO#TAGE=14#PROZENT=2#&lt;/cbc:Note&gt;
</code></pre>
<p><strong>Nachher</strong></p>
<pre><code class="language-xml">&lt;cac:PaymentTerms&gt;
  &lt;cbc:Note&gt;Zahlbar innerhalb von 30 Tagen.
#SKONTO#TAGE=14#PROZENT=2.00#
#SKONTO#TAGE=7#PROZENT=3.00#
&lt;/cbc:Note&gt;
&lt;/cac:PaymentTerms&gt;
</code></pre>
<h2>Häufige Fragen</h2>
<ul>
<li><em>Kann ich Skonto auch nur als Text schreiben?</em> Ja, wenn keine Zeile mit <code>#</code> beginnt. Dann kann der Empfänger das Skonto aber nicht automatisch berechnen.</li>
<li><em>Wofür ist BASISBETRAG?</em> Nur wenn Skonto nicht auf den ganzen Zahlbetrag gilt.</li>
</ul>
<p>Hinweis: Unser Prüfwerkzeug prüft das Skonto-Format (BR-DE-18) derzeit nicht.</p>
<p class="cta"><a href="../../">Prüfen Sie Ihre Datei kostenlos im Browser</a></p>
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
