# Changelog

## 2026-04-15

### Changed

- Reframed the skill from a review-oriented command translator into a general prompt gateway for external AI CLIs.
- Added first-class support for `claude` alongside `codex` and `gemini`.
- Replaced review-first examples with prompt-routing examples that work for arbitrary prompts.
- Updated the command interface to document `/claude` and three-way routing through `/call`.

### Security Hardening

- Removed shell interpolation patterns such as `$(...)` from examples and explicitly forbade shell substitution and command chaining.
- Removed automatic upgrade execution and required explicit user approval before any toolchain upgrade.
- Replaced raw environment dump guidance with allowlisted presence checks only, without printing env values.
- Added stricter context-handling guidance to minimize forwarded source text and block secrets or broad repository exfiltration.

### Reference Updates

- Updated `reference/cli-reference.md` to document safe prompt templates for Codex, Claude, and Gemini.
- Removed review-biased command examples from the reference and aligned the documented patterns with the hardened skill behavior.
