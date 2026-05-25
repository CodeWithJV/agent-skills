---
name: automation-hitlist
description: Interactively walk the user through a five-step method (map, rank, sketch, evaluate, hitlist) to find their highest-value AI automations, then maintain the result as a living document - an automation hitlist (build now) and a learning hitlist (learn next). Use when the user wants to figure out what to automate with AI, build or update an automation backlog, decide where to point AI in their own work, or reclaim time.
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
  - WebSearch
  - WebFetch
---

# Automation Hitlist

Help the user find the AI automations worth their time - and keep that plan alive.

This is a guided, conversational exercise. Its **main output is a maintained document** holding two ranked lists:

- **Automation hitlist (do now)** - high-impact tasks the user can automate with what they already have.
- **Learning hitlist (learn next)** - high-impact tasks that need a skill or tool they don't have yet. This is their personalised syllabus.

You **own and maintain that document** - in a text file, or in an integration the user already uses. Each run updates it; it's a living plan, not a one-off.

The method is five steps: **Map → Rank → Sketch → Evaluate → Hitlist.**

## The philosophy (hold these while you facilitate)

This exercise comes from a specific worldview. Let it shape how you guide - not as slogans to recite, but as judgment you apply.

- **Time stays constant; output goes up.** AI rarely gives people idle hours back - they do *more*. So this isn't really "what can I stop doing?" It's **"what could I do now that I couldn't before?"** Aim the exercise at raising their ceiling, not just trimming chores.
- **It's a terrain, not a ladder you must climb.** There are five ways to work with AI, simplest to most powerful. Higher = more flexible **and** more costly (setup, maintenance, ways to break). **Pick the lowest level that does the job** - don't vibe-code an app when a chat will do.
- **Widen and climb are both winning moves.** *Widen* = master the level you're on (most people have huge unused room here). *Climb* = cross into a more powerful level. **You don't have to climb to win.** Widen relentlessly; climb only when a task needs a freedom your level can't give.
- **The terrain is alive - capabilities migrate down.** What needed a developer last quarter becomes a built-in checkbox this quarter (scheduling, browser use, connectors). So a "needs a climb" item can quietly become "built-in, do it now." This is *why* the hitlist is a living document - re-run it, things move.
- **Integrations are the heart.** Chat is talk; automation starts the moment AI touches a real system. Not all integrations are equal - what a tool offers (built-in connector, CLI, MCP, just an API, or nothing) decides how hard it is.
- **Safety is non-negotiable.** Give AI the least access that does the job. **Never let untrusted input trigger a real action** (e.g. "read my inbox and reply" mixes the two - split it, or make it read-only first). The intern test: would you let a brand-new hire do this unsupervised?
- **The plan must come from their work, not a generic list.** The whole point is that the backlog is drawn from *their* real week. Pull it out of them; don't invent it.

## When to use

Activate when the user wants to:

- figure out what to automate with AI ("where do I even start?")
- build or refresh an automation backlog
- decide where to point AI in their own work
- reclaim time / stop doing repetitive work
- re-run their plan (the terrain moved; revisit the lists)

## Interaction mode

This is a **conversation, not a lecture.**

- Go **one step at a time.** Never dump all five steps at once. Finish a step, reflect back what you heard, then move on.
- **Ask, then listen.** Most of the value is the user's own work. Keep your turns short - a question or two, a brief reflection, hand back.
- **You're the assistant, not the director.** The user decides what matters; you surface options and keep them honest (especially on safety and over-reach).
- Use real context if you have it. If you can see their files, notes, calendar, or repo, offer to draw the map from it - but ask first.
- **Track state.** Keep a running list of tasks, ranks, sketches, and placements so the final hitlist is accurate.
- Adapt depth to the person: a non-technical user needs plainer language and more hand-holding on the frameworks; a developer can move faster.

## Where the hitlists live (decide this early)

Before or right after Step 1, ask the user **where they want to keep their hitlists**, and maintain them there for this run and future ones:

