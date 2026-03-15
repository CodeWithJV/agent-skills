# Review Context Hub Checklist

Use these as lightweight primitives during the review.

## Repo outline

```bash
pwd
find . -maxdepth 2 -type d | sort
rg --files . | sed -n '1,200p'
```

## Git state

```bash
git branch --show-current
git status --short
git log --oneline -10
git remote -v
```

## Standing instruction files

```bash
find . -name 'CLAUDE.md' -o -name 'AGENTS.md' -o -name 'GEMINI.md'
```

## Skills

```bash
find .claude/skills .codex/skills .gemini/skills -name 'SKILL.md' 2>/dev/null
```

## GitHub repo visibility / ownership

```bash
gh repo view --json owner,name,isPrivate,url,defaultBranchRef
```

## Collaborators / access

This may require repo admin access:

```bash
gh api repos/{owner}/{repo}/collaborators
```

If this fails, report that access could not be verified directly.
