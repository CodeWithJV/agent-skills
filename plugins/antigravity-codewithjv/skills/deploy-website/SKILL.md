---
name: deploy-website
description: Take a finished website (from build-website, or any existing site folder) live on the internet via Netlify or Vercel - picking the easiest available path in (existing connector, then CLI, then guided drag-and-drop), walking a non-technical user through account setup, deploying, and verifying the live URL. Use whenever the user wants to publish or deploy a website, get a live URL, make a site public, or asks how to host or launch a site - phrases like "put my site online," "deploy this," "get my site a URL," or "how do I make this live." Trigger even if the user isn't sure which host to use or has never deployed anything before.
allowed-tools:
  - Read
  - Bash
  - WebFetch
  - WebSearch
---

# Deploy Website

Get a finished website live on the internet for a non-technical user, with a real URL they can share - without ever asking them to touch a terminal unless that's genuinely the easiest path for them.

This is the last of three chained skills: **plan-website → build-website → deploy-website.** By the time this runs, the site should already exist and be approved by the user; your job is purely getting it live and verified.

## Find the site

Read `website/src/`. If it's missing, ask the user for the folder containing the finished site instead of assuming `build-website` was run in this session.

## Pick a provider

Both Netlify and Vercel are free for a simple static site and give a working URL in minutes - there's no wrong choice for most users here, so don't make them research it.

- If the user already has an account with one (ask, or check for an existing CLI login or connector), use that - switching providers for no reason just adds friction.
- Otherwise, describe both in one plain sentence each and let them pick, or just pick Netlify as a sensible default if they have no preference and say so.

## Get in the easiest way, in this order

1. **An existing Cowork/Claude connector** for Netlify or Vercel, if one is connected - always prefer this, it's the least setup and least error-prone.
2. **The provider's CLI** (`netlify` / `vercel`), if it's already installed or can be installed in the sandbox. This is the most hands-off path once an account exists. CLI flags and login flows change over time - if you're not sure of the current usage, check `--help` or do a quick `WebSearch` rather than relying on stale memory.
3. **Guided drag-and-drop**, if there's no CLI/connector path and the user is uncomfortable with a terminal. Walk them through the provider's web-based deploy (uploading the `website/src/` folder) one step at a time, in plain language, confirming what they see on screen before moving to the next step. See `reference/providers.md` for the general shape of each provider's drag-and-drop flow.

## Account and auth

If the user doesn't have an account, walk them through signing up in plain language ("click X, then Y"). Never ask the user to paste an API token, password, or session cookie into chat - direct them to complete login/auth in their own browser, and only proceed once they confirm they're logged in.

## Deploy, then verify

- Run the deploy and surface the resulting live URL clearly - this is the moment the user has been building toward, make it visible and unambiguous.
- Open or fetch the live URL and confirm it matches what they approved in the build preview. Check for the obvious failure modes: missing images, broken internal links, a blank page. Fix anything broken before calling it done - a "live" site that's broken isn't actually done.

## Explain what happens next

In plain language, before finishing:

- How to redeploy after future edits (re-run this skill, or the one-line command if they're using a CLI).
- That a custom domain is a later, optional step - point them at the provider's domain settings if they ask, but don't force this decision now.
- That the site stays live on its own - no ongoing action needed from them.

## Output

`website/deploy-notes.md` - provider used, the live URL, how to redeploy, and how to point a custom domain at it later.
