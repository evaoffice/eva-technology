slug: br-de-1
nav: BR-DE-1
title: BR-DE-1: Zahlungsangaben (BG-16) fehlen in der XRechnung
description: BR-DE-1: Ihrer XRechnung fehlen die Zahlungsangaben (BG-16). Auch bei bereits bezahlten Rechnungen Pflicht. So ergänzen Sie sie richtig.
h1: BR-DE-1: Zahlungsangaben (BG-16) fehlen
meldung: [BR-DE-1] Eine Rechnung (INVOICE) muss Angaben zu "PAYMENT INSTRUCTIONS" (BG-16) enthalten.
detects: yes

**Kurz erklärt.** Jede XRechnung muss mindestens eine Angabe zur Zahlungsart enthalten. In der europäischen Norm EN 16931 ist das freiwillig, das deutsche Regelwerk XRechnung macht es zur Pflicht. Fehlt der Block ganz, lehnt der Validator die Rechnung ab.

**Was die Regel genau prüft.** Im UBL-Format muss unter der Rechnung mindestens ein Element `cac:PaymentMeans` stehen. Welcher Code darin steht, prüft BR-DE-1 nicht; das übernehmen andere Regeln: BR-CL-16 (gültiger Code aus der Liste UNTDID 4461) und, je nach Zahlungsart, BR-DE-23 bis BR-DE-25.

## Typische Ursachen

- Die Rechnung ist schon bezahlt (Vorkasse, PayPal, Kartenzahlung im Shop), und das Programm lässt die Zahlungsangaben deshalb weg.
- Das Programm schreibt die Bankverbindung nur in den Fußtext des PDF, nicht ins XML.
- Ein Export-Plugin erzeugt EN 16931 ohne die deutschen Zusatzregeln.
- Im Kundenstamm ist keine Zahlungsart hinterlegt.

## So beheben Sie es

1. Legen Sie für jede Rechnung eine Zahlungsart fest, auch für bereits bezahlte.
2. Bei Überweisung: Code `58` (SEPA-Überweisung) oder `30` und Ihre IBAN im Konto des Zahlungsempfängers. Ohne IBAN folgt BR-DE-23-a.
3. Bei bereits bezahlten Rechnungen: Geben Sie die tatsächlich verwendete Zahlungsart an, zum Beispiel `68` (Online-Zahlungsdienst) oder `48` (Kartenzahlung), und weisen Sie den gezahlten Betrag in BT-113 (`cbc:PrepaidAmount`) aus. Dann ist der Zahlbetrag (BT-115) 0.
4. Erzeugen Sie die Rechnung neu und prüfen Sie sie erneut.

**Vorher (abgelehnt):** kein `cac:PaymentMeans`.

```xml
<cbc:DocumentCurrencyCode>EUR</cbc:DocumentCurrencyCode>
<cbc:BuyerReference>04011000-12345-34</cbc:BuyerReference>
…
<cac:PaymentTerms>
  <cbc:Note>Zahlbar innerhalb von 14 Tagen.</cbc:Note>
</cac:PaymentTerms>
```

**Nachher**

```xml
<cac:PaymentMeans>
  <cbc:PaymentMeansCode>58</cbc:PaymentMeansCode>
  <cac:PayeeFinancialAccount>
    <cbc:ID>DE02120300000000202051</cbc:ID>
    <cbc:Name>Muster GmbH</cbc:Name>
  </cac:PayeeFinancialAccount>
</cac:PaymentMeans>
<cac:PaymentTerms>
  <cbc:Note>Zahlbar innerhalb von 14 Tagen.</cbc:Note>
</cac:PaymentTerms>
```

Die IBAN im Beispiel ist eine öffentlich verwendete Beispiel-IBAN, kein echtes Konto.

**Häufig zusammen mit:** BR-DE-23-a (Überweisung ohne IBAN) und BR-CL-16 (ungültiger Code für die Zahlungsart).

## Häufige Fragen

- *Die Rechnung ist schon bezahlt. Warum brauche ich trotzdem Zahlungsangaben?* XRechnung verlangt den Block in jeder Rechnung. Geben Sie an, wie bezahlt wurde, und tragen Sie den Betrag als bereits gezahlt ein.
- *Reichen die Zahlungsbedingungen (BT-20)?* Nein. BT-20 ist ein Textfeld; BR-DE-1 verlangt den Block mit der Zahlungsart.
