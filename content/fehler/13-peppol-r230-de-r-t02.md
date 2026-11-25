slug: peppol-r230-de-r-t02
nav: R230 / DE-R-T02
title: R230 / DE-R-T02: Link zum Anhang (BT-124) fehlt oder falsch
description: R230/DE-R-T02: Ein externer Anhang braucht genau eine URI; bei Rechnungen zwischen deutschen Firmen eine absolute URL wie https://…
h1: PEPPOL-EN16931-R230 / DE-R-T02: Link zum Anhang (BT-124) fehlt oder falsch
meldung: [PEPPOL-EN16931-R230]-ubl-invoice:Invoice/cac:AdditionalDocumentReference/cac:Attachment/cac:ExternalReference MUST contain exactly one cbc:URI. · [DE-R-T02]-If both supplier and customer are located in Germany, BT-124 "External document location" MUST contain an absolute URL with valid scheme.
detects: link-only

*Deutsch (unsere Übersetzung, kein Originaltext):* Ein externer Anhang braucht genau einen Link (R230). Sitzen Verkäufer und Käufer in Deutschland, muss der Link eine vollständige Adresse mit Schema sein, zum Beispiel `https://` (DE-R-T02).

**Kurz erklärt.** Mit BT-124 verweisen Sie auf ein Dokument, das nicht in der Rechnung steckt, zum Beispiel einen Leistungsnachweis auf Ihrem Server. Ab dem 24. Februar 2027 sind dabei zwei Fehler fatal: ein `cac:ExternalReference` ohne `cbc:URI` und, bei rein deutschen Rechnungen, ein Link ohne Schema. DE-R-T02 war bisher nur eine Warnung.

{{PEPPOL-2026-11}}

**Was die Regel genau prüft.** R230 zählt `cbc:URI` in jedem `cac:ExternalReference`: genau eins. DE-R-T02 prüft, ob der Wert mit einem Schema wie `https:` beginnt (Buchstabe, dann mindestens ein weiteres Zeichen aus Buchstaben, Ziffern, `+`, `.`, `-`, dann ein Doppelpunkt). Ob der Link erreichbar ist, prüft keine der beiden Regeln.

## Typische Ursachen

- Nur der Dateiname steht im Feld (`leistungsnachweis.pdf`).
- Der Link beginnt mit `www.` statt mit `https://`.
- Das Programm erzeugt `cac:ExternalReference` auch ohne hinterlegten Link.

## So beheben Sie es

1. Tragen Sie die vollständige Adresse ein, beginnend mit `https://`.
2. Ohne Link lassen Sie `cac:ExternalReference` ganz weg.
3. Soll das Dokument mitreisen, betten Sie es stattdessen ein (`cbc:EmbeddedDocumentBinaryObject`).

**Vorher (ab 24.02.2027 abgelehnt)**

```xml
<cac:Attachment>
  <cac:ExternalReference>
    <cbc:URI>www.muster.de/nachweise/2026-117.pdf</cbc:URI>
  </cac:ExternalReference>
</cac:Attachment>
```

**Nachher**

```xml
<cac:Attachment>
  <cac:ExternalReference>
    <cbc:URI>https://www.muster.de/nachweise/2026-117.pdf</cbc:URI>
  </cac:ExternalReference>
</cac:Attachment>
```

**Häufig zusammen mit:** DE-R-022 (Anhänge brauchen eindeutige Dateinamen) und PEPPOL-EN16931-R008 (leere Elemente).

## Häufige Fragen

- *Gilt DE-R-T02 auch für Rechnungen ins Ausland?* Nein, nur wenn Verkäufer und Käufer in Deutschland sitzen. R230 gilt immer.
- *Reicht ein Link auf einen internen Server?* Für die Regel ja, solange er ein Schema hat. Ob Ihr Empfänger ihn öffnen kann, ist eine andere Frage.

Hinweis: Unser Prüfwerkzeug prüft diese Regeln derzeit nicht.
