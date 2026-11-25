title: Desk Tools MCP privacy policy
description: What Desk Tools MCP for Jira Service Management reads, what it stores in Atlassian Forge storage and how to have it deleted.
path: privacy/desk-tools-mcp

Effective date: 25 November 2026

## Who we are
Desk Tools MCP ("the app") is published by {{PUBLISHER}} ("we", "us").

Contact: {{EMAIL}}

The app is operated by an AI (Claude by Anthropic). The legally responsible party is the publisher named above.

## What the app does
The app gives AI agents (Atlassian Rovo, or an MCP client you connect through Atlassian) five tools for Jira Service Management: read a request's conversation, read its forms, check a comment's visibility, add an internal note, and send a customer reply. Customer replies are switched off by default; only a Jira admin can switch them on.

The app reads requests, comments and forms through Atlassian's APIs, as the user who asked, and only for the request in question. After every write it reads the comment back from Jira to confirm its visibility.

## What the app stores
In Atlassian's Forge storage on your site, the app stores only:

- the customer-reply setting (on or off) and the date and time it was last changed;
- a technical log of each write or blocked attempt: date and time, tool name, request key, comment ID, the visibility requested, the visibility Jira saved, and the result.

The log does **not** contain any personal data: no user names, account IDs or email addresses, and no text of comments, notes or forms. It keeps at most 500 entries and nothing older than 90 days. A Jira admin can delete it at any time with "Clear log" on the app's admin page.

The app's technical logs on Forge contain only the tool name and error codes.

## Where the data is
All data stays on Atlassian's cloud, in Forge storage, which follows your site's data residency. The app has no servers of its own and sends no data outside Atlassian.

## AI
The app does not call any AI model itself. AI features run in Atlassian Rovo or in the MCP client you choose, under their own terms.

## Sharing
We do not sell or share data. Atlassian hosts the app and its storage.

## Retention and deletion
The setting is kept while the app is installed. Log entries are deleted automatically after 90 days, when the log exceeds 500 entries, or when an admin uses "Clear log". When you uninstall the app, Atlassian deletes its storage under Atlassian's retention policy.

## Your rights
To ask about or delete data related to the app, write to {{EMAIL}}. Data held in Jira itself (requests, comments, forms) is managed by your organisation and Atlassian.

## Changes
If anything changes, we will update this page and its effective date.
