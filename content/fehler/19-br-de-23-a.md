slug: br-de-23-a
nav: BR-DE-23-a
title: BR-DE-23-a: Überweisung ohne IBAN in der XRechnung
description: BR-DE-23-a: Ihre XRechnung gibt Überweisung (Code 30 oder 58) an, aber kein Konto. So ergänzen Sie IBAN und Kontoinhaber im richtigen Block.
h1: BR-DE-23-a: Überweisung ohne Kontoangaben
meldung: [BR-DE-23-a] Wenn BT-81 "Payment means type code" einen Schlüssel für Überweisungen enthält (30, 58), muss BG-17 "CREDIT TRANSFER" übermittelt werden.
detects: yes

**Kurz erklärt.** Wer als Zahlungsart Überweisung angibt (Code `30` oder `58`), muss auch sagen, wohin überwiesen werden soll. Fehlt das Konto, lehnt der Validator die Rechnung ab.

**Was die Regel genau prüft.** Für jedes `cac:PaymentMeans` mit `cbc:PaymentMeansCode` = `30` oder `58` muss ein `cac:PayeeFinancialAccount` vorhanden sein. Ob die IBAN stimmt, prüft eine andere Regel: BR-DE-19 (bei Code 58, als Warnung). BR-DE-23-b verlangt außerdem, dass im selben Block keine Kartendaten (BG-18) und kein Lastschriftmandat (BG-19) stehen.

## Typische Ursachen

- Die Bankverbindung ist nur im Fußtext des PDF hinterlegt, nicht in den Firmendaten des Programms.
- Das Programm setzt immer Code `58`, auch bei PayPal, Karte oder Lastschrift.
- Bei mehreren Bankkonten ist keines als Standard für Rechnungen markiert.

## So beheben Sie es

1. Hinterlegen Sie Ihre IBAN (ohne Leerzeichen) und den Kontoinhaber in den Firmendaten des Programms.
2. Prüfen Sie den Code: Überweisung `58` (SEPA) oder `30`; Kartenzahlung `48`; SEPA-Lastschrift `59`. Für Karte und Lastschrift gelten eigene Regeln (BR-DE-24, BR-DE-25).
3. Erzeugen Sie die Rechnung neu.

**Vorher (abgelehnt)**

```xml
<cac:PaymentMeans>
  <cbc:PaymentMeansCode>58</cbc:PaymentMeansCode>
</cac:PaymentMeans>
```

**Nachher**

```xml
<cac:PaymentMeans>
  <cbc:PaymentMeansCode>58</cbc:PaymentMeansCode>
  <cac:PayeeFinancialAccount>
    <cbc:ID>DE02120300000000202051</cbc:ID>
    <cbc:Name>Muster GmbH</cbc:Name>
    <cac:FinancialInstitutionBranch>
      <cbc:ID>BYLADEM1001</cbc:ID>
    </cac:FinancialInstitutionBranch>
  </cac:PayeeFinancialAccount>
</cac:PaymentMeans>
```

IBAN und BIC im Beispiel sind öffentlich verwendete Beispielwerte, kein echtes Konto. Die BIC ist freiwillig.

**Häufig zusammen mit:** BR-DE-19 (IBAN ungültig), BR-DE-23-b und BR-DE-1 (Zahlungsangaben fehlen ganz).

## Häufige Fragen

- *Ich habe die IBAN im Freitext. Reicht das?* Nein. Die Regel verlangt den Block `cac:PayeeFinancialAccount`.
- *Der Kunde zahlt per Lastschrift. Was nehme ich?* Code `59` statt `58`, mit Mandatsreferenz und Gläubiger-ID; dann gilt BR-DE-25 statt BR-DE-23.
