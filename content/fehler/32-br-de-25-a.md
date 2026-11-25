slug: br-de-25-a
nav: BR-DE-25-a
title: BR-DE-25-a: SEPA-Lastschrift ohne Mandatsangaben in der XRechnung
description: BR-DE-25-a: Ihre XRechnung gibt Lastschrift (Code 59) an, aber keine Angaben zum Mandat. Was in den Block gehört: Mandatsreferenz, IBAN und Gläubiger-ID.
h1: BR-DE-25-a: Lastschrift ohne Mandatsangaben
meldung: [BR-DE-25-a] Wenn BT-81 "Payment means type code" einen Schlüssel für Lastschriften enthält (59), muss genau BG-19 "DIRECT DEBIT" übermittelt werden.
detects: yes

**Kurz erklärt.** Wer als Zahlungsart SEPA-Lastschrift angibt (Code `59`), muss in der Rechnung auch sagen, auf Grund welches Mandats und von welchem Konto abgebucht wird. Fehlt dieser Block, lehnt der Validator die Rechnung ab.

**Was die Regel genau prüft.** Für jedes `cac:PaymentMeans` mit `cbc:PaymentMeansCode` = `59` muss ein `cac:PaymentMandate` vorhanden sein. Was darin stehen muss, prüfen weitere Regeln des XRechnung-Regelwerks: BR-DE-31 verlangt die IBAN des Zahlers (BT-91), BR-DE-30 Ihre Gläubiger-Identifikationsnummer (BT-90). BR-DE-25-b verlangt, dass im selben Block kein Überweisungskonto (BG-17) und keine Kartendaten (BG-18) stehen.

## Typische Ursachen

- Das Programm setzt Code `59`, weil der Kunde per Lastschrift zahlt, schreibt Mandat und Konto aber nur in den Freitext.
- Mandatsreferenz und IBAN des Kunden sind im Kundenstamm nicht hinterlegt.
- Das Programm gibt bei Lastschrift weiter Ihr eigenes Konto als Überweisungskonto aus.

## So beheben Sie es

1. Hinterlegen Sie im Kundenstamm die Mandatsreferenz und die IBAN des Kunden.
2. Hinterlegen Sie in Ihren Firmendaten Ihre Gläubiger-Identifikationsnummer.
3. Prüfen Sie, dass bei Code `59` kein `cac:PayeeFinancialAccount` im selben Block steht.
4. Erzeugen Sie die Rechnung neu.

**Vorher (abgelehnt)**

```xml
<cac:PaymentMeans>
  <cbc:PaymentMeansCode>59</cbc:PaymentMeansCode>
  <cac:PayeeFinancialAccount>
    <cbc:ID>DE02120300000000202051</cbc:ID>
  </cac:PayeeFinancialAccount>
</cac:PaymentMeans>
```

**Nachher**

```xml
<cac:AccountingSupplierParty>
  <cac:Party>
    …
    <cac:PartyIdentification>
      <cbc:ID schemeID="SEPA">DE98ZZZ09999999999</cbc:ID>
    </cac:PartyIdentification>
    …
  </cac:Party>
</cac:AccountingSupplierParty>
…
<cac:PaymentMeans>
  <cbc:PaymentMeansCode>59</cbc:PaymentMeansCode>
  <cac:PaymentMandate>
    <cbc:ID>MANDAT-2026-0042</cbc:ID>
    <cac:PayerFinancialAccount>
      <cbc:ID>DE89370400440532013000</cbc:ID>
    </cac:PayerFinancialAccount>
  </cac:PaymentMandate>
</cac:PaymentMeans>
```

IBAN und Gläubiger-ID im Beispiel sind öffentlich verwendete Beispielwerte, keine echten Daten.

**Häufig zusammen mit:** BR-DE-25-b, BR-DE-30 (Gläubiger-ID fehlt), BR-DE-31 (IBAN des Zahlers fehlt) und BR-DE-20 (IBAN des Zahlers ungültig).

## Häufige Fragen

- *Wo steht die Gläubiger-ID?* Beim Verkäufer (oder beim Zahlungsempfänger) als Kennung mit `schemeID="SEPA"`, nicht im Block `cac:PaymentMandate`.
- *Darf ich die Mandatsreferenz weglassen, wenn der Kunde sie kennt?* Die Regel verlangt den Block in der Datei. Ihr Kunde braucht die Angaben, um die Abbuchung zuzuordnen.
