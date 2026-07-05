# Code With JV Agent Skills

Shared reusable agent skills for the Code With JV cohort.

These skills are designed to be readable, editable, and easy to install from a shared repo.

## Code With JV plugin

The formal plugin namespace is `codewithjv`.

Plugin skills:

- `retro` - run a retrospective on a task or chat history to find mistakes, inefficiencies, root causes, and durable improvements.
- `extract-scripts` - review a skill and extract deterministic, mechanical steps into portable shell scripts.
- `plan-website` - interactively plan a website with a non-technical user (goals, existing assets, inspiration, sitemap, copy, visual direction).
- `build-website` - turn a site plan into an actual website, previewed and iterated on section by section.
- `deploy-website` - take a finished website live on Netlify or Vercel.

Claude Code invocations:

```text
/codewithjv:retro
/codewithjv:extract-scripts
/codewithjv:plan-website
/codewithjv:build-website
/codewithjv:deploy-website
```

Codex invocations:

```text
@codewithjv retro
@codewithjv extract-scripts
@codewithjv plan-website
@codewithjv build-website
@codewithjv deploy-website
```

Antigravity invocations:

```text
/retro
/extract-scripts
/plan-website
/build-website
/deploy-website
```

### Claude Code plugin

The Claude Code plugin lives at:

```text
plugins/claude-codewithjv
```

Add this repo as a Claude Code marketplace:

```text
/plugin marketplace add CodeWithJV/agent-skills
/plugin install codewithjv@codewithjv
```

Test locally:

```bash
claude --plugin-dir ./plugins/claude-codewithjv
```

Then invoke:

```text
/codewithjv:retro
/codewithjv:extract-scripts
```

Validate before release:

```bash
claude plugin validate ./plugins/claude-codewithjv
```

### Codex plugin

The Codex plugin lives at:

```text
plugins/codex-codewithjv
```

It uses the `codewithjv` namespace and exposes the same skills from this repo.

Add this repo as a Codex marketplace:

```bash
codex plugin marketplace add CodeWithJV/agent-skills
```

Then open the Codex plugin directory and install `codewithjv` from the Code With JV marketplace.

Validate before release:

```bash
python3 ~/.codex/skills/.system/plugin-creator/scripts/validate_plugin.py ./plugins/codex-codewithjv
```

### Antigravity plugin

The Antigravity plugin lives at:

```text
plugins/antigravity-codewithjv
```

It uses Antigravity's published `plugin.json` package layout and exposes the same skills from this repo.

Install locally with Antigravity CLI:

```bash
agy plugin install ./plugins/antigravity-codewithjv
```

Then invoke the installed skills from the Antigravity prompt:

```text
/retro
/extract-scripts
/plan-website
/build-website
/deploy-website
```

For workspace-level loading without the CLI installer, copy the contents of `plugins/antigravity-codewithjv` to:

```text
.agents/plugins/codewithjv
```

For global Antigravity loading, copy the contents to:

```text
~/.gemini/config/plugins/codewithjv
```

Validate before release:

```bash
agy plugin validate ./plugins/antigravity-codewithjv
```

## Included skills

- `automation-hitlist`
- `build-website`
- `call-external-ai`
- `create-locked-down-skill`
- `deploy-website`
- `extract-scripts`
- `plan-website`
- `review-context-hub`
- `retro`

## Install

List available skills:

```bash
npx skills add codewithjv/agent-skills --list
```

Install a specific skill:

```bash
npx skills add codewithjv/agent-skills --skill call-external-ai
```

Examples:

```bash
npx skills add codewithjv/agent-skills --skill review-context-hub
npx skills add codewithjv/agent-skills --skill retro
npx skills add codewithjv/agent-skills --skill create-locked-down-skill
npx skills add codewithjv/agent-skills --skill extract-scripts
npx skills add codewithjv/agent-skills --skill plan-website
npx skills add codewithjv/agent-skills --skill build-website
npx skills add codewithjv/agent-skills --skill deploy-website
```

## What these are for

- `automation-hitlist`
  Interactively walk through the five-step method (map, rank, sketch, evaluate, hitlist) to find your highest-value AI automations, then keep the result as a living document: an automation hitlist (build now) and a learning hitlist (learn next).
- `call-external-ai`
  Call Codex or Gemini for second opinions, reviews, and alternative perspectives.
- `create-locked-down-skill`
  Scaffold a new workflow directory with locked-down permissions. Creates a `.claude/settings.local.json` that restricts tools to only what's needed, plus a `CLAUDE.md` with workflow instructions. Great for sandboxed, restricted workspaces.
- `review-context-hub`
  Review a repo as a context hub: structure, recent changes, instructions, skills, remotes, and access.
- `extract-scripts`
  Review a skill and extract deterministic, mechanical steps into shell scripts. Makes skills more reliable by separating precision work (scripts) from judgment work (AI). Scripts are location-independent and portable.
- `retro`
  Run a retrospective on a task or chat history to find mistakes, inefficiencies, root causes, and durable improvements.
- `plan-website`
  Interactively plan a website with a non-technical user - project snapshot, existing site/brand assets, inspiration sites, sitemap, copy, and visual direction - and write a maintained `website/site-plan.md`. First of three chained skills (plan → build → deploy).
- `build-website`
  Turn a `site-plan.md` into an actual website - hand-authored HTML/CSS/JS or a small static site generator, chosen automatically by complexity - built and previewed section by section via Cowork artifacts.
- `deploy-website`
  Take a finished website live on Netlify or Vercel, picking the easiest available path in (connector, then CLI, then guided drag-and-drop) and walking a non-technical user through account setup, deploy, and verification.
