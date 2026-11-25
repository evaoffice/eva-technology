<!doctype html>
<html lang="de">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Reverse Charge in der XRechnung: Fehler BR-AE-10 beheben</title>
<meta name="description" content="BR-AE-10: Bei Reverse Charge (Kategorie AE) fehlt der Befreiungsgrund in der XRechnung. Welche Angabe der Validator erwartet und wo Sie sie eintragen.">
<link rel="canonical" href="https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-ae-10/">
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
<li><a href="../br-ae-10/" aria-current="page">BR-AE-10</a></li>
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
<h1>[BR-AE-10] A VAT breakdown (BG-23) with VAT Category code (BT-118) &quot;Reverse charge&quot; shall have a VAT exemption reason code (BT-121), meaning &quot;Reverse charge&quot; or the VAT exemption reason text (BT-120) &quot;Reverse charge&quot; (or the equivalent standard text in another language).</h1>
<p><strong>Kurz erklärt.</strong> Wenn Sie eine Rechnung mit Steuerschuldnerschaft des Leistungsempfängers (Reverse Charge, Kategorie „AE“) ausstellen, muss die Steueraufschlüsselung einen Befreiungsgrund enthalten: einen Code (BT-121) oder einen Text (BT-120). Der offizielle KoSIT-Validator (1.6.3, XRechnung 3.0.2) hat eine solche Rechnung ohne Begründung in unserem Test abgelehnt.</p>
<p><strong>Was die Regel genau prüft.</strong> Jede Steueraufschlüsselung mit Kategorie <code>AE</code> braucht <code>cbc:TaxExemptionReasonCode</code> oder <code>cbc:TaxExemptionReason</code>. Ein Hinweis im Freitext der Rechnung (BT-22) zählt nicht.</p>
<h2>Typische Ursachen</h2>
<ul>
<li>Im Kundenstamm ist kein Befreiungsgrund hinterlegt; das Programm schreibt Kategorie AE, aber keinen Grund.</li>
<li>Der Hinweis „Steuerschuldnerschaft des Leistungsempfängers“ steht nur im PDF oder im Freitext.</li>
<li>Bei Bauleistungen (§ 13b UStG) wird Reverse Charge von Hand gesetzt, ohne die passende Vorlage im Programm.</li>
</ul>
<h2>So beheben Sie es</h2>
<ol>
<li>Hinterlegen Sie beim Kunden oder beim Artikel den Befreiungsgrund. Üblich ist der Code <code>VATEX-EU-AE</code>, dazu der Text „Steuerschuldnerschaft des Leistungsempfängers“.</li>
<li>Prüfen Sie, dass Ihre USt-IdNr. und die Ihres Kunden in der Rechnung stehen (sonst folgt BR-AE-02 oder BR-AE-03).</li>
<li>Erzeugen Sie die Rechnung neu.</li>
</ol>
<p><strong>Vorher (abgelehnt)</strong></p>
<pre><code class="language-xml">&lt;cac:TaxCategory&gt;
  &lt;cbc:ID&gt;AE&lt;/cbc:ID&gt;
  &lt;cbc:Percent&gt;0&lt;/cbc:Percent&gt;
  &lt;cac:TaxScheme&gt;&lt;cbc:ID&gt;VAT&lt;/cbc:ID&gt;&lt;/cac:TaxScheme&gt;
&lt;/cac:TaxCategory&gt;
</code></pre>
<p><strong>Nachher</strong></p>
<pre><code class="language-xml">&lt;cac:TaxCategory&gt;
  &lt;cbc:ID&gt;AE&lt;/cbc:ID&gt;
  &lt;cbc:Percent&gt;0&lt;/cbc:Percent&gt;
  &lt;cbc:TaxExemptionReasonCode&gt;VATEX-EU-AE&lt;/cbc:TaxExemptionReasonCode&gt;
  &lt;cbc:TaxExemptionReason&gt;Steuerschuldnerschaft des Leistungsempfängers&lt;/cbc:TaxExemptionReason&gt;
  &lt;cac:TaxScheme&gt;&lt;cbc:ID&gt;VAT&lt;/cbc:ID&gt;&lt;/cac:TaxScheme&gt;
&lt;/cac:TaxCategory&gt;
</code></pre>
<p><strong>Häufig zusammen mit:</strong> BR-AE-02 / BR-AE-03 (USt-IdNr. fehlt) und BR-AE-08 / BR-AE-09 (Beträge in der Kategorie AE müssen 0 Steuer ergeben).</p>
<h2>Häufige Fragen</h2>
<ul>
<li><em>Reicht der Text allein?</em> Ja, die Regel verlangt Code <strong>oder</strong> Text. Mit beiden sind Sie auf der sicheren Seite.</li>
<li><em>Gilt Reverse Charge für meinen Umsatz?</em> Das klären Sie bitte mit Ihrer Steuerberatung.</li>
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
