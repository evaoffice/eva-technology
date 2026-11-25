<!doctype html>
<html lang="de">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>BR-CL-23: „Std“ und „Stk“ sind keine gültigen Einheiten</title>
<meta name="description" content="BR-CL-23: Die Mengeneinheit der XRechnung ist ungültig. Welche Codes stattdessen gelten (HUR für Stunde, C62 für Stück) und wo Sie sie ändern.">
<link rel="canonical" href="https://evaoffice.github.io/eva-technology/e-rechnung-pruefen/fehler/br-cl-23/">
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
<li><a href="../br-cl-23/" aria-current="page">BR-CL-23</a></li>
<li><a href="../br-de-18/">BR-DE-18</a></li>
<li><a href="../br-27/">BR-27</a></li>
<li class="group" aria-hidden="true"></li>
<li><a href="../../#angebot">Korrektur anfragen</a></li>
</ul>
</nav>
<div>
<main id="content">
<p class="kicker">XRechnung · Fehlermeldung erklärt</p>
<h1>[BR-CL-23] Unit code MUST be coded according to the UN/ECE Recommendation 20 with Rec 21 extension</h1>
<p><strong>Kurz erklärt.</strong> Mengeneinheiten müssen als genormter Code angegeben werden, nicht als Abkürzung. „Std“, „Stk“ oder „Pauschal“ sind keine gültigen Codes. In unserem Test hat der offizielle KoSIT-Validator (1.6.3, XRechnung 3.0.2) eine solche Rechnung angenommen, den Fehler aber gemeldet. Das Programm Ihres Empfängers kann strenger sein.</p>
<p><strong>Was die Regel genau prüft.</strong> Das Attribut <code>unitCode</code> an <code>cbc:InvoicedQuantity</code>, <code>cbc:CreditedQuantity</code> und <code>cbc:BaseQuantity</code> muss in der Codeliste UN/ECE Recommendation 20 (mit Rec 21) stehen. Groß- und Kleinschreibung zählt, Leerzeichen sind nicht erlaubt.</p>
<h2>Häufige Codes</h2>
<table>
<thead>
<tr>
<th>Einheit</th>
<th>Code</th>
</tr>
</thead>
<tbody>
<tr>
<td>Stunde</td>
<td><code>HUR</code></td>
</tr>
<tr>
<td>Stück</td>
<td><code>H87</code> oder <code>C62</code></td>
</tr>
<tr>
<td>Tag</td>
<td><code>DAY</code></td>
</tr>
<tr>
<td>Monat</td>
<td><code>MON</code></td>
</tr>
<tr>
<td>Kilogramm</td>
<td><code>KGM</code></td>
</tr>
<tr>
<td>Meter</td>
<td><code>MTR</code></td>
</tr>
<tr>
<td>Pauschale</td>
<td><code>LS</code></td>
</tr>
</tbody>
</table>
<h2>Typische Ursachen</h2>
<ul>
<li>Das Programm übernimmt die Einheit aus dem Artikelstamm als Freitext.</li>
<li>Eigene Einheiten („Lizenz“, „Paket“) wurden nie einem Code zugeordnet.</li>
<li>Shop-Plugins setzen für alle Positionen „Stk“.</li>
</ul>
<h2>So beheben Sie es</h2>
<ol>
<li>Ordnen Sie jeder Einheit den passenden Code zu (siehe Tabelle).</li>
<li>Hinterlegen Sie die Zuordnung im Artikel- oder Einheitenstamm.</li>
<li>Erzeugen Sie die Rechnung neu.</li>
</ol>
<p><strong>Vorher (Fehler gemeldet)</strong></p>
<pre><code class="language-xml">&lt;cbc:InvoicedQuantity unitCode=&quot;Std&quot;&gt;8&lt;/cbc:InvoicedQuantity&gt;
</code></pre>
<p><strong>Nachher</strong></p>
<pre><code class="language-xml">&lt;cbc:InvoicedQuantity unitCode=&quot;HUR&quot;&gt;8&lt;/cbc:InvoicedQuantity&gt;
</code></pre>
<h2>Häufige Fragen</h2>
<ul>
<li><em>Der Validator hat die Rechnung angenommen. Muss ich das trotzdem ändern?</em> Ja. Der Fehler steht im Bericht, und der Empfänger kann die Rechnung deswegen zurückweisen.</li>
<li><em>Welcher Code für Lizenzen oder Pakete?</em> Meist <code>C62</code> (Einheit) oder <code>LS</code> (Pauschale).</li>
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
