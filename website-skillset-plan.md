# Website Skillset — Plan

Three chained skills that walk a non-technical user from "I need a website" to a live website on Netlify or Vercel. Modeled on the conversational, one-step-at-a-time style used in `automation-hitlist`.

Skills: `plan-website` → `build-website` → `deploy-website`

Each skill can run standalone, but they hand off through a shared project folder so the user can pick up later or re-run any stage:

```
<project>/
  website/
    site-plan.md        # output of plan-website (input to build)
    assets/              # logos, photos, brand notes gathered during planning
    src/                 # output of build-website (input to deploy)
    deploy-notes.md      # output of deploy-website (URL, provider, how to redeploy)
```

## Shared design principles (apply to all three)

- **Plain language, no jargon without explanation.** Audience is non-technical users — no assumed knowledge of HTML, hosting, DNS, or build tools.
- **One step at a time, conversational.** Never dump the whole process in one message. Ask, get an answer, reflect it back, move on — same rhythm as `automation-hitlist`.
- **Show, don't just tell.** Use Cowork artifacts for live preview whenever there's something visual to react to (drafts, mockups, the site itself).
- **Confidence-building tone.** Many non-technical users have never built a website before and may feel intimidated. Normalize that, keep momentum, celebrate small milestones (first preview, first deploy).
- **Always leave a paper trail.** Every skill writes/updates files in `website/` so nothing lives only in chat history.
- **Graceful resume.** Each skill checks whether its input file already exists and whether its own output already exists — offering to continue/update rather than restart from zero.

---

## Skill 1: `plan-website`

**Trigger / description:** Use when the user wants to plan, scope, or write content for a website — before any code exists. Covers goals, audience, sitemap, copy, and visual direction.

**When to use:** "I need a website," "help me figure out what pages my site needs," "write copy for my landing page," "I don't know where to start with a website."

**Phases:**

1. **Project snapshot** — What's the site for (a business, a portfolio, a nonprofit, a personal project, an event, anything), who is it for, what's the one action a visitor should take (book a call, buy, sign up, get in touch, learn more)? Does an existing website already exist (redesign vs. from scratch)? Keep it to 3-4 quick questions, plain language.
2. **Existing assets audit** — Actively ask for, don't wait for the user to volunteer:
   - **Existing website**, if any — ask for the URL and, with permission, fetch/skim it (`WebFetch`) to pull over existing copy, page list, and anything worth keeping so the user isn't rewriting from zero.
   - **Brand/visual assets** — logo, colors, fonts, existing photos/images, tagline, past materials (a flyer, a social bio, a resume/portfolio piece, anything). Ask if they can share files or point to a folder/drive.
   - **Existing copy** — any About text, testimonials, reviews, FAQs already written elsewhere (social bios, an old site, a profile page) that can be reused or adapted.
   - Save everything gathered into `website/assets/` and note sources in `site-plan.md`.
3. **Inspiration gathering** — Ask for 2-3 websites (competitors, aspirational brands, anything) whose *look* they like, and for each: what specifically they like (layout, colors, fonts, tone, imagery style, a particular section). If they can't name any offhand, offer a couple of prompts ("any site you've visited recently that felt easy to use?") or propose 2-3 example directions for them to react to instead of starting from a blank page. Capture the sites + the specific likes in `site-plan.md` — this becomes the visual/reference brief for the build skill.
4. **Sitemap** — Propose a minimal page list based on the snapshot (most simple sites need 1-5 pages: Home, About, Services/Products/Work, Contact, maybe a portfolio/testimonials page). Let the user add/cut pages. Default to fewer pages, not more — a good one-pager beats a thin five-pager.
5. **Copy planning per page** — Before drafting final copy, nail down the basics once so every page stays consistent:
   - **Voice/tone** (e.g. friendly and casual vs. polished and expert) — inform this from the inspiration sites and any existing copy gathered in step 2.
   - **Key messages / proof points** — the 2-3 things that must land on every page (what makes this trustworthy/different: experience, reviews, credentials, past work, guarantees).
   - Then, for each page: headline, key points, calls to action, drawing on existing copy/assets where available. Offer to draft new copy in the established voice where nothing exists — never invent facts (pricing, credentials, claims) on the user's behalf; flag anything that needs the user to confirm or supply.
6. **Visual direction** — Combine brand assets (step 2) and inspiration sites (step 3) into a concrete direction: color palette, fonts, tone words, layout style. If there are no existing brand assets and no clear inspiration, propose 2-3 simple visual directions and let the user pick. Lean on the `canvas-design` skill if the user wants a quick visual mood board or logo concept.
7. **Write the plan** — Compile everything into `website/site-plan.md`: existing-site/asset audit, inspiration references, sitemap, voice/key messages, per-page content/copy, visual direction, and any open questions/assets still needed. Read it back to the user and confirm before finishing.

**Output:** `website/site-plan.md` (+ any gathered assets in `website/assets/`, including a note of which inspiration sites were referenced).

**Handoff line:** end by telling the user this plan is ready to build, and that running the build skill next will turn it into an actual site.

---

## Skill 2: `build-website`

