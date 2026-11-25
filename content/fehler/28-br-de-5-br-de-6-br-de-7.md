slug: br-de-5-br-de-6-br-de-7
nav: BR-DE-5 / BR-DE-6 / BR-DE-7
title: BR-DE-5, BR-DE-6, BR-DE-7: Ansprechpartner, Telefon oder E-Mail fehlt
description: BR-DE-5 bis BR-DE-7: Im Kontakt des Verkäufers fehlen Name, Telefonnummer oder E-Mail-Adresse. Welche Felder XRechnung verlangt und wie Sie sie füllen.
h1: BR-DE-5 / BR-DE-6 / BR-DE-7: Ansprechpartner, Telefon oder E-Mail fehlt
meldung: [BR-DE-5] Das Element "Seller contact point" (BT-41) muss übermittelt werden. · [BR-DE-6] Das Element "Seller contact telephone number" (BT-42) muss übermittelt werden. · [BR-DE-7] Das Element "Seller contact email address" (BT-43) muss übermittelt werden.
detects: yes

**Kurz erklärt.** Steht der Kontakt des Verkäufers in der Rechnung, muss er bei XRechnung vollständig sein: ein Name oder eine Abteilung, eine Telefonnummer und eine E-Mail-Adresse. Fehlt eine der drei Angaben, lehnt der Validator die Rechnung ab.

## Was die Regeln genau prüfen

- **BR-DE-5:** In `cac:AccountingSupplierParty/cac:Party/cac:Contact` muss `cbc:Name` stehen und darf nicht leer sein.
- **BR-DE-6:** Im selben Block muss `cbc:Telephone` gefüllt sein.
- **BR-DE-7:** Im selben Block muss `cbc:ElectronicMail` gefüllt sein.

Die drei Regeln greifen nur, wenn `cac:Contact` vorhanden ist. Fehlt der Block ganz, meldet der Validator BR-DE-2. Zusätzlich gibt es zwei Warnungen zum Format: BR-DE-27 (die Telefonnummer soll mindestens drei Ziffern enthalten) und BR-DE-28 (die E-Mail-Adresse soll genau ein @ enthalten).

## Typische Ursachen

- Im Programm ist nur eine Telefonnummer hinterlegt, aber keine E-Mail-Adresse für Rechnungsfragen (oder umgekehrt).
- Das Feld für den Ansprechpartner bleibt leer, weil die Rechnung von einem Sammelpostfach kommt.
- Das Programm schreibt leere Elemente wie `<cbc:Telephone/>`; ein leeres Element zählt als fehlend.

## So beheben Sie es

1. Tragen Sie in den Firmendaten einen Namen oder eine Abteilung ein, zum Beispiel „Buchhaltung“.
2. Ergänzen Sie eine Telefonnummer und eine E-Mail-Adresse, unter denen Rechnungsfragen beantwortet werden.
3. Erzeugen Sie die Rechnung neu und prüfen Sie, dass keines der drei Elemente leer ist.

**Vorher (abgelehnt):** Telefon leer, E-Mail fehlt.

```xml
<cac:Contact>
  <cbc:Name>Buchhaltung</cbc:Name>
  <cbc:Telephone></cbc:Telephone>
</cac:Contact>
```

**Nachher**

```xml
<cac:Contact>
  <cbc:Name>Buchhaltung</cbc:Name>
  <cbc:Telephone>+49 30 1234567</cbc:Telephone>
  <cbc:ElectronicMail>buchhaltung@muster.de</cbc:ElectronicMail>
</cac:Contact>
```

**Häufig zusammen mit:** BR-DE-2 (Kontaktblock fehlt ganz), BR-DE-27 und BR-DE-28 (Format von Telefon und E-Mail, als Warnung).

## Häufige Fragen

- *Darf ich eine allgemeine Telefonnummer angeben?* Ja. XRechnung verlangt eine Nummer, unter der Rechnungsfragen ankommen; eine Durchwahl ist nicht nötig.
- *Gilt das auch für den Käufer?* Nein. Die Kontaktdaten des Käufers sind in XRechnung freiwillig.
