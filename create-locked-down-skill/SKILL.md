---
name: create-locked-down-skill
description: Create a restricted workflow directory with locked-down Claude permissions. Use when asked to set up a new workflow, create a sandboxed workspace, restrict permissions for a task, or scaffold a locked-down skill.
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Glob
  - Grep
---

# Create Locked-Down Workflow

**This skill is Claude Code-specific.** The `.claude/settings.local.json` permission system only works with Claude Code. If you are a different agent (Codex, Gemini, etc.), stop here — this approach won't restrict your permissions. Use your own agent's sandboxing or permission model instead.

Scaffold a new workflow directory with a `.claude/settings.local.json` that restricts permissions to only what's needed, plus a `CLAUDE.md` with workflow instructions.

## When to Use

- User asks to "create a workflow for X"
- User wants a restricted/sandboxed workspace
- User says "set up a new input skill"
- User wants to lock down permissions for a specific task

## Workflow

### Step 1: Gather Requirements

Ask the user for:

1. **Name** — what to call the workflow (becomes the directory name under `workflows/`)
2. **Purpose** — what the workflow does (becomes the CLAUDE.md content)
3. **Allowed tools** — which tools should be permitted. Common sets:
   - **Research**: `WebSearch`, `WebFetch`, scoped `Read`/`Glob`/`Grep`
   - **Writing**: scoped `Read`/`Glob`/`Grep` (+ scoped `Write`/`Edit`)
   - **Analysis**: scoped `Read`/`Glob`/`Grep`, `Bash` (read-only commands)
4. **Write paths** — which directories the workflow can write to. Always includes its own directory. Ask if it should also write elsewhere (e.g., a project-level output folder).
5. **Source content** — an existing skill, CLAUDE.md, or instructions to embed. If the user points to an existing skill, adapt it for the workflow context.

### Step 2: Create Directory Structure

```
workflows/<name>/
├── .claude/
│   └── settings.local.json    # Locked-down permissions
└── CLAUDE.md                   # Workflow instructions
```

### Step 3: Build settings.local.json

The permissions file follows this pattern:

```json
{
  "permissions": {
    "allow": [
      // Task-specific tools
      "WebSearch",
      "WebFetch",
      // Scoped read access — to workflow dir, output dir, and .claude
      "Read(workflows/<name>/**)",
      "Read(<output-path>/**)",
      "Read(.claude/**)",
      "Glob(workflows/<name>/**)",
      "Glob(<output-path>/**)",
      "Grep(workflows/<name>/**)",
      "Grep(<output-path>/**)",
      // Scoped write access — ONLY to designated paths
      "Write(workflows/<name>/**)",
      "Edit(workflows/<name>/**)",
      "Write(<output-path>/**)",
      "Edit(<output-path>/**)"
    ],
    "deny": [
      // Block everything dangerous by default
      "Bash",
      "Agent",
      "Skill",
      "NotebookEdit",
      // General write/edit/read (scoped allows override for designated paths)
      "Write(**)",
      "Edit(**)",
      "Read(**)",
      "Glob(**)",
      "Grep(**)"
    ]
  }
}
```

**Rules for building permissions:**

- **Default deny everything**, then allowlist specific tools
- **Always deny** `Bash`, `Agent`, `Skill`, `NotebookEdit` unless explicitly requested
- **Scope all file access** using glob patterns — even read-only tools (`Read`, `Glob`, `Grep`) should be scoped to only the paths the workflow needs
- **Always include** `Read(.claude/**)` so the workflow can read Claude settings/instructions
- **Scope writes** using glob patterns: `Write(path/**)` and `Edit(path/**)`
- **All paths are relative** to the project root
- The general `Write(**)`/`Edit(**)`/`Read(**)`/`Glob(**)`/`Grep(**)` in deny act as catch-alls; scoped allows in the allow list override them for specific paths
- **Write scoping trick**: To allow writes only to specific folders, use `Write(./**)` (current dir) in allow and `Write(**)` in deny. The deny catches everything, then the scoped allow punches a hole for just the paths you want. Same pattern applies to `Edit`, `Read`, `Glob`, `Grep`.
- If the user needs Bash, only allow specific commands: `Bash(command-pattern:*)`

### Step 4: Write CLAUDE.md

The CLAUDE.md should contain:

1. **Title and purpose** of the workflow
2. **When to use** — trigger phrases
3. **Output structure** — where files go
4. **Step-by-step instructions** — the actual workflow phases
5. **Templates** — for any output artifacts
6. **Quality checklist** — completion criteria

If adapting from an existing skill:
- Copy the core workflow content
- Update all output paths to match the new directory structure
- Remove references to tools that aren't allowed
- Add path references for both the working directory and any output directories

### Step 5: Confirm with User

Before writing files, show the user:
- The directory that will be created
- The permissions summary (what's allowed, what's denied)
- The write paths
- A brief outline of the CLAUDE.md content

## Example

User: "create a research workflow that can only search the web and write to its own folder and ./research"

Result:
```
workflows/research/
├── .claude/settings.local.json   # WebSearch, WebFetch, Read, Glob, Grep + scoped Write/Edit
└── CLAUDE.md                      # Research workflow phases, templates, checklist
```

Permissions:
- Allow: WebSearch, WebFetch, scoped Read/Glob/Grep to `workflows/research/**`, `research/**`, and `.claude/**`, scoped Write/Edit to `workflows/research/**` and `research/**`
- Deny: Bash, Agent, Skill, NotebookEdit, general Read, Glob, Grep, Write, Edit
