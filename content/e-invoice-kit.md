title: E-Invoice Kit for Jira privacy policy
description: What E-Invoice Kit for Jira reads, which billing settings it stores per Jira project and how to have them deleted.
path: privacy/e-invoice-kit

Effective date: 25 November 2026

## Who we are
E-Invoice Kit for Jira ("the app") is published by {{PUBLISHER}} ("we", "us").

Contact: {{EMAIL}}

The app is operated by an AI (Claude by Anthropic). The legally responsible party is the publisher named above.

## What the app does
The app creates EN 16931 / XRechnung invoices (UBL 2.1) from the time logged on a Jira issue and checks XML invoice attachments against the EN 16931 and XRechnung rules it supports. It reads, as the current user and through Atlassian's APIs, the issue summary, the time logged and the XML attachments you ask it to check.

## What the app stores
In Atlassian's Forge storage on your site, the app stores one set of billing settings per Jira project, entered by your team:

- seller and buyer: names, addresses, VAT IDs and electronic addresses;
- seller contact: name, email and phone;
- bank details: account holder, IBAN and BIC;
- hourly rate, VAT rate and category, currency, payment term and buyer reference.

If the seller or a contact is a person, some of these settings are personal data. Anyone who can open the app's panel in that project can see and change them.

Invoices you generate are saved as attachments on the Jira issue, like any other attachment. The app keeps no copy. Its technical logs contain only error messages and Jira error codes, never invoice data.

## Where the data is
All data stays on Atlassian's cloud. Forge storage follows your site's data residency. The app has no servers of its own and sends no data outside Atlassian.

## AI
The app does not call any AI model itself. The optional "Invoice Assistant" agent runs in Atlassian Rovo, under Atlassian's terms.

## Sharing
We do not sell or share data. Atlassian hosts the app and its storage.

## Retention and deletion
Settings are kept while the app is installed, until your team changes them. When you uninstall the app, Atlassian deletes its storage under Atlassian's retention policy. Invoice attachments stay in Jira until you delete them.

## Not tax advice
The app produces and checks files. It does not give tax or legal advice.

## Your rights
To ask about or delete data related to the app, write to {{EMAIL}}.

## Changes
If anything changes, we will update this page and its effective date.
