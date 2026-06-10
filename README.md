# Code With JV Agent Skills

Shared reusable agent skills for the Code With JV cohort.

These skills are designed to be readable, editable, and easy to install from a shared repo.

## Code With JV plugin

The formal plugin namespace is `codewithjv`.

Initial plugin skills:

- `retro` - run a retrospective on a task or chat history to find mistakes, inefficiencies, root causes, and durable improvements.
- `extract-scripts` - review a skill and extract deterministic, mechanical steps into portable shell scripts.

Claude Code invocations:

```text
/codewithjv:retro
/codewithjv:extract-scripts
```

Codex invocations:

```text
@codewithjv retro
@codewithjv extract-scripts
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

It uses the `codewithjv` namespace and exposes the same two skills from this repo.

Add this repo as a Codex marketplace:

```bash
codex plugin marketplace add CodeWithJV/agent-skills
```

Then open the Codex plugin directory and install `codewithjv` from the Code With JV marketplace.

Validate before release:

```bash
python3 ~/.codex/skills/.system/plugin-creator/scripts/validate_plugin.py ./plugins/codex-codewithjv
```

## Included skills

- `automation-hitlist`
- `call-external-ai`
- `create-locked-down-skill`
- `extract-scripts`
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
