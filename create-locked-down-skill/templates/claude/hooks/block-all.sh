#!/usr/bin/env bash
# block-all.sh — Catch-all PreToolUse hook (no matcher = runs on every tool call).
# Allows only file tools through to dir-jail.sh. Denies everything else.
#
# CUSTOMIZATION:
#   To allow additional tools (e.g., WebSearch), add them to the case statement below.

set -euo pipefail

INPUT=$(cat)
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // empty')

# Tools handled by dir-jail.sh — pass through
case "$TOOL_NAME" in
  Read|Write|Edit|Glob|Grep)
    exit 0
    ;;
  # UNCOMMENT to allow web access:
  # WebSearch|WebFetch)
  #   exit 0
  #   ;;
esac

# Everything else is blocked
jq -n --arg reason "BLOCKED: tool '$TOOL_NAME' is not allowed in this locked-down environment" '{
  "hookSpecificOutput": {
    "hookEventName": "PreToolUse",
    "permissionDecision": "deny",
    "permissionDecisionReason": $reason
  }
}'