**Trigger / description:** Use when the user has a site plan (or wants one made on the fly) and is ready to turn it into a working website — HTML/CSS or a small static site, previewed live and iterated on.

**When to use:** "build the site from my plan," "turn this into a website," "make the homepage," "I want to see what this looks like."

**Approach — adaptive, decided by Claude:**

- Read `website/site-plan.md`. If it doesn't exist, offer to run a condensed version of the planning questions first (don't force the user back to skill 1 manually).
- Pick the build approach based on complexity, don't ask the user to choose a tech stack:
  - **1-3 simple pages, no forms/blog/CMS** → single-file (or few-file) hand-authored HTML/CSS/JS. Fastest to build and preview, easiest for the user to later hand-edit.
  - **4+ pages, or needs a blog/repeating layout/contact form backend** → a small static site generator (Astro preferred for simplicity) with shared layout/components, exported to static output.
  - Note the choice and why in `deploy-notes.md` later (affects how it gets deployed).
- Build section by section (e.g., page by page), not all at once. After each meaningful chunk, show a live preview via a Cowork artifact and ask for reactions before continuing.
- Keep copy and structure faithful to `site-plan.md`; flag any gaps (missing photo, undecided CTA) instead of inventing facts.
- Basic responsiveness and reasonable performance (optimized images, no giant unused libraries) by default — the user won't think to ask for this.
- Iterate conversationally: "here's the homepage — what would you change?" rather than presenting a finished product cold.

**Output:** `website/src/` (the actual site files, structured appropriately for the chosen approach), plus a one-paragraph build summary appended to `website/site-plan.md` (what was built, tech choice, any open TODOs).

**Handoff line:** once the user is happy with the preview, tell them it's ready to go live and that the deploy skill will handle putting it on the internet.

---

## Skill 3: `deploy-website`

**Trigger / description:** Use when the user has a built website (from `build-website` or otherwise) and wants it live on the internet via Netlify or Vercel.

**When to use:** "put my site online," "deploy this," "get my site a URL," "how do I make this live."

**Phases:**

1. **Locate the site.** Read `website/src/`. If it's missing, ask for the folder containing the finished site.
2. **Pick a provider.** If the user already has a Netlify or Vercel account (ask, or check for existing CLI login/connector), use that. Otherwise explain the two options in one plain sentence each (both are free for a simple site, both give you a working URL in minutes) and let the user pick — don't make them research it.
3. **Get the easiest path in, in order of preference:**
   - Existing Cowork/Claude connector for Netlify or Vercel, if connected.
   - Provider CLI (`netlify deploy` / `vercel`) if it's already installed or can be installed in the sandbox — this is the most hands-off path once the account exists.
   - If no CLI/connector and the user is uncomfortable with a terminal, fall back to walking them through the provider's drag-and-drop web deploy (upload the `website/src/` folder) step by step, in plain language, confirming what they see on screen at each step.
4. **Account/auth.** If the user doesn't have an account, walk them through signing up (plain language, "you'll need to click X, then Y"). Never ask the user for API tokens/passwords in chat — direct them to complete login/auth in their own browser.
5. **Deploy.** Run the deploy, surface the resulting live URL clearly.
6. **Verify.** Open/check the live URL, confirm it matches the preview, flag anything broken (missing images, broken links) and fix before declaring done.
7. **Explain "what happens next."** In plain language: how to redeploy after future edits (re-run this skill, or the specific one-line command), whether there's a free custom domain step they can do later, and that the site will stay live without any ongoing action from them.

**Output:** `website/deploy-notes.md` — provider, live URL, how to redeploy, how to point a custom domain later.

---

## Chaining & re-entry behavior

- Any skill, on start, checks for `website/` in the current project and reads whatever exists (`site-plan.md`, `src/`, `deploy-notes.md`) to avoid re-asking answered questions.
- A user can jump straight to `build-website` or `deploy-website` without having run the earlier skill(s) — each one degrades gracefully by doing a condensed version of the missing prior step rather than refusing.
- Re-running any skill later (new page, redesign, redeploy) should update the existing files in place, not start over — same "living document" pattern as `automation-hitlist`.

## Build notes for actually authoring these (next step, not done yet)

- Follow the repo's existing `SKILL.md` format (YAML frontmatter with `name`/`description`/`allowed-tools`, then a conversational instructions body) — see `automation-hitlist/SKILL.md` for the reference pattern.
- `plan-website` needs `Read`, `Write`, `Edit`, `WebFetch` (pulling existing site content and skimming inspiration sites), `WebSearch` (finding examples if the user can't name any offhand).
- `build-website` needs `Read`, `Write`, `Edit`, `Bash` (for Astro scaffolding when that path is chosen), plus artifact creation for live preview.
- `deploy-website` needs `Read`, `Bash` (CLI deploys), and `WebFetch`/`WebSearch` for verifying the live URL and looking up current Netlify/Vercel CLI usage (their flags/flows change).
- Use the `skill-creator` skill to actually scaffold and validate each `SKILL.md` once this plan is approved.
- Consider a `reference/checklist.md` per skill (matching the pattern in `retro/` and `review-context-hub/`) for the pre-flight questions or QA checklist, keeping the main `SKILL.md` shorter.
