slug: br-co-11-br-co-12
nav: BR-CO-11 / BR-CO-12
title: BR-CO-11 / BR-CO-12: Summe der Nachlässe oder Zuschläge stimmt nicht
description: BR-CO-11 und BR-CO-12: Die Summe der Nachlässe (BT-107) oder Zuschläge (BT-108) auf Belegebene passt nicht zu den einzelnen Beträgen. Ursachen und Lösung.
h1: BR-CO-11 / BR-CO-12: Summe der Nachlässe oder Zuschläge stimmt nicht
meldung: [BR-CO-11] Sum of allowances on document level (BT-107) = Σ Document level allowance amount (BT-92). · [BR-CO-12] Sum of charges on document level (BT-108) = Σ Document level charge amount (BT-99).
detects: yes

**Kurz erklärt.** Nachlässe und Zuschläge auf die ganze Rechnung (zum Beispiel ein Rabatt oder Versandkosten) stehen einzeln in der Datei und noch einmal als Summe im Rechnungsabschluss. Beide Angaben müssen übereinstimmen. Weicht die Summe ab oder fehlt sie, lehnt der Validator die Rechnung ab.

## Was die Regeln genau prüfen

- **BR-CO-11:** `cac:LegalMonetaryTotal/cbc:AllowanceTotalAmount` muss gleich der Summe aller `cac:AllowanceCharge` mit `cbc:ChargeIndicator` = `false` sein, auf zwei Nachkommastellen gerundet.
- **BR-CO-12:** `cbc:ChargeTotalAmount` muss gleich der Summe aller `cac:AllowanceCharge` mit `cbc:ChargeIndicator` = `true` sein.

Gibt es keine Nachlässe (oder keine Zuschläge), darf das Summenfeld fehlen. Gibt es welche, muss die Summe dastehen: Ein fehlendes Summenfeld zählt dann als Fehler.

## Typische Ursachen

- Das Programm schreibt den Rabatt als `cac:AllowanceCharge`, lässt aber `cbc:AllowanceTotalAmount` weg.
- Ein Rabatt auf eine einzelne Position wurde zusätzlich als Nachlass auf Belegebene ausgegeben, steht aber nicht in der Summe (oder umgekehrt).
- Nachlass und Zuschlag sind vertauscht: Versandkosten mit `ChargeIndicator` = `false`.
- Einzelbeträge mit mehr als zwei Nachkommastellen, die Summe wurde aus ungerundeten Werten gebildet.

## So beheben Sie es

1. Prüfen Sie bei jedem `cac:AllowanceCharge`, ob `cbc:ChargeIndicator` stimmt: `false` für Nachlässe, `true` für Zuschläge.
2. Tragen Sie die Summe aller Nachlässe als `cbc:AllowanceTotalAmount` und die Summe aller Zuschläge als `cbc:ChargeTotalAmount` ein.
3. Rechnen Sie danach den Nettobetrag nach: BT-109 = BT-106 − BT-107 + BT-108 (siehe BR-CO-13).

**Vorher (abgelehnt):** Rabatt vorhanden, Summe fehlt.

```xml
<cac:AllowanceCharge>
  <cbc:ChargeIndicator>false</cbc:ChargeIndicator>
  <cbc:AllowanceChargeReason>Treuerabatt</cbc:AllowanceChargeReason>
  <cbc:Amount currencyID="EUR">20.00</cbc:Amount>
  …
</cac:AllowanceCharge>
…
<cac:LegalMonetaryTotal>
  <cbc:LineExtensionAmount currencyID="EUR">200.00</cbc:LineExtensionAmount>
  <cbc:TaxExclusiveAmount currencyID="EUR">180.00</cbc:TaxExclusiveAmount>
  …
</cac:LegalMonetaryTotal>
```

**Nachher**

```xml
<cac:LegalMonetaryTotal>
  <cbc:LineExtensionAmount currencyID="EUR">200.00</cbc:LineExtensionAmount>
  <cbc:TaxExclusiveAmount currencyID="EUR">180.00</cbc:TaxExclusiveAmount>
  …
  <cbc:AllowanceTotalAmount currencyID="EUR">20.00</cbc:AllowanceTotalAmount>
  …
</cac:LegalMonetaryTotal>
```

Die Reihenfolge ist im UBL-Format fest: `cbc:AllowanceTotalAmount` und `cbc:ChargeTotalAmount` stehen nach `cbc:TaxInclusiveAmount`.

**Häufig zusammen mit:** BR-CO-13 (Nettosumme), BR-S-08 (Bemessungsgrundlage je Steuersatz) und BR-CO-15.

## Häufige Fragen

- *Gehört ein Rabatt auf eine Position hierher?* Nein. Er mindert den Positionsbetrag (BT-131) und erscheint nicht in BT-107.
- *Muss ich das Summenfeld auch bei nur einem Nachlass angeben?* Ja. Sobald es einen Nachlass auf Belegebene gibt, gehört seine Summe in `cbc:AllowanceTotalAmount`.
