<!doctype html>
<html lang="de">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>BR-CO-14: Umsatzsteuer-Summe weicht ab – Cent-Fehler lösen</title>
<meta name="description" content="BR-CO-14: Die Steuersumme der XRechnung passt nicht zur Summe je Steuersatz, oft um einen Cent. Ursache, Rundung, Lösung. Kostenlos im Browser prüfen.">
<link rel="canonical" href="https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-co-14/">
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
<li><a href="../br-co-14/" aria-current="page">BR-CO-14</a></li>
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
<h1>[BR-CO-14] Invoice total VAT amount (BT-110) = Σ VAT category tax amount (BT-117).</h1>
<p><strong>Kurz erklärt.</strong> Der Umsatzsteuer-Gesamtbetrag der Rechnung (BT-110) muss genau der Summe der Steuerbeträge je Steuersatz (BT-117) entsprechen. Der offizielle KoSIT-Validator (1.6.3, XRechnung 3.0.2) hat in unserem Test eine Rechnung mit einem Cent Abweichung abgelehnt.</p>
<p><strong>Was die Regel genau prüft.</strong> Im UBL-Format vergleicht die Regel <code>cac:TaxTotal/cbc:TaxAmount</code> mit der Summe aller <code>cac:TaxSubtotal/cbc:TaxAmount</code>, auf zwei Nachkommastellen gerundet. Eine Toleranz gibt es hier nicht: Ein Cent genügt für die Ablehnung.</p>
<h2>Typische Ursachen</h2>
<ul>
<li>Die Steuer wird für jede Position einzeln gerundet und dann addiert, die Aufschlüsselung aber je Steuersatz berechnet. Bei vielen Positionen entstehen so Rundungsdifferenzen.</li>
<li>Gesamtbetrag und Aufschlüsselung werden an zwei verschiedenen Stellen des Programms berechnet, zum Beispiel einmal im Shop und einmal im Export-Plugin.</li>
<li>Ein Rabatt oder Zuschlag auf Belegebene ist im Gesamtbetrag berücksichtigt, in der Aufschlüsselung nicht (dann meldet der Validator oft auch BR-CO-17).</li>
<li>Eine Rechnung mit zwei Steuersätzen (7 % und 19 %) wird nur mit einem Steuerbetrag ausgegeben.</li>
</ul>
<h2>So beheben Sie es</h2>
<ol>
<li>Summieren Sie je Steuersatz die Nettobeträge der Positionen, einschließlich Rabatten und Zuschlägen auf Belegebene.</li>
<li>Berechnen Sie die Steuer einmal je Steuersatz und runden Sie auf zwei Nachkommastellen.</li>
<li>Übernehmen Sie die Summe dieser Beträge als Gesamtbetrag BT-110.</li>
<li>Passen Sie Bruttobetrag (BT-112) und Zahlbetrag (BT-115) an.</li>
</ol>
<p><strong>Vorher (abgelehnt):</strong> Gesamtbetrag 25,36 €, Aufschlüsselung 25,37 €.</p>
<pre><code class="language-xml">&lt;cac:TaxTotal&gt;
  &lt;cbc:TaxAmount currencyID=&quot;EUR&quot;&gt;25.36&lt;/cbc:TaxAmount&gt;
  &lt;cac:TaxSubtotal&gt;
    &lt;cbc:TaxableAmount currencyID=&quot;EUR&quot;&gt;133.50&lt;/cbc:TaxableAmount&gt;
    &lt;cbc:TaxAmount currencyID=&quot;EUR&quot;&gt;25.37&lt;/cbc:TaxAmount&gt;
    …
</code></pre>
<p><strong>Nachher</strong></p>
<pre><code class="language-xml">&lt;cac:TaxTotal&gt;
  &lt;cbc:TaxAmount currencyID=&quot;EUR&quot;&gt;25.37&lt;/cbc:TaxAmount&gt;
  &lt;cac:TaxSubtotal&gt;
    &lt;cbc:TaxableAmount currencyID=&quot;EUR&quot;&gt;133.50&lt;/cbc:TaxableAmount&gt;
    &lt;cbc:TaxAmount currencyID=&quot;EUR&quot;&gt;25.37&lt;/cbc:TaxAmount&gt;
    …
</code></pre>
<p><strong>Häufig zusammen mit:</strong> BR-CO-15 (Bruttobetrag) und BR-CO-16 (Zahlbetrag), weil sich der Fehler in die Endsummen fortsetzt.</p>
<h2>Häufige Fragen</h2>
<ul>
<li><em>Darf ich je Position runden?</em> Ja, für Ihre interne Rechnung. Die Summe in BT-110 muss aber genau der Summe der Beträge je Steuersatz entsprechen.</li>
<li><em>Warum akzeptiert mein Programm die Rechnung, der Empfänger aber nicht?</em> Viele Programme prüfen beim Erstellen nicht alle Regeln. Prüfen Sie die fertige Datei.</li>
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
