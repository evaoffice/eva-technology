<!doctype html>
<html lang="de">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>BR-E-10: Kleinunternehmer und Steuerbefreiung in XRechnung</title>
<meta name="description" content="BR-E-10: Bei steuerfreien Positionen (Kategorie E), etwa nach § 19 UStG, fehlt der Befreiungsgrund. Welche Angabe in die XRechnung gehört und wohin.">
<link rel="canonical" href="https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-e-10/">
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
<li><a href="../br-e-10/" aria-current="page">BR-E-10</a></li>
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
<h1>[BR-E-10] A VAT breakdown (BG-23) with VAT Category code (BT-118) &quot;Exempt from VAT&quot; shall have a VAT exemption reason code (BT-121) or a VAT exemption reason text (BT-120).</h1>
<p><strong>Kurz erklärt.</strong> Enthält Ihre Rechnung steuerbefreite Umsätze (Kategorie „E“), muss die Steueraufschlüsselung angeben, warum keine Umsatzsteuer berechnet wird: als Code (BT-121) oder als Text (BT-120). Ohne diese Angabe besteht die Rechnung die Prüfung nicht.</p>
<p><strong>Was die Regel genau prüft.</strong> Jede Steueraufschlüsselung mit Kategorie <code>E</code> braucht <code>cbc:TaxExemptionReasonCode</code> oder <code>cbc:TaxExemptionReason</code>. Ein Satz im PDF oder im Freitext zählt nicht.</p>
<h2>Sonderfall Kleinunternehmer (§ 19 UStG)</h2>
<p>Seit dem 1. Januar 2025 müssen alle Unternehmen in Deutschland E-Rechnungen empfangen können, auch Kleinunternehmer. Ausstellen müssen Unternehmen sie ab 2027 (bei mehr als 800.000 Euro Gesamtumsatz im Jahr 2026) bzw. ab 2028; Kleinunternehmer sind davon nach § 34a UStDV ausgenommen. Wer als Kleinunternehmer freiwillig eine XRechnung erzeugt, verwendet meist die Kategorie <code>E</code> und gibt den Grund an, zum Beispiel „Kein Ausweis von Umsatzsteuer, da Kleinunternehmer gemäß § 19 UStG“. Zusätzlich verlangt XRechnung bei Kategorie E eine USt-IdNr. oder Steuernummer des Verkäufers (Regel BR-DE-16).</p>
<h2>Typische Ursachen</h2>
<ul>
<li>Beim Artikel oder Kunden ist kein Befreiungsgrund hinterlegt.</li>
<li>Eine Sammelrechnung enthält steuerfreie Positionen, für die das Programm keinen Grund mitliefert.</li>
<li>Der Kleinunternehmer-Hinweis steht nur als Fußnote im PDF.</li>
</ul>
<h2>So beheben Sie es</h2>
<ol>
<li>Klären Sie mit Ihrer Steuerberatung die Rechtsgrundlage der Befreiung.</li>
<li>Hinterlegen Sie den Grund in Ihrem Programm als Text oder als passenden VATEX-Code.</li>
<li>Unterstützt Ihr Programm keine gemischten Rechnungen, stellen Sie steuerpflichtige und steuerfreie Positionen getrennt in Rechnung.</li>
</ol>
<p><strong>Vorher (abgelehnt)</strong></p>
<pre><code class="language-xml">&lt;cac:TaxCategory&gt;
  &lt;cbc:ID&gt;E&lt;/cbc:ID&gt;
  &lt;cbc:Percent&gt;0&lt;/cbc:Percent&gt;
  &lt;cac:TaxScheme&gt;&lt;cbc:ID&gt;VAT&lt;/cbc:ID&gt;&lt;/cac:TaxScheme&gt;
&lt;/cac:TaxCategory&gt;
</code></pre>
<p><strong>Nachher (Beispiel Kleinunternehmer)</strong></p>
<pre><code class="language-xml">&lt;cac:TaxCategory&gt;
  &lt;cbc:ID&gt;E&lt;/cbc:ID&gt;
  &lt;cbc:Percent&gt;0&lt;/cbc:Percent&gt;
  &lt;cbc:TaxExemptionReason&gt;Kein Ausweis von Umsatzsteuer, da Kleinunternehmer gemäß § 19 UStG&lt;/cbc:TaxExemptionReason&gt;
  &lt;cac:TaxScheme&gt;&lt;cbc:ID&gt;VAT&lt;/cbc:ID&gt;&lt;/cac:TaxScheme&gt;
&lt;/cac:TaxCategory&gt;
</code></pre>
<p><strong>Häufig zusammen mit:</strong> BR-DE-16 (USt-IdNr. oder Steuernummer fehlt) und BR-E-08 (Bemessungsgrundlage der Kategorie E).</p>
<h2>Häufige Fragen</h2>
<ul>
<li><em>Muss ich als Kleinunternehmer überhaupt E-Rechnungen schreiben?</em> Nach § 34a UStDV nicht; empfangen können müssen Sie sie trotzdem. Ob das für Sie gilt, klärt Ihre Steuerberatung.</li>
<li><em>Welchen VATEX-Code nehme ich?</em> Das hängt von der Rechtsgrundlage ab. Ein klarer Text in BT-120 genügt für diese Regel.</li>
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
