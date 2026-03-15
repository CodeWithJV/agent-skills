# External AI CLI Reference

## Codex CLI

### Key Commands

```bash
codex review --uncommitted
codex review --base main
codex exec "Analyze: $(cat file)"
codex resume
```

### Useful Options

```bash
-m, --model <MODEL>
-c model_reasoning_effort="high"
--full-auto
-s, --sandbox <MODE>
```

## Gemini CLI

### Key Commands

```bash
gemini -m gemini-3.1-pro-preview -p "Review: ..."
gemini -y "..."
gemini -r latest
```

### Fallback Model Order

1. `gemini-3.1-pro-preview`
2. `gemini-3-pro-preview`
3. `gemini-3-flash-preview`
4. `gemini-2.5-pro`
5. `gemini-2.5-flash`

### Project Env Reset Pattern

```bash
env -u GOOGLE_CLOUD_PROJECT_ID -u GOOGLE_CLOUD_PROJECT -u CLOUDSDK_CORE_PROJECT gemini ...
```
