slug: br-de-2
nav: BR-DE-2
title: BR-DE-2: Kontaktdaten des Verkäufers (BG-6) fehlen in der XRechnung
description: BR-DE-2: In Ihrer XRechnung fehlt der Block mit den Kontaktdaten des Verkäufers (BG-6). Was hineingehört und wo er im XML steht.
h1: BR-DE-2: Kontaktdaten des Verkäufers (BG-6) fehlen
meldung: [BR-DE-2] Die Gruppe "SELLER CONTACT" (BG-6) muss übermittelt werden.
detects: yes

**Kurz erklärt.** XRechnung verlangt, dass der Verkäufer einen Ansprechpartner nennt. In der europäischen Norm EN 16931 ist dieser Block freiwillig, das deutsche Regelwerk macht ihn zur Pflicht. Fehlt er ganz, lehnt der Validator die Rechnung ab.

**Was die Regel genau prüft.** Im UBL-Format muss unter `cac:AccountingSupplierParty/cac:Party` ein Element `cac:Contact` stehen. Was darin stehen muss, prüfen drei weitere Regeln: BR-DE-5 (Name oder Abteilung), BR-DE-6 (Telefon) und BR-DE-7 (E-Mail). Fehlt `cac:Contact` ganz, erscheint nur BR-DE-2.

## Typische Ursachen

- In den Firmendaten des Programms ist kein Ansprechpartner für Rechnungen hinterlegt.
- Telefon und E-Mail stehen nur im Briefkopf des PDF, nicht im XML.
- Ein Export-Plugin erzeugt EN 16931 ohne die deutschen Zusatzregeln.
- Der Kontakt steht beim Käufer (`cac:AccountingCustomerParty`) statt beim Verkäufer.

## So beheben Sie es

1. Hinterlegen Sie in den Firmendaten einen Ansprechpartner für Rechnungsfragen: Name oder Abteilung, Telefonnummer und E-Mail-Adresse.
2. Prüfen Sie, ob Ihr Programm einen Export „XRechnung“ anbietet und nicht nur „EN 16931“ oder „ZUGFeRD“.
3. Erzeugen Sie die Rechnung neu und prüfen Sie, ob `cac:Contact` unter dem Verkäufer steht.

**Vorher (abgelehnt):** kein `cac:Contact` beim Verkäufer.

```xml
<cac:AccountingSupplierParty>
  <cac:Party>
    <cbc:EndpointID schemeID="EM">rechnung@muster.de</cbc:EndpointID>
    <cac:PostalAddress>…</cac:PostalAddress>
    <cac:PartyTaxScheme>…</cac:PartyTaxScheme>
    <cac:PartyLegalEntity>
      <cbc:RegistrationName>Muster GmbH</cbc:RegistrationName>
    </cac:PartyLegalEntity>
  </cac:Party>
</cac:AccountingSupplierParty>
```

**Nachher**

```xml
<cac:AccountingSupplierParty>
  <cac:Party>
    <cbc:EndpointID schemeID="EM">rechnung@muster.de</cbc:EndpointID>
    <cac:PostalAddress>…</cac:PostalAddress>
    <cac:PartyTaxScheme>…</cac:PartyTaxScheme>
    <cac:PartyLegalEntity>
      <cbc:RegistrationName>Muster GmbH</cbc:RegistrationName>
    </cac:PartyLegalEntity>
    <cac:Contact>
      <cbc:Name>Buchhaltung</cbc:Name>
      <cbc:Telephone>+49 30 1234567</cbc:Telephone>
      <cbc:ElectronicMail>buchhaltung@muster.de</cbc:ElectronicMail>
    </cac:Contact>
  </cac:Party>
</cac:AccountingSupplierParty>
```

Die Reihenfolge ist im UBL-Format fest: `cac:Contact` steht nach `cac:PartyLegalEntity`.

**Häufig zusammen mit:** BR-DE-5, BR-DE-6 und BR-DE-7 (einzelne Kontaktangaben fehlen) und BR-DE-3 / BR-DE-4 (Ort oder Postleitzahl des Verkäufers fehlen).

## Häufige Fragen

- *Reicht die E-Mail-Adresse aus `cbc:EndpointID`?* Nein. Das ist die elektronische Adresse für den Versand (BT-34). Der Kontakt (BG-6) ist ein eigener Block.
- *Muss es eine Person sein?* Nein. Eine Abteilung wie „Buchhaltung“ genügt als Name.
