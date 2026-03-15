# Code With JV Agent Skills

Shared reusable agent skills for the Code With JV cohort.

These skills are designed to be readable, editable, and easy to install from a shared repo.

## Included skills

- `call-external-ai`
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
```

## What these are for

- `call-external-ai`
  Call Codex or Gemini for second opinions, reviews, and alternative perspectives.
- `review-context-hub`
  Review a repo as a context hub: structure, recent changes, instructions, skills, remotes, and access.
- `retro`
  Run a retrospective on a task or chat history to find mistakes, inefficiencies, root causes, and durable improvements.
