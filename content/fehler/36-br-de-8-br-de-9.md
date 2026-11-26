slug: br-de-8-br-de-9
nav: BR-DE-8 / BR-DE-9
title: BR-DE-8 / BR-DE-9: Ort oder Postleitzahl des Käufers fehlt
description: BR-DE-8 und BR-DE-9: In der Anschrift des Käufers fehlen Ort (BT-52) oder Postleitzahl (BT-53). Häufige Ursachen im Kundenstamm und die richtigen XML-Felder.
h1: BR-DE-8 / BR-DE-9: Ort oder Postleitzahl des Käufers fehlt
meldung: [BR-DE-8] Das Element "Buyer city" (BT-52) muss übermittelt werden. · [BR-DE-9] Das Element "Buyer post code" (BT-53) muss übermittelt werden.
detects: yes

**Kurz erklärt.** In der europäischen Norm EN 16931 muss die Anschrift des Käufers nur das Land enthalten. XRechnung verlangt zusätzlich Ort und Postleitzahl. Fehlt eines von beiden, lehnt der Validator die Rechnung ab. Es sind dieselben Regeln wie BR-DE-3 und BR-DE-4, nur für den Käufer statt für den Verkäufer.

## Was die Regeln genau prüfen

- **BR-DE-8:** In `cac:AccountingCustomerParty/cac:Party/cac:PostalAddress` muss `cbc:CityName` stehen und darf nicht leer sein.
- **BR-DE-9:** Im selben Block muss `cbc:PostalZone` stehen und darf nicht leer sein.

Beide Regeln greifen nur, wenn `cac:PostalAddress` beim Käufer vorhanden ist. Fehlt die Anschrift des Käufers ganz, meldet das offizielle Regelwerk BR-10.

## Typische Ursachen

- Im Kundenstamm stehen Postleitzahl und Ort in einem Feld („80331 München“), und das Programm schreibt sie in die Straßenzeile.
- Beim Kunden ist nur ein Postfach oder nur die Straße hinterlegt.
- Bei ausländischen Kunden fehlt die Postleitzahl, weil das Feld im Programm als „nur für Deutschland“ gilt.
- Die Anschrift steht nur bei der Lieferadresse (`cac:Delivery`), nicht beim Käufer.

## So beheben Sie es

1. Prüfen Sie den Kundenstamm: Straße, Postleitzahl und Ort in getrennten Feldern.
2. Erzeugen Sie die Rechnung neu.
3. Kontrollieren Sie im XML, dass unter `cac:AccountingCustomerParty` die Felder `cbc:CityName` und `cbc:PostalZone` gefüllt sind.

**Vorher (abgelehnt):** Postleitzahl und Ort in der Straßenzeile.

```xml
<cac:AccountingCustomerParty>
  <cac:Party>
    …
    <cac:PostalAddress>
      <cbc:StreetName>Beispielweg 5, 80331 München</cbc:StreetName>
      <cac:Country><cbc:IdentificationCode>DE</cbc:IdentificationCode></cac:Country>
    </cac:PostalAddress>
    …
```

**Nachher**

```xml
<cac:AccountingCustomerParty>
  <cac:Party>
    …
    <cac:PostalAddress>
      <cbc:StreetName>Beispielweg 5</cbc:StreetName>
      <cbc:CityName>München</cbc:CityName>
      <cbc:PostalZone>80331</cbc:PostalZone>
      <cac:Country><cbc:IdentificationCode>DE</cbc:IdentificationCode></cac:Country>
    </cac:PostalAddress>
    …
```

**Häufig zusammen mit:** BR-10 (Anschrift des Käufers fehlt ganz), BR-11 (Ländercode des Käufers fehlt) und BR-DE-3 / BR-DE-4 (dieselben Angaben beim Verkäufer).

## Häufige Fragen

- *Der Käufer ist eine Behörde mit Leitweg-ID. Brauche ich trotzdem die Anschrift?* Ja. Die Leitweg-ID ersetzt die Postanschrift nicht.
- *Gilt das auch für Käufer im Ausland?* Ja. Die Regeln gelten für jede XRechnung, unabhängig vom Land des Käufers.
