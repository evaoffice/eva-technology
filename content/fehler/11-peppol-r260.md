slug: peppol-r260
nav: R260
title: R260: Zahlungsbedingungen brauchen genau ein cbc:Note
description: R260 (Peppol BIS, ab 24.02.2027): PaymentTerms braucht genau ein cbc:Note. Mehrere Zeilen und Skonto gehören in dasselbe Element.
h1: PEPPOL-EN16931-R260: Zahlungsbedingungen brauchen genau ein cbc:Note
meldung: [PEPPOL-EN16931-R260]-ubl-invoice:Invoice/cac:PaymentTerms MUST contain exactly one cbc:Note.
detects: link-only

*Deutsch (unsere Übersetzung, kein Originaltext):* Die Zahlungsbedingungen müssen genau ein Textelement `cbc:Note` enthalten.

**Kurz erklärt.** Die Zahlungsbedingungen (BT-20) stehen im UBL-Format in `cac:PaymentTerms/cbc:Note`. Ab dem 24. Februar 2027 lehnt die Peppol-Prüfung eine Rechnung ab, wenn dort kein `cbc:Note` steht oder wenn es mehrere gibt. Mehrere Zeilen sind erlaubt, sie müssen aber im selben Element stehen.

{{PEPPOL-2026-11}}

**Was die Regel genau prüft.** Für jedes `cac:PaymentTerms` der Rechnung zählt die Regel die `cbc:Note`. Erlaubt ist genau eins. Was darin steht, prüft diese Regel nicht.

## Typische Ursachen

- Das Programm schreibt jede Zeile der Zahlungsbedingungen (Zahlungsziel, Skontostufe 1, Skontostufe 2) in ein eigenes `cbc:Note`.
- Das Programm erzeugt `cac:PaymentTerms` auch dann, wenn im Kundenstamm keine Zahlungsbedingung hinterlegt ist, und lässt es leer.
- Ein Plugin ergänzt Skonto in einem zweiten `cbc:Note`, statt es an den vorhandenen Text anzuhängen.

## So beheben Sie es

1. Fassen Sie alle Zeilen der Zahlungsbedingungen in einem einzigen `cbc:Note` zusammen und trennen Sie sie mit Zeilenumbrüchen.
2. Ohne Zahlungsbedingung lassen Sie `cac:PaymentTerms` ganz weg.
3. Bei deutschen Rechnungen mit Skonto: Jede Skontozeile beginnt mit `#`, und nach der letzten folgt ein Zeilenumbruch (Regel BR-DE-18).

**Vorher (ab 24.02.2027 abgelehnt)**

```xml
<cac:PaymentTerms>
  <cbc:Note>Zahlbar innerhalb von 30 Tagen.</cbc:Note>
  <cbc:Note>#SKONTO#TAGE=14#PROZENT=2.00#</cbc:Note>
</cac:PaymentTerms>
```

**Nachher**

```xml
<cac:PaymentTerms>
  <cbc:Note>Zahlbar innerhalb von 30 Tagen.
#SKONTO#TAGE=14#PROZENT=2.00#
</cbc:Note>
</cac:PaymentTerms>
```

**Häufig zusammen mit:** BR-DE-18 (Skonto im falschen Format), wenn die Skontozeile ohne abschließenden Zeilenumbruch übernommen wird.

## Häufige Fragen

- *Bisher ging es doch mit zwei Notes?* Ja. Die Regel ist neu und gilt ab dem 24. Februar 2027.
- *Betrifft das auch den Freitext der Rechnung?* Nein. Ein `cbc:Note` direkt unter der Rechnung ist BT-22 und fällt nicht unter diese Regel.

Hinweis: Unser Prüfwerkzeug prüft diese Regel derzeit nicht.
