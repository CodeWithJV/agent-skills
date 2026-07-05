---
name: build-website
description: Turn a website plan (website/site-plan.md from plan-website, or a quick on-the-fly plan) into an actual working site - hand-authored HTML/CSS/JS for simple sites, or a small static site generator for larger ones, chosen automatically based on complexity rather than asked of the user. Builds section by section with a live Cowork artifact preview after each chunk, iterating on feedback instead of presenting a finished site cold. Use whenever the user wants to turn a plan into a real website, asks to "build the site," "make the homepage," "turn this into a website," or wants to see what a page looks like. Trigger even if no formal plan exists yet - run a condensed planning pass first rather than refusing.
allowed-tools:
  - Read
  - Write
  - Edit
  - Bash
  - Grep
  - Glob
---

# Build Website

Turn a plan into a real, working website for a non-technical user - previewed live, iterated on, never dumped as a finished surprise.

This is the middle skill of three: **plan-website → build-website → deploy-website.** You take a plan and produce site files; you don't publish them to the internet - that's `deploy-website`'s job.

## Start here: find or make a plan

Read `website/site-plan.md`. If it doesn't exist, don't send the user back to `plan-website` manually - run a condensed version of the key questions yourself (what's the site for, who's it for, what pages, any existing copy/brand assets/inspiration) and write a minimal plan before building. A plan doesn't need to be perfect to start building from, but building with zero plan means guessing at facts, which you should never do.

## Choosing how to build it - decided by you, not the user

A non-technical user has no useful opinion on "Astro vs. plain HTML" - don't ask. Decide based on what the site actually needs:

- **1-3 simple pages, no forms/blog/CMS** → hand-authored HTML/CSS/JS, single file or a few files. Fastest to build and preview, and easiest for the user (or a future you) to hand-edit later without any tooling.
- **4+ pages, or needs a blog, a repeating layout, or a contact-form backend** → a small static site generator - Astro is a good default for simplicity - with shared layout/components, exported to static output.

Note which you chose and why in a short build summary (append it to `site-plan.md` or start `website/deploy-notes.md` early) - the deploy step needs to know, since a static export deploys differently than a generator project.

## Build in chunks, preview as you go

Don't build the whole site in one shot and reveal it at the end. Build section by section (typically page by page):

1. Build one meaningful chunk (a page, or a major section of a long single page).
2. Show it live via a Cowork artifact.
3. Ask what they'd change - "here's the homepage, what would you change?" - before moving to the next chunk.

This matters more for this audience than most: a non-technical user often can't visualize a finished site from a description, and won't know what they want changed until they can see and react to something real. Small, frequent previews also catch misunderstandings early instead of compounding them across five pages.

## Stay faithful to the plan

- Use the copy, structure, and visual direction from `site-plan.md` as written. If something's missing (an undecided CTA, a photo that was never provided), flag the gap and ask or use a clearly-marked placeholder - never invent a business fact, price, credential, or quote to fill the space.
- Carry the visual direction through consistently: the color palette, fonts, and tone words from the plan should show up on every page, not just the first one you build.
- If the user asks for something that contradicts the plan mid-build, that's fine - just make sure the plan (or your build summary) reflects the change so `deploy-website` and any future re-run aren't working from a stale picture.

## Baseline quality, without being asked

A non-technical user won't think to request these, but will notice if they're missing:

- Responsive layout - it should work on a phone, not just a wide desktop preview.
- Reasonably sized/optimized images - don't ship an unoptimized multi-MB photo as a hero image.
- No unnecessary heavy libraries or dependencies for what is usually a handful of static pages.
- Working links and navigation between the pages that were actually built.

## Output

- `website/src/` - the site files, structured appropriately for whichever approach was chosen (a flat folder of HTML/CSS/JS, or a generator project with its build output).
- A short build summary (what was built, which approach and why, any open TODOs) appended to `website/site-plan.md`.

## Handoff

Once the user is happy with the preview, tell them it's ready to go live, and that running `deploy-website` next will put it on the internet with a real URL.
