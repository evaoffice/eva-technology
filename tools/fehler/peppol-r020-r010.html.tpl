<!doctype html>
<html lang="de">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>R010 / R020: Elektronische Adresse in der XRechnung fehlt</title>
<meta name="description" content="PEPPOL-EN16931-R010 oder R020: Käufer- oder Verkäufer-Adresse (BT-49/BT-34) fehlt. Welches Schema (z. B. 0204, EM) gilt und wie Sie das Feld füllen.">
<link rel="canonical" href="https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/peppol-r020-r010/">
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
<li><a href="../peppol-r020-r010/" aria-current="page">R020 / R010</a></li>
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
<h1>[PEPPOL-EN16931-R020] Seller electronic address MUST be provided · [PEPPOL-EN16931-R010] Buyer electronic address MUST be provided</h1>
<p><em>Deutsch (unsere Übersetzung, kein Originaltext):</em> Die elektronische Adresse des Verkäufers (BT-34) bzw. des Käufers (BT-49) fehlt.</p>
<p><strong>Kurz erklärt.</strong> Seit XRechnung 3.0 müssen Verkäufer (BT-34) und Käufer (BT-49) eine elektronische Adresse haben. Die Regeln stammen aus dem Peppol-Regelwerk und wurden in XRechnung übernommen; deshalb ist die Meldung auch im KoSIT-Bericht englisch.</p>
<p><strong>Was die Regel genau prüft.</strong> Im UBL-Format muss <code>cbc:EndpointID</code> beim Verkäufer und beim Käufer vorhanden sein. Zusätzlich braucht jede Adresse ein Schema (<code>schemeID</code>), sonst folgen BR-62 oder BR-63.</p>
<h2>Welche Adresse?</h2>
<ul>
<li><strong>Unternehmen:</strong> meist die E-Mail-Adresse für Rechnungen mit dem Schema <code>EM</code>.</li>
<li><strong>Öffentliche Auftraggeber:</strong> als Käuferadresse (BT-49) in der Regel die <strong>Leitweg-ID mit dem Schema <code>0204</code></strong>. Die Käuferreferenz (BT-10) oder eine Lieferadresse ersetzen BT-49 nicht.</li>
</ul>
<h2>Typische Ursachen</h2>
<ul>
<li>In Ihren Firmendaten ist keine E-Mail-Adresse für Rechnungen hinterlegt.</li>
<li>Beim Kunden fehlt eine Rechnungs-E-Mail-Adresse, oder die Leitweg-ID ist nur in BT-10 eingetragen.</li>
<li>Das Programm schreibt die E-Mail in den Kontaktblock, nicht als <code>EndpointID</code>.</li>
</ul>
<h2>So beheben Sie es</h2>
<ol>
<li>Hinterlegen Sie in den Firmendaten eine E-Mail-Adresse für Rechnungen.</li>
<li>Hinterlegen Sie beim Kunden die Adresse, an die er E-Rechnungen erhalten möchte; bei Behörden die Leitweg-ID.</li>
<li>Erzeugen Sie die Rechnung neu.</li>
</ol>
<p><strong>Vorher (abgelehnt)</strong></p>
<pre><code class="language-xml">&lt;cac:AccountingSupplierParty&gt;
  &lt;cac:Party&gt;
    &lt;cac:PartyName&gt;&lt;cbc:Name&gt;Muster GmbH&lt;/cbc:Name&gt;&lt;/cac:PartyName&gt;
    …
</code></pre>
<p><strong>Nachher</strong></p>
<pre><code class="language-xml">&lt;cac:AccountingSupplierParty&gt;
  &lt;cac:Party&gt;
    &lt;cbc:EndpointID schemeID=&quot;EM&quot;&gt;rechnung@muster.de&lt;/cbc:EndpointID&gt;
    …
&lt;cac:AccountingCustomerParty&gt;
  &lt;cac:Party&gt;
    &lt;cbc:EndpointID schemeID=&quot;0204&quot;&gt;04011000-12345-34&lt;/cbc:EndpointID&gt;
    …
</code></pre>
<p><strong>Häufig zusammen mit:</strong> BR-62 / BR-63 (Schema fehlt) und BR-DE-15.</p>
<h2>Häufige Fragen</h2>
<ul>
<li><em>Warum englisch?</em> Die Regel kommt aus Peppol; KoSIT übernimmt den Originaltext.</li>
<li><em>Reicht die E-Mail im Kontakt (BT-43)?</em> Nein, das ist ein anderes Feld.</li>
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
