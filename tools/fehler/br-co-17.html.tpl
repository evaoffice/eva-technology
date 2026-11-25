<!doctype html>
<html lang="de">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>BR-CO-17: Steuerbetrag passt nicht zur Bemessungsgrundlage</title>
<meta name="description" content="BR-CO-17 in der XRechnung: Steuerbetrag je Steuersatz und Bemessungsgrundlage × Satz passen nicht zusammen. Was die Regel prüft und wie Sie es beheben.">
<link rel="canonical" href="https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-co-17/">
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
<li><a href="../br-co-17/" aria-current="page">BR-CO-17</a></li>
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
<h1>[BR-CO-17] VAT category tax amount (BT-117) = VAT category taxable amount (BT-116) x (VAT category rate (BT-119) / 100), rounded to two decimals.</h1>
<p><strong>Kurz erklärt.</strong> Für jeden Steuersatz muss der Steuerbetrag (BT-117) zur Bemessungsgrundlage (BT-116) und zum Steuersatz (BT-119) passen. Erscheint diese Meldung, ist der Unterschied meist größer als ein Rundungsfehler.</p>
<p><strong>Was die Regel genau prüft.</strong> Im offiziellen Regelwerk für UBL (EN 16931, Datei <code>EN16931-UBL-model.sch</code>) gilt der Steuerbetrag als richtig, wenn er <strong>weniger als 1,00</strong> (eine Währungseinheit) vom gerundeten Wert „Bemessungsgrundlage × Steuersatz / 100“ abweicht. Bei Steuersatz 0 muss der Steuerbetrag 0 sein. Eine Abweichung von einem Cent löst diese Regel nach dem Regelwerk also nicht aus; sie kann aber BR-CO-14 auslösen. Maßgeblich ist der Bericht des Validators, den Sie oder Ihr Empfänger verwenden.</p>
<h2>Typische Ursachen</h2>
<ul>
<li>Die Bemessungsgrundlage enthält einen Rabatt, der Steuerbetrag nicht (oder umgekehrt).</li>
<li>Positionen mit verschiedenen Steuersätzen landen in derselben Aufschlüsselung.</li>
<li>Bei Bruttopreisen wird die Steuer aus dem Bruttobetrag herausgerechnet, die Bemessungsgrundlage aber aus anderen Werten gebildet.</li>
<li>Der Steuersatz in der Aufschlüsselung (zum Beispiel 19) passt nicht zu den Positionen (zum Beispiel 7).</li>
</ul>
<h2>So beheben Sie es</h2>
<ol>
<li>Bilden Sie je Steuersatz die Summe der Nettobeträge (BT-116), einschließlich Rabatten und Zuschlägen auf Belegebene mit diesem Steuersatz.</li>
<li>Berechnen Sie BT-117 = BT-116 × Steuersatz / 100 und runden Sie kaufmännisch auf zwei Stellen.</li>
<li>Bei Bruttopreisen: Rechnen Sie zuerst die Nettopositionen aus und leiten Sie die Steuer daraus ab.</li>
<li>Prüfen Sie danach BR-CO-14, denn beide Regeln hängen zusammen.</li>
</ol>
<p>Beispiel: 133,50 € × 19 % = 25,365 € → 25,37 €.</p>
<p><strong>Vorher (abgelehnt):</strong> Rabatt von 50 € nur in der Bemessungsgrundlage berücksichtigt.</p>
<pre><code class="language-xml">&lt;cac:TaxSubtotal&gt;
  &lt;cbc:TaxableAmount currencyID=&quot;EUR&quot;&gt;83.50&lt;/cbc:TaxableAmount&gt;
  &lt;cbc:TaxAmount currencyID=&quot;EUR&quot;&gt;25.37&lt;/cbc:TaxAmount&gt;
  …
</code></pre>
<p><strong>Nachher</strong></p>
<pre><code class="language-xml">&lt;cac:TaxSubtotal&gt;
  &lt;cbc:TaxableAmount currencyID=&quot;EUR&quot;&gt;83.50&lt;/cbc:TaxableAmount&gt;
  &lt;cbc:TaxAmount currencyID=&quot;EUR&quot;&gt;15.87&lt;/cbc:TaxAmount&gt;
  …
</code></pre>
<p><strong>Häufig zusammen mit:</strong> BR-CO-14 und BR-S-08 (Bemessungsgrundlage je Steuersatz).</p>
<h2>Häufige Fragen</h2>
<ul>
<li><em>Lehnt der Validator schon bei einem Cent ab?</em> Nach dem offiziellen UBL-Regelwerk nicht bei BR-CO-17. Ein Cent im Gesamtbetrag führt aber zu BR-CO-14.</li>
<li><em>Muss ich mein Programm auf Nettopreise umstellen?</em> Nicht unbedingt. Wichtig ist, dass die XML-Datei die Werte netto und je Steuersatz richtig ausweist.</li>
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
