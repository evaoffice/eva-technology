slug: br-de-24-a
nav: BR-DE-24-a
title: BR-DE-24-a: Kartenzahlung ohne Kartenangaben in der XRechnung
description: BR-DE-24-a: Ihre XRechnung gibt Kartenzahlung an (Code 48, 54 oder 55), aber keine Kartenangaben (BG-18). Was in den Block gehört und was nicht.
h1: BR-DE-24-a: Kartenzahlung ohne Kartenangaben
meldung: [BR-DE-24-a] Wenn BT-81 "Payment means type code" einen Schlüssel für Kartenzahlungen enthält (48, 54, 55), muss genau BG-18 "PAYMENT CARD INFORMATION" übermittelt werden.
detects: yes

**Kurz erklärt.** Wer als Zahlungsart Kartenzahlung angibt, muss in der Rechnung auch sagen, mit welcher Karte gezahlt wird. Fehlt dieser Block, lehnt der Validator die Rechnung ab.

**Was die Regel genau prüft.** Für jedes `cac:PaymentMeans` mit `cbc:PaymentMeansCode` = `48` (Kartenzahlung), `54` (Kreditkarte) oder `55` (Debitkarte) muss ein `cac:CardAccount` vorhanden sein. BR-DE-24-b verlangt außerdem, dass im selben Block kein Überweisungskonto (BG-17) und kein Lastschriftmandat (BG-19) steht.

## Was in den Block gehört

- `cbc:PrimaryAccountNumberID` (BT-87): **nur die letzten vier bis sechs Ziffern** der Kartennummer, nie die ganze Nummer.
- `cbc:NetworkID`: das Kartennetz, zum Beispiel `VISA` oder `MC`. Das UBL-Format verlangt dieses Element im Block.
- `cbc:HolderName` (BT-88): der Name des Karteninhabers, freiwillig.

## Typische Ursachen

- Die Rechnung wurde im Shop per Karte bezahlt, und das Programm setzt Code `48`, schreibt aber keine Kartenangaben ins XML.
- Das Programm gibt bei Kartenzahlung weiter das eigene Bankkonto als Überweisungskonto aus (dann meldet der Validator zusätzlich BR-DE-24-b).
- Der Zahlungsdienst liefert keine Kartendaten an das Rechnungsprogramm.

## So beheben Sie es

1. Prüfen Sie, ob wirklich per Karte bezahlt wurde. Lief die Zahlung über einen Online-Zahlungsdienst, passt oft Code `68` besser.
2. Bei Kartenzahlung: Ergänzen Sie `cac:CardAccount` mit den letzten Ziffern der Karte und dem Kartennetz.
3. Entfernen Sie bei Kartenzahlung `cac:PayeeFinancialAccount` aus demselben Block.
4. Erzeugen Sie die Rechnung neu.

**Vorher (abgelehnt)**

```xml
<cac:PaymentMeans>
  <cbc:PaymentMeansCode>48</cbc:PaymentMeansCode>
</cac:PaymentMeans>
```

**Nachher**

```xml
<cac:PaymentMeans>
  <cbc:PaymentMeansCode>48</cbc:PaymentMeansCode>
  <cac:CardAccount>
    <cbc:PrimaryAccountNumberID>1234</cbc:PrimaryAccountNumberID>
    <cbc:NetworkID>VISA</cbc:NetworkID>
    <cbc:HolderName>Max Muster</cbc:HolderName>
  </cac:CardAccount>
</cac:PaymentMeans>
```

Die Werte im Beispiel sind Beispielwerte.

**Häufig zusammen mit:** BR-DE-24-b (Überweisungskonto oder Mandat bei Kartenzahlung), BR-DE-1 (Zahlungsangaben fehlen ganz) und BR-DE-23-a (Überweisung ohne Konto).

## Häufige Fragen

- *Darf ich die volle Kartennummer angeben?* Nein. In BT-87 gehören nur die letzten vier bis sechs Ziffern.
- *Die Rechnung ist schon bezahlt. Brauche ich trotzdem Kartenangaben?* Ja, wenn Sie Code `48`, `54` oder `55` angeben. Den gezahlten Betrag tragen Sie zusätzlich als `cbc:PrepaidAmount` (BT-113) ein.
