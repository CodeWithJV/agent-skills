---
name: retro
description: Run a retrospective on the current task or chat history. Use when the user wants to understand mistakes, dead ends, wasted effort, root causes, and what should change to improve performance next time.
allowed-tools:
  - Read
  - Grep
  - Glob
  - Bash
---

# Retro

Run a retrospective on the work that just happened.

This skill is for understanding:

- what went wrong
- what took too long
- what wasted tokens or effort
- what dead ends appeared
- what actually worked well
- what should change next time

The goal is not just to list mistakes.

The goal is to find the underlying causes and propose changes that improve future performance.

## When to Use

Activate this skill when the user asks to:

- do a retro
- review what went wrong
- figure out why a task took too long
- find inefficiencies or wasted effort
- understand repeated failure patterns
- improve the workflow for next time

## Inputs to Review

Look across the full context that shaped the outcome:

- the chat history
- the user's instructions
- the skills used
- the repo or task context
- the tool behavior
- the sequence of decisions taken

If relevant, also look at:

- error outputs
- retries
- abandoned approaches
- unclear handoffs
- changes in user intent during the task

## Interaction Mode

Do not assume every retro should be one-shot.

Use judgment:
- If the failure pattern is already clear from context, produce the retro directly.
- If the causes are ambiguous, contested, emotional, or likely to benefit from richer operator insight, engage the user with a short iterative retro first.

In iterative mode:
- ask a small number of focused questions
- use the answers to refine the root-cause analysis
- then produce the final retro

Good questions are about:
- what the user noticed that the agent missed
- which failure mattered most
- whether the problem was skill, prompt, tool, workflow, or judgment
- what durable fix the user wants to see in the system

Do not ask broad or redundant questions just to prolong the retro.
Ask only when it will materially improve the resulting persistent changes.

## What to Look For

### 1. Errors and mistakes

Find:

- wrong assumptions
- incorrect tool use
- missed instructions
- factual or process errors

### 2. Inefficiencies

Find:

- wasted token-heavy exploration
- duplicated work
- unnecessary retries
- avoidable browsing or searching
- places where a simple tool or script would have been better

### 3. Dead ends

Find:

- lines of investigation that did not help
- loops caused by unclear context
- repeated attempts that should have been abandoned earlier

### 4. What worked well

Protect the good parts.

Find:

- useful framing from the user
- effective skills
- strong workflow steps
- fast paths that worked
- good heuristics that should be preserved

Do not propose changes that accidentally break those strengths.

## Root Cause Analysis

Do not stop at the surface symptom.

For each meaningful problem, ask:

1. What happened?
2. Why did it happen?
3. What allowed it to happen?
4. What is the deeper pattern underneath it?

Root causes often come from:

- unclear user request framing
- missing or weak skill instructions
- bad skill boundaries
- missing shared vocabulary
- poor repo/context visibility
- no lightweight tool for a repeated task
- bad workflow sequencing
- no checkpoint or review gate

Prefer a small number of real causes over a long list of shallow complaints.

If using iterative mode, test your draft causes against the user's answers before finalizing them.

## Output

Produce a retrospective with these sections:

### Retro Summary
- What the task was
- Whether it went well overall
- The biggest issues
- The biggest strengths

### What Went Wrong
- Concrete failures, mistakes, delays, or dead ends

### Root Causes
- The underlying causes behind the issues
- Separate symptoms from causes

### What Worked Well
- The good patterns worth preserving
- Why they worked

### Recommended Changes

Suggest concrete improvements for next time.

These must be practical, durable changes rather than reminders to "be more careful" or "do better."
Prefer changes that survive memory and can be reapplied automatically or mechanically.
The output should be expressible as something that can be saved outside the chat session in a persistent system or file.

These may include:

- updating an existing skill
- creating a new skill
- changing the workflow
- adding a checklist
- creating a CLI or script
- improving repo/context review at the start
- changing how the user frames the request
- adding a review gate
- creating a reusable template
- writing a reusable note, issue, or runbook entry that will persist outside the current chat

For each suggestion, explain:

- what should change
- why it would help
- whether it is high leverage or optional
- what artifact should be updated (skill file, prompt template, checklist, script, command wrapper, repo doc, issue template, etc.)
- where that artifact should live so the improvement persists beyond the current session

### Highest-Leverage Next Step

End with the single most valuable change to make first.

This must be one concrete, durable change to an artifact or workflow, such as:
- update a specific skill
- add a checklist item
- create a helper script
- change a standing prompt template
- add a review or validation gate
- write or update a persistent note/runbook/issue/template in a known location

Do not end with vague advice like:
- "be more careful"
- "check more often"
- "communicate better"
- "do better next time"

The chosen next step must be something that can be saved to a file, system, template, or tracked workflow so it remains available after the chat ends.

If you used iterative mode, the output should reflect what changed after questioning the user rather than ignoring their added signal.

## Good Behavior

- Be honest but not noisy
- Focus on future improvement, not blame
- Preserve what already works
- Prefer structural fixes over one-off hacks
- Be specific enough that the human could actually implement the suggestion
- Prefer recommendations that can be encoded into skills, prompts, scripts, templates, or checklists
- When the user's observations can materially improve the retro, engage them briefly before finalizing