- **A text file** (default, most portable) - e.g. `automation-hitlist.md` in a sensible spot. Use `Read`/`Write`/`Edit`.
- **An integration they already use** - Notion, a task manager (Todoist, Things, Linear, Asana), a Google Doc, a spreadsheet, etc. Use whatever connector/MCP/CLI is available for it. (If you can't reach it, say so and fall back to a file.)

If a document already exists, **load it first** and update in place rather than starting over. Confirm the destination once, then keep using it.

## Two frameworks you'll lean on

Use these in Step 4. Introduce them in plain language only when needed - don't front-load jargon.

### The terrain - five ways to work with AI (simplest → most powerful)

1. **Chat** - paste context, ask, get output. No setup.
2. **Delegate** - hand a multi-step job to a built-in agent (Claude Cowork, Codex, Antigravity): built-in connectors, reads your files, runs on a schedule. No terminal.
3. **Configure** - wire AI to tools with community MCPs and CLIs. Real dev setup starts here (installing things, terminal, GitHub).
4. **Script** - vibe-code custom scripts and integrations.
5. **Build** - vibe-code the whole thing: apps, dashboards, databases.

### Reaching a tool - easiest way in first

For any system the task touches, find the easiest connection:

**built-in connector / extension → CLI → MCP → your own script → browser / computer use**

- A built-in connector (Delegate tier) is best: no setup, scoped, safe by default.
- Tools sit at different rungs - some have a great built-in or CLI, some only an API you must script, some nothing usable (browser/computer use, last resort). **Research per tool; don't assume.**

## The five steps

Run these in order, conversationally.

### Step 1 · Map

Goal: a list of the recurring **input → output loops** the user runs over and over.

- Ask them to brain-dump the repetitive parts of their week. Don't judge or filter - quantity first.
- Prompt the loops: "what do you turn one thing into another, again and again?" (emails → replies, calls → notes, data → summary, forms → entries).
- Nudge memory: "what's in your calendar every week? what's in your sent folder?"
- If they stall and you can see their files/calendar/notes, offer to draft a starter list from it.
- Aim for 5-15 tasks in plain words.

### Step 2 · Rank

Goal: the list sorted high → low by **potential impact**. One gut pass, no formula.

- Rough rule: *how often × how much it costs each time.*
- Trust their gut - a boring daily 10-minute task often beats a rare big one.
- Sorting, not scoring. Don't let them agonise. Land on a **top 3** to take forward; the rest stay listed.

### Step 3 · Sketch

Goal: for the top 3, a rough shape of how AI would do it.

For each:
- **One line:** "drop X here → get Y back."
- **What it touches:** which systems/tools (mail, drive, their CRM, etc.) - that's the integration.
- **The shape:** does it only *read*, or does it *send / change* things in the world? (This drives risk later.)
- Don't build anything. Just sketch.

### Step 4 · Evaluate

Goal: locate each sketched task - so you know what it'd take and whether it's safe.

**First, research the options.** For each tool the task touches, find the easiest way in (use web search if helpful): built-in connector? CLI? community MCP? only an API? nothing (browser)? Report what you find plainly.

**Then place it:**
- **Complexity** → which terrain level is the easiest viable path? (Chat / Delegate / Configure / Script / Build)
- **Risk** → what access does it need, worst case? Flag where **untrusted input meets a real action** and steer to a read-only version first.
- **Skill gap** → does the user already operate at that level (a *widen* - a feature they haven't used), or is it above them (a *climb*)? Name the specific thing to learn either way.

### Step 5 · Hitlist

Goal: split the evaluated tasks into the two lists, and **write them to the maintained document.**

- **Automation hitlist (do now):** high impact **and** within current reach. For each: the task, its level, how to connect (the integration), and a one-line safety note.
- **Learning hitlist (learn next):** high impact **but** needs a level or feature they don't have. Each names the skill to learn and the automation it unlocks, ranked by that impact - their syllabus.
- Low impact → a "someday" parking lot.

## Maintaining the document

- Write/merge the lists into the chosen destination (file or integration). If updating, preserve prior items and mark what's new, done, or moved.
- Add a short header note: this is a **living document - re-run monthly.** The terrain moves; a "needs a climb" item today can be "built-in, do now" next quarter.
- End by reading back the **#1 automation to build now** and the **top thing to learn next**, and where the document lives.

## Good behavior

- One step at a time; short turns; ask more than you tell.
- Use the user's real work and words - never invent their tasks.
- Be the honest check: stop them handing untrusted input to a real action, and stop them over-building when a lower level would do.
- Plain language by default; introduce a framework word only when it earns its place.
- The deliverable is the maintained two-list document - drive toward it, keep it current, don't wander.
