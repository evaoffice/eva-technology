title: Team Load Radar for Jira privacy policy
description: What Team Load Radar for Jira reads to show work in progress per person, the two settings and the log it stores, and how to have them deleted.
path: privacy/team-load-radar

Effective date: 25 November 2026

## Who we are
Team Load Radar for Jira ("the app") is published by {{PUBLISHER}} ("we", "us").

Contact: {{EMAIL}}

The app is operated by an AI (Claude by Anthropic). The legally responsible party is the publisher named above.

## What the app does
The app shows how much work each person has in progress across all Jira projects, for the people of a Jira project or of an Atlassian team (teams and their members come from Atlassian's Teamwork Graph). "Show work" lists a person's open work items. A Jira admin sets one personal limit and the number of days after which work counts as stale.

On the workflows where an admin adds its validator, the app blocks a move to "In Progress" when the assignee is already at the limit. Its Rovo agent, Load Coach, says who is over the limit and who has capacity, previews a reassignment, makes it only after the user confirms it, and refuses it when the new assignee would go over the limit.

To do this the app reads, through Atlassian's APIs and as the user who is looking, the people in the project or team (account ID and display name), and the work items assigned to them and their status. It also asks the Teamwork Graph how many pull requests are waiting for each person's review; when the graph returns none (as on sites with no code tool connected, including our own test site), the page says that reviews are not shown. The workflow check runs as the app, reads only work-in-progress counts and writes nothing to Jira. A reassignment is made as the user who approved it and appears in the work item's history in Jira.

## What the app stores
In Atlassian's Forge storage on your site, the app stores only:

- two settings: the default personal limit and the number of days after which work counts as stale, with the date they were last changed;
- an activity log: one entry for each reassignment made or refused because of the limit, each transition blocked by the limit, each change of the settings and each time the log is cleared, with the date and time, the action, the work item key (when there is one) and the result;
- the date of the last automatic clean-up of the log.

The app does **not** store names, account IDs, email addresses, team membership, pull request data or any text from work items. Workload figures are calculated each time the page or the agent asks for them and are not kept. The log keeps at most 500 entries and nothing older than 90 days, and a Jira admin can delete it with "Clear log" on the app's admin page.

The app's technical logs on Forge record only which action ran and whether it worked, plus a short error reason when the Teamwork Graph does not answer.

## Where the data is
All data stays on Atlassian's cloud, in Forge storage, which follows your site's data residency. The app has no servers of its own and sends no data outside Atlassian.

## AI
The app does not call any AI model itself. The optional "Load Coach" agent runs in Atlassian Rovo, under Atlassian's terms.

## Sharing
We do not sell or share data. Atlassian hosts the app and its storage.

## Retention and deletion
Settings are kept while the app is installed. Log entries are deleted automatically after 90 days, when the log exceeds 500 entries, or when an admin uses "Clear log". When you uninstall the app, Atlassian deletes its storage under Atlassian's retention policy. Reassignments stay in Jira's own history.

## Your rights
To ask about or delete data related to the app, write to {{EMAIL}}. Data held in Jira itself (work items, assignees, history) is managed by your organisation and Atlassian.

## Changes
If anything changes, we will update this page and its effective date.
