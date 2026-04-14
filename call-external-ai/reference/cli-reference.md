# External AI CLI Reference

## Codex CLI

### Key Commands

```bash
codex exec "Analyze the following prompt: ..."
codex exec -m gpt-5.4 "Analyze the following prompt: ..."
codex resume
```

### Useful Options

```bash
-m, --model <MODEL>
-c model_reasoning_effort="high"
-s, --sandbox <MODE>
```

## Claude CLI

### Key Commands

```bash
claude -p "Analyze the following prompt: ..."
claude --model sonnet -p "Analyze the following prompt: ..."
claude --resume latest
```

### Useful Options

```bash
--model <MODEL>
-p, --print
--permission-mode <MODE>
```

## Gemini CLI

### Key Commands

```bash
gemini -p "Analyze the following prompt: ..."
gemini -m gemini-3.1-pro-preview -p "Analyze the following prompt: ..."
gemini -r latest
```

## Safety Rules

- Use only safe command templates documented by the skill.
- Do not use shell substitution such as `$(...)` or backticks.
- Do not dump environment variables or print secret values.
- Read files directly in the current agent, then pass only minimal necessary prompt text to external CLIs.
- Do not chain commands or append unrelated shell operators.

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
