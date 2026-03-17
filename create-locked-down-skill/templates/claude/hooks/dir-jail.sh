#!/usr/bin/env bash
# dir-jail.sh — PreToolUse hook for Read/Write/Edit/Glob/Grep.
# Returns explicit allow/deny for EVERY call — never falls through to user prompt.
#
# CUSTOMIZATION:
#   ALLOWED_EXTENSIONS — change the file extension check (line ~100) for your workflow.
#   PROTECTED_FILES    — add config files that should be read-only (line ~108).
#   JAIL_DIR           — override via CLAUDE_JAIL_DIR env var, defaults to $PWD.

set -euo pipefail

if ! command -v jq &>/dev/null; then
  echo "[dir-jail] WARNING: jq not installed, cannot enforce directory jail" >&2
  exit 0
fi

JAIL_DIR="${CLAUDE_JAIL_DIR:-$PWD}"
JAIL_DIR="$(cd "$JAIL_DIR" 2>/dev/null && pwd -P)" || {
  echo "[dir-jail] ERROR: cannot resolve CLAUDE_JAIL_DIR=$JAIL_DIR" >&2
  exit 0
}

INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // empty')

allow() {
  jq -n --arg reason "$1" '{
    "hookSpecificOutput": {
      "hookEventName": "PreToolUse",
      "permissionDecision": "allow",
      "permissionDecisionReason": $reason
    }
  }'
  exit 0
}

deny() {
  jq -n --arg reason "$1" '{
    "hookSpecificOutput": {
      "hookEventName": "PreToolUse",
      "permissionDecision": "deny",
      "permissionDecisionReason": $reason
    }
  }'
  exit 0
}

# Extract the path to check based on tool type
case "$TOOL_NAME" in
  Read|Write|Edit)
    TARGET=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')
    ;;
  Glob|Grep)
    TARGET=$(echo "$INPUT" | jq -r '.tool_input.path // empty')
    ;;
  *)
    deny "BLOCKED: unknown tool '$TOOL_NAME'"
    ;;
esac

# Glob/Grep with no path default to cwd (already jailed) — allow
if [ -z "$TARGET" ]; then
  allow "Default path (cwd) is within jail"
fi

# Resolve the target path
if [ -e "$TARGET" ]; then
  RESOLVED=$(cd "$(dirname "$TARGET")" && pwd -P)/$(basename "$TARGET")
else
  PARENT="$TARGET"
  while [ ! -d "$PARENT" ]; do
    PARENT="$(dirname "$PARENT")"
  done
  RESOLVED="$(cd "$PARENT" && pwd -P)/${TARGET#$PARENT}"
  RESOLVED=$(python3 -c "import os; print(os.path.realpath('$TARGET'))" 2>/dev/null || echo "$RESOLVED")
fi

# Determine if this is a write operation
IS_WRITE=false
case "$TOOL_NAME" in Write|Edit) IS_WRITE=true ;; esac

# --- Outside jail check ---
if [[ "$RESOLVED" != "$JAIL_DIR"* ]]; then
  # Allow read-only access to ~/.claude/ for Claude Code internals
  if ! $IS_WRITE && [[ "$RESOLVED" == "$HOME/.claude/"* ]]; then
    allow "Read-only access to ~/.claude/ for Claude Code internals"
  fi
  deny "BLOCKED: path '$TARGET' resolves outside jail dir '$JAIL_DIR'"
fi

# --- Inside jail: enforce rules ---

# Block ALL access to dotfolders (.claude/, .codex/, .gemini/, .git/, etc.)
if echo "$RESOLVED" | grep -qE '(^|/)\.[^/]+/'; then
  deny "BLOCKED: access to dotfolders is not allowed ('$TARGET')"
fi

# For Glob/Grep: allow searching within the jail (read-only discovery tools)
case "$TOOL_NAME" in
  Glob|Grep)
    allow "Search within jail directory permitted"
    ;;
esac

# ┌─────────────────────────────────────────────────────────────┐
# │ CUSTOMIZATION: Allowed file extensions                      │
# │ Change this pattern to match your workflow's file types.    │
# │ Examples: *.md  *.md|*.txt  *.md|*.json|*.yaml              │
# └─────────────────────────────────────────────────────────────┘
BASENAME=$(basename "$RESOLVED")
if [[ "$BASENAME" != *.md ]]; then
  deny "BLOCKED: only .md files are allowed, got '$BASENAME'"
fi

# ┌─────────────────────────────────────────────────────────────┐
# │ CUSTOMIZATION: Protected config files (read-only)           │
# │ Add any files that should not be writable by the agent.     │
# └─────────────────────────────────────────────────────────────┘
if $IS_WRITE; then
  case "$BASENAME" in
    CLAUDE.md|AGENTS.md)
      deny "BLOCKED: '$BASENAME' is a protected config file"
      ;;
  esac
fi

# All checks passed — explicitly allow
allow "Permitted: .md file within jail directory"
