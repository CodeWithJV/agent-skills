# Changelog

## Unreleased

- Add an Antigravity plugin package with the published `plugin.json` layout.
- Package `retro` and `extract-scripts` for Antigravity under `plugins/antigravity-codewithjv`.
- Document Antigravity install and invocation paths.
- Add `plan-website`, `build-website`, and `deploy-website` - a chained skillset that walks a non-technical user from an idea to a live site on Netlify or Vercel.
- Ship the new website skills as root skill folders (`npx skills add`) and package them into all three `codewithjv` plugin variants (Claude Code, Codex, Antigravity).

## 1.0.1 - 2026-06-10

- Add Claude and Codex marketplace files for GitHub-based distribution.
- Replace plugin skill symlinks with copied skill directories so installed plugin caches are self-contained.

## 1.0.0 - 2026-06-10

- Add the first formal `codewithjv` plugin packages for Claude Code and Codex.
- Ship `retro` for task retrospectives and durable workflow improvements.
- Ship `extract-scripts` for splitting deterministic skill steps into portable shell scripts.
- Keep the existing root skill folders available for direct `npx skills add` installs.
