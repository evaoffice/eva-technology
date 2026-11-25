slug: br-de-3-br-de-4
nav: BR-DE-3 / BR-DE-4
title: BR-DE-3 / BR-DE-4: Ort oder Postleitzahl des Verkäufers fehlt
description: BR-DE-3 und BR-DE-4: In der Anschrift des Verkäufers fehlen Ort (BT-37) oder Postleitzahl (BT-38). Häufige Ursachen und die richtigen XML-Felder.
h1: BR-DE-3 / BR-DE-4: Ort oder Postleitzahl des Verkäufers fehlt
meldung: [BR-DE-3] Das Element "Seller city" (BT-37) muss übermittelt werden. · [BR-DE-4] Das Element "Seller post code" (BT-38) muss übermittelt werden.
detects: yes

**Kurz erklärt.** In der europäischen Norm EN 16931 muss die Anschrift des Verkäufers nur das Land enthalten. XRechnung verlangt zusätzlich Ort und Postleitzahl. Fehlt eines von beiden, lehnt der Validator die Rechnung ab.

## Was die Regeln genau prüfen

- **BR-DE-3:** In `cac:AccountingSupplierParty/cac:Party/cac:PostalAddress` muss `cbc:CityName` stehen und darf nicht leer sein.
- **BR-DE-4:** Im selben Block muss `cbc:PostalZone` stehen und darf nicht leer sein.

Beide Regeln greifen nur, wenn `cac:PostalAddress` vorhanden ist. Fehlt die Anschrift ganz, meldet der Validator BR-08. Für den Käufer gibt es dieselben Regeln als BR-DE-8 (Ort) und BR-DE-9 (Postleitzahl).

## Typische Ursachen

- Postleitzahl und Ort stehen zusammen in einem Feld („10115 Berlin“), das Programm schreibt sie in `cbc:StreetName` oder `cbc:AdditionalStreetName`.
- In den Firmendaten ist nur ein Postfach oder nur die Straße hinterlegt.
- Das Programm schreibt die Postleitzahl in ein Feld mit anderem Namen, zum Beispiel `cbc:PostalCode` statt `cbc:PostalZone`.

## So beheben Sie es

1. Prüfen Sie die Anschrift in den Firmendaten: Straße, Postleitzahl und Ort in getrennten Feldern.
2. Erzeugen Sie die Rechnung neu.
3. Kontrollieren Sie im XML, dass `cbc:CityName` und `cbc:PostalZone` gefüllt sind.

**Vorher (abgelehnt):** Postleitzahl und Ort in der Straßenzeile.

```xml
<cac:PostalAddress>
  <cbc:StreetName>Musterstraße 1, 10115 Berlin</cbc:StreetName>
  <cac:Country><cbc:IdentificationCode>DE</cbc:IdentificationCode></cac:Country>
</cac:PostalAddress>
```

**Nachher**

```xml
<cac:PostalAddress>
  <cbc:StreetName>Musterstraße 1</cbc:StreetName>
  <cbc:CityName>Berlin</cbc:CityName>
  <cbc:PostalZone>10115</cbc:PostalZone>
  <cac:Country><cbc:IdentificationCode>DE</cbc:IdentificationCode></cac:Country>
</cac:PostalAddress>
```

**Häufig zusammen mit:** BR-08 (Anschrift des Verkäufers fehlt ganz), BR-DE-8 / BR-DE-9 (Ort oder Postleitzahl des Käufers) und BR-DE-2 (Kontaktdaten des Verkäufers).

## Häufige Fragen

- *Ich habe nur ein Postfach. Was trage ich ein?* Die Postleitzahl des Postfachs und den Ort. Das Postfach selbst kann in `cbc:StreetName` stehen.
- *Gilt das auch für ausländische Verkäufer?* Ja. Die Regeln gelten für jede XRechnung, unabhängig vom Land des Verkäufers.
