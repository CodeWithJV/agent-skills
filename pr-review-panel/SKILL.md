---
name: pr-review-panel
description: Run a two-model code review panel over a pull request — a Fable subagent and a codex gpt-5.6-sol reviewer at xhigh reasoning — save each verdict to a scratch file, consolidate them into one review, and post it to the PR only after the operator has approved the text. Use when asked to "review this PR", "get a second opinion on the PR", "run the review panel", or to review a branch before merge.
---

# PR Review Panel

Two independent reviewers, different models, no shared context. Their outputs are saved, consolidated, shown to the operator, and only then posted.

**The panel exists to disagree with itself.** Two models that saw the same summary produce the same blind spots, so each reviewer reads the diff itself and neither sees the other's output until consolidation.

## Non-negotiable: nothing reaches GitHub without operator approval

**Never post, comment on, approve, or request changes on a PR until the operator has read the consolidated review and said to post it.** Show them the full text, in the conversation, and wait.

This is a hard gate, not a nicety: a review posted under the operator's account is them speaking to a colleague. Two models agreeing is not evidence — they can be confidently wrong together, and a wrong "request changes" costs someone real time.

If the operator is unavailable, save the consolidation and stop.

## 1. Gather the PR once

```bash
gh pr view <PR> --json number,title,body,headRefName,baseRefName,additions,deletions
gh pr diff <PR> > <scratch>/pr-<PR>.diff
gh pr view <PR> --comments
gh issue view <linked-issue>            # scope often lives here, and moves
```

Scratch dir: use the session scratchpad if one exists, else `/tmp/pr-review-<PR>/`. Never write review artefacts into the repo — they are not repo content.

Read the linked issue **and its comments**, in date order. Scope gets revised in comments without the body being updated; a reviewer working from a stale body reports the wrong things.

## 2. Run both reviewers in parallel

Both get: the diff path, the PR body, the issue and its comments, and the repo path. Neither gets the other's output.

**Reviewer A — Fable subagent.** Spawn via the Agent tool with `model: "fable"`.

**Reviewer B — codex gpt-5.6-sol at xhigh.**

```bash
codex exec -m gpt-5.6-sol -c model_reasoning_effort=xhigh "<prompt>" > <scratch>/review-codex.md 2>&1
```

Run it backgrounded — xhigh is slow.

Give both the same brief:

- Judge correctness first: does it do what the ticket asks, and does it break anything else?
- Trace surrounding code, not just changed lines. A diff that reads fine can still be wrong in context.
- Check the tests actually pin the behaviour — would they fail if the fix were reverted? A test that passes either way is a finding.
- Flag anything security-, data-integrity-, or migration-shaped explicitly.
- Cite `file:line` for every finding. A finding without a location is not actionable.
- Rank by severity: blocking / high / medium / low.
- Say plainly when something looks right. A review that only lists problems is not a review.
- Do not restate the diff back.

Save each raw verdict: `<scratch>/review-fable.md`, `<scratch>/review-codex.md`. Keep them — the operator may want to see who said what.

## 3. Consolidate

Merge into one review. This is judgement work, not concatenation:

- **Both flagged it** → lead with it, note the agreement.
- **One flagged it** → keep it if the code supports it. Check the claim against the file yourself before promoting it.
- **They disagree** → say so explicitly and give your own read, with the evidence. Do not average two positions into mush.
- **Either is wrong** → drop it and say you dropped it. Passing on a bogus finding wastes the author's time and costs you credibility on the real ones.

Deduplicate hard: the same defect described twice is one finding.

Output: a short summary line, findings by severity with `file:line`, what looks good, and a recommendation — approve / comment / request changes.

## 4. Operator gate

Show the operator the consolidated text and the recommendation. Say which findings each reviewer contributed, and name anything you dropped and why.

Then **stop and wait.**

## 5. Post, once told to

```bash
gh pr review <PR> --comment --body-file <scratch>/review-final.md
# or --request-changes / --approve, per the operator's instruction
```

Use the verdict the operator chose, not the one you recommended. Report the URL.

## Rules

- **Never** post before the gate, even when both reviewers agree and the finding looks obvious.
- Never file follow-on issues from a review. Findings go in the review; the author decides what becomes a ticket.
- Never edit the PR, its branch, or its description as part of reviewing it.
- If a reviewer fails or returns nothing, say so — do not silently ship a one-model review as a panel.
