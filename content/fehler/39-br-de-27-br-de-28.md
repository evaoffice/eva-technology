slug: br-de-27-br-de-28
nav: BR-DE-27 / BR-DE-28
title: BR-DE-27 / BR-DE-28 (Warnung): Telefon oder E-Mail des Verkäufers im falschen Format
description: BR-DE-27 und BR-DE-28 sind Warnungen: Telefonnummer (BT-42) oder E-Mail-Adresse (BT-43) des Verkäufers sehen nicht gültig aus. Was geprüft wird und wie Sie es beheben.
h1: BR-DE-27 / BR-DE-28 (Warnung): Telefon oder E-Mail im falschen Format
meldung: [BR-DE-27] In BT-42 sollen mindestens drei Ziffern enthalten sein. · [BR-DE-28] In BT-43 soll genau ein @-Zeichen enthalten sein, welches nicht von einem Leerzeichen, einem Punkt, aber mindestens zwei Zeichen auf beiden Seiten flankiert werden soll. Ein Punkt sollte nicht am Anfang oder am Ende stehen.
detects: yes

**Kurz erklärt.** Diese Meldungen sind **Warnungen**, keine Fehler. Die Kontaktdaten des Verkäufers sind vorhanden, aber die Telefonnummer oder die E-Mail-Adresse sieht nicht so aus, als könnte man darüber jemanden erreichen. Die Rechnung scheitert daran nicht; der Empfänger sieht die Warnung aber im Prüfbericht.

## Was die Regeln genau prüfen

Beide Regeln gelten für den Kontakt des Verkäufers, also `cac:AccountingSupplierParty/cac:Party/cac:Contact`.

- **BR-DE-27:** `cbc:Telephone` muss mindestens drei Ziffern enthalten. Leerzeichen, `+`, Klammern und Bindestriche sind erlaubt, sie zählen nur nicht als Ziffern.
- **BR-DE-28:** `cbc:ElectronicMail` muss genau ein `@` enthalten, ohne Leerzeichen. Hinter dem `@` muss ein Domainname mit mindestens einem Punkt stehen, und der Punkt darf nicht am Ende stehen.

Die Meldung von BR-DE-28 spricht von „mindestens zwei Zeichen auf beiden Seiten“. Die eigentliche Prüfung im XRechnung-Regelwerk ist großzügiger: Eine Adresse wie `a@b.de` löst die Warnung nicht aus.

Fehlt die Telefonnummer oder die E-Mail-Adresse ganz, meldet der Validator BR-DE-6 oder BR-DE-7 als Fehler und zusätzlich BR-DE-27 oder BR-DE-28 als Warnung.

## Typische Ursachen

- Im Feld für die Telefonnummer steht ein Text wie „siehe Website“ oder nur eine Durchwahl wie „12“.
- Die E-Mail-Adresse enthält ein Leerzeichen, zum Beispiel vor dem `@`.
- Im Feld stehen zwei Adressen, getrennt durch Komma oder Semikolon.
- Statt einer E-Mail-Adresse steht eine Internetadresse wie `www.muster.de` im Feld.

## So beheben Sie es

1. Tragen Sie in den Firmendaten eine vollständige Telefonnummer ein, am besten mit Vorwahl, zum Beispiel `+49 30 1234567`.
2. Tragen Sie genau eine E-Mail-Adresse ein, ohne Leerzeichen und ohne Zusätze.
3. Erzeugen Sie die Rechnung neu und prüfen Sie sie erneut.

**Vorher (Warnung):** Durchwahl statt Telefonnummer, Leerzeichen in der E-Mail-Adresse.

```xml
<cac:Contact>
  <cbc:Name>Buchhaltung</cbc:Name>
  <cbc:Telephone>12</cbc:Telephone>
  <cbc:ElectronicMail>buchhaltung @muster.de</cbc:ElectronicMail>
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

**Häufig zusammen mit:** BR-DE-5, BR-DE-6 und BR-DE-7 (Name, Telefon oder E-Mail fehlen ganz) und BR-DE-2 (Kontaktblock fehlt).

## Häufige Fragen

- *Muss ich die Warnung beheben?* Die Rechnung scheitert daran nicht. Eine Telefonnummer oder E-Mail-Adresse, über die niemand erreichbar ist, führt aber oft zu Rückfragen.
- *Darf ich zwei E-Mail-Adressen angeben?* Nein. Das Feld nimmt genau eine Adresse auf; mit zwei Adressen erscheint BR-DE-28.
