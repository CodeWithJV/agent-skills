---
name: call-external-ai
description: Call external AI CLIs like Codex and Gemini for second opinions, reviews, and alternative perspectives using natural language requests.
---

# External AI Skill

Invoke external AI CLI tools using natural language.

## When to Use

Activate when the user:
- Says `/call`, `/codex`, or `/gemini`
- Asks for a second opinion from another AI
- Wants external review of code or design
- Needs verification from a different model

## Instructions

### Natural Language Interface

Users provide natural language. Translate it into CLI commands.

Examples:
- "review my changes" -> `codex review --uncommitted`
- "review against main with high reasoning" -> `codex review --base main -c model_reasoning_effort="high"`
- "check this file for bugs" -> `codex exec "Review for bugs: $(cat file.ts)"`
- "give me a second opinion" -> `gemini "Second opinion on..."`

### Self-Healing Behavior

#### On CLI Syntax Errors
1. Run `<cli> --help` to get the current syntax
2. Update the reference docs at `reference/cli-reference.md`
3. Retry with the correct syntax
4. Inform the user of the fix

#### On Upgrade Available
1. Run the upgrade command
2. Update the version in `reference/cli-reference.md`
3. Re-run `--help` to capture new options
4. Inform the user of the upgrade

#### On Gemini 403 Project/License Errors
If Gemini fails with `403` and messages like `lack a Gemini Code Assist license` or `(#3501)`:
1. Check project env vars: `env | rg "GOOGLE|GCP|CLOUDSDK|PROJECT"`
2. Retry with project vars unset:
   - `env -u GOOGLE_CLOUD_PROJECT_ID -u GOOGLE_CLOUD_PROJECT -u CLOUDSDK_CORE_PROJECT gemini ...`
3. If still blocked, report auth/licensing clearly and continue with other available models
4. Record the fix path in `reference/cli-reference.md`

#### On Gemini ModelNotFound / Capacity Errors
If Gemini fails with `404` or `429` style model/capacity issues, retry with this fallback order:
1. `gemini-3.1-pro-preview`
2. `gemini-3-pro-preview`
3. `gemini-3-flash-preview`
4. `gemini-2.5-pro`
5. `gemini-2.5-flash`

### Command Interface

```bash
/call [codex|gemini] <natural language request>
/codex <natural language request>
/gemini <natural language request>
```

### Translation Guidance

#### Codex
- Prefer `codex review` for git-aware reviews
- Use `codex exec` for custom prompts
- Default to high reasoning for reviews when helpful
- Use `--full-auto` only for simple, low-risk tasks

#### Gemini
- Prefer preview model IDs first
- For 403 auth issues, retry with project env vars unset
- For 404/429 failures, continue through the fallback sequence automatically

### Context Gathering

When a request needs context, gather it before invoking the external CLI:
- "review my changes" -> inspect uncommitted changes
- "review this file" -> read the file
- "review the dev skill" -> gather the skill files
- "check my implementation" -> identify the relevant files

### Process Flow

1. Parse the natural language request
2. Determine the target CLI (`codex` or `gemini`)
3. Translate to the appropriate CLI command
4. Execute the command
5. If syntax error -> self-heal and retry
6. If upgrade available -> upgrade and refresh references
7. Return the results to the user
