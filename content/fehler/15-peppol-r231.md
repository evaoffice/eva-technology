slug: peppol-r231
nav: R231
title: R231: Nachlass oder Zuschlag ohne genau eine Steuerkategorie
description: R231 (Peppol BIS, ab 24.02.2027): Jeder Nachlass oder Zuschlag auf Belegebene braucht genau eine Steuerkategorie. Ursachen und Lösung.
h1: PEPPOL-EN16931-R231: Nachlass oder Zuschlag ohne genau eine Steuerkategorie
meldung: [PEPPOL-EN16931-R231]-ubl-invoice:Invoice/cac:AllowanceCharge MUST contain exactly one cac:TaxCategory.
detects: link-only

*Deutsch (unsere Übersetzung, kein Originaltext):* Jeder Nachlass oder Zuschlag auf Belegebene braucht genau eine Steuerkategorie.

**Kurz erklärt.** Ein Rabatt oder Zuschlag auf die ganze Rechnung (`cac:AllowanceCharge` direkt unter der Rechnung) muss einer Steuerkategorie zugeordnet sein, zum Beispiel `S` mit 19 %. Ab dem 24. Februar 2027 lehnt die Peppol-Prüfung die Rechnung ab, wenn die Kategorie fehlt oder wenn dort zwei stehen.

{{PEPPOL-2026-11}}

**Was die Regel genau prüft.** Für jedes `cac:AllowanceCharge` auf Belegebene zählt die Regel `cac:TaxCategory`: genau eins. Ob Kategorie und Satz passen, prüfen andere Regeln (zum Beispiel BR-S-08 für die Bemessungsgrundlage).

## Typische Ursachen

- Ein Rabatt auf eine Rechnung mit 7 % und 19 % wird als ein einziger Nachlass mit zwei Steuerkategorien ausgegeben.
- Ein Versandkostenzuschlag wird ohne Steuerkategorie exportiert.

## So beheben Sie es

1. Teilen Sie einen Rabatt auf Rechnungen mit mehreren Steuersätzen in einen Nachlass je Steuersatz auf.
2. Geben Sie jedem Nachlass und Zuschlag genau eine `cac:TaxCategory` mit Kategorie und Satz.
3. Prüfen Sie danach die Summen je Steuersatz (BR-CO-14, BR-S-08).

**Vorher (ab 24.02.2027 abgelehnt)**

```xml
<cac:AllowanceCharge>
  <cbc:ChargeIndicator>false</cbc:ChargeIndicator>
  <cbc:AllowanceChargeReason>Rabatt</cbc:AllowanceChargeReason>
  <cbc:Amount currencyID="EUR">30.00</cbc:Amount>
  <cac:TaxCategory><cbc:ID>S</cbc:ID><cbc:Percent>19</cbc:Percent><cac:TaxScheme><cbc:ID>VAT</cbc:ID></cac:TaxScheme></cac:TaxCategory>
  <cac:TaxCategory><cbc:ID>S</cbc:ID><cbc:Percent>7</cbc:Percent><cac:TaxScheme><cbc:ID>VAT</cbc:ID></cac:TaxScheme></cac:TaxCategory>
</cac:AllowanceCharge>
```

**Nachher**

```xml
<cac:AllowanceCharge>
  <cbc:ChargeIndicator>false</cbc:ChargeIndicator>
  <cbc:AllowanceChargeReason>Rabatt</cbc:AllowanceChargeReason>
  <cbc:Amount currencyID="EUR">20.00</cbc:Amount>
  <cac:TaxCategory><cbc:ID>S</cbc:ID><cbc:Percent>19</cbc:Percent><cac:TaxScheme><cbc:ID>VAT</cbc:ID></cac:TaxScheme></cac:TaxCategory>
</cac:AllowanceCharge>
<cac:AllowanceCharge>
  <cbc:ChargeIndicator>false</cbc:ChargeIndicator>
  <cbc:AllowanceChargeReason>Rabatt</cbc:AllowanceChargeReason>
  <cbc:Amount currencyID="EUR">10.00</cbc:Amount>
  <cac:TaxCategory><cbc:ID>S</cbc:ID><cbc:Percent>7</cbc:Percent><cac:TaxScheme><cbc:ID>VAT</cbc:ID></cac:TaxScheme></cac:TaxCategory>
</cac:AllowanceCharge>
```

**Häufig zusammen mit:** BR-32 / BR-37 (Steuerkategorie des Nachlasses oder Zuschlags fehlt), BR-CO-14 und BR-S-08.

## Häufige Fragen

- *Wie verteile ich einen Rabatt auf zwei Steuersätze?* Meist im Verhältnis der Nettobeträge. Klären Sie die Aufteilung mit Ihrer Steuerberatung.
- *Gilt das auch für Rabatte auf einzelne Positionen?* Diese Regel betrifft nur die Belegebene.

Hinweis: Unser Prüfwerkzeug prüft diese Regel derzeit nicht.
