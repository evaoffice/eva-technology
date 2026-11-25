title: Support
description: How to get help with Desk Tools MCP, E-Invoice Kit for Jira and Team Load Radar for Jira: contact, what to include and answers to common questions.
path: support
lead: For Desk Tools MCP, E-Invoice Kit for Jira and Team Load Radar for Jira.
toc: yes

Support is provided by an AI (Claude by Anthropic). The legally responsible party is the publisher named on this page: {{PUBLISHER}}.

## Contact
Email: {{EMAIL}} (support is by email only)

We reply the same business day (Monday to Friday). Security reports: write "Security" in the subject line.

## What to include
- your Atlassian site URL and the app name;
- the request or issue key;
- what you did, what you expected and what happened (a screenshot helps);
- Desk Tools MCP: the matching line of the log on the admin page;
- E-Invoice Kit: the rule ID shown (for example BR-CO-15);
- Team Load Radar: the project or team you selected and the summary line shown on the page.

Please do not send passwords, API tokens or real invoices with personal or bank data.

## Price and service level
All three apps are free. Support is provided on a best-effort basis, without a guaranteed service level.

## Questions about Desk Tools MCP

### Can the AI agent write to my customers by mistake?
Customer replies are off by default. While they are off, the reply tool refuses, records the blocked attempt and tells you where an admin can switch it on (Jira settings → Apps → Desk Tools MCP). Internal notes are read back from Jira after writing to confirm they are internal.

### Where can I see what the app did?
On the admin page (Jira settings → Apps → Desk Tools MCP): each write or blocked attempt with time, tool, request, comment and confirmed visibility. "Clear log" deletes it.

### Does the app store my comments or my users?
No. The log has no names, account IDs or comment text. It keeps at most 500 entries for up to 90 days.

### Can it read forms?
Yes. It lists the forms on a request with their answers and says whether each form is internal or visible to the customer.

### Do I need Rovo?
The agent and the tools run through Rovo. Without Rovo you can still open the admin page and see the setting and the log.

## Questions about E-Invoice Kit

### Which formats does it produce?
UBL 2.1 invoices following EN 16931 / XRechnung. The invoices it generates pass the official KoSIT validator 1.6.3 (XRechnung 3.0.2). ZUGFeRD, CII and credit notes are not supported.

### Where do the invoice lines come from?
From the time logged on the issue, multiplied by the hourly rate in the project's billing settings.

### Why does it say my settings are missing?
Settings are per project. Open the E-Invoice Kit panel on any issue of the project and fill in the Settings tab ("Load sample data" shows an example).

### How can I see what an error looks like?
In the Validate tab, "Attach sample with errors" adds a broken example invoice to the issue. Validate it to see each failed rule with its explanation.

### Does "No errors found" mean my customer will accept the invoice?
It means the file meets the EN 16931 / XRechnung rules the app checks. A receiver can still apply its own requirements.

### Is my bank data safe?
It is stored only in Forge storage on Atlassian's infrastructure and never leaves Atlassian. Anyone who can open the panel in that project can see it.

### Is this tax advice?
No. The app produces and checks files; ask your tax adviser about tax questions.

## Questions about Team Load Radar

### What does the "Open" column count?
Every work item assigned to the person that is not done, counted by Jira. A dash means Jira did not return the count for that person.

### How do I block work over the limit?
In the workflow editor, select the transition that leads to an "In Progress" status, add a rule of type "Validate details" and choose "Personal WIP limit (Team Load Radar)". The limit applies only on the workflows where you add it. If the app cannot check, the transition is allowed.

### Why can't I see some people's work?
The page counts work with your Jira permissions. Work items you cannot see in Jira are not counted for you.

### Where are the people with no open work?
They are folded under "Show N people with no open work" below the table, so the table starts with the people who have work.

### Does the app store who is overloaded?
No. Workload is calculated each time you open the page and is not kept. The app stores only its two settings and a short log without names.

### Why does the page take a while on large projects?
It counts each person's work across all projects. On our test site the page loads in under 9 seconds for a team of 10 people.
