---
name: plan-website
description: Interactively plan a website with a non-technical user - project snapshot, existing site/brand assets, inspiration sites, sitemap, per-page copy, and visual direction - before any code gets written. Actively asks for an existing website URL, brand/visual assets, and 2-3 sites whose look the user likes, then writes a maintained website/site-plan.md that build-website consumes next. Use whenever the user wants to plan, scope, or write copy for a website; needs help figuring out what pages a site should have; wants a sitemap or content outline; or says things like "I need a website," "help me plan my site," "what pages should my site have," or "I don't know where to start with a website." Trigger even if the user never says the word "website" but clearly wants an online presence for a business, portfolio, project, event, or personal page.
allowed-tools:
  - Read
  - Write
  - Edit
  - WebFetch
  - WebSearch
---

# Plan Website

Help a non-technical user turn a vague "I need a website" into a concrete, written plan another skill can build from.

This is the first of three chained skills: **plan-website → build-website → deploy-website.** Your job stops at a plan - don't write site code here, that's `build-website`'s job. But do it well: the better this plan is, the less back-and-forth the build phase needs.

## Why this skill front-loads research

Two things separate a good site plan from a generic template, and both come from *looking things up* instead of asking the user to describe everything from scratch:

- **What already exists.** Most people asking for a website aren't starting from nothing - they have an old site, a logo, a social bio, some reviews, a flyer. If you don't actively ask for and pull in what already exists, you'll make the user re-type things they've already written, and you'll lose real facts (their actual tagline, their actual services) in favor of generic filler.
- **What "good" looks like to them.** "Make it look nice" is not actionable. "Make it feel like this site, especially the big bold header and the muted colors" is. Asking for 2-3 sites the user likes turns a vibe into something concrete you can point to later.

Both are cheap to ask for and expensive to skip.

## Where the plan lives

```
website/
  site-plan.md   # the plan you're writing
  assets/        # logos, photos, brand notes, anything gathered along the way
```

On start, check whether `website/site-plan.md` already exists. If it does, read it, tell the user what you found, and continue/update it rather than starting over - this is a living document, not a one-shot form.

## Interaction mode

This is a **conversation, not an intake form.**

- **One step at a time.** Don't fire off ten questions in one message. Ask a couple, listen, reflect back what you heard, move on.
- **Plain language.** No jargon (sitemap, CTA, hero section, etc.) without a one-line plain-English gloss the first time you use it.
- **Do the legwork.** If the user gives you a URL or names a site they like, go look at it (`WebFetch`) instead of asking them to describe it to you.
- **Never invent facts.** Pricing, credentials, years in business, testimonials - if you don't have it from the user or their existing materials, leave it flagged as open rather than making something up.
- **Adapt pace to the person.** Some users will have all of this ready to go; others need you to suggest examples and options at every step. Read the room.

## The phases

Run these roughly in order, but stay flexible - if the user jumps ahead or answers three steps at once, don't force them back through a script.

### 1. Project snapshot

Get oriented in 3-4 quick questions:

- What's the site for? (a business, a portfolio, a nonprofit, a personal project, an event - anything)
- Who's it for - who's the visitor?
- What's the one thing you want a visitor to do? (book a call, buy something, sign up, get in touch, just learn more)
- Does a website already exist for this, or is this from scratch?

### 2. Existing assets audit

Actively ask for these - don't wait for the user to volunteer them:

- **Existing website.** If one exists, ask for the URL and, with the user's OK, fetch it (`WebFetch`) to pull over the current page list, copy, and anything worth keeping. This saves a rewrite from zero.
- **Brand/visual assets.** Logo, brand colors, fonts, existing photos or images, a tagline, any past materials (a flyer, a social media bio, a portfolio piece). Ask if they can share files or point you at a folder.
- **Existing copy.** About text, testimonials, reviews, FAQs already written somewhere else (an old site, a social bio, a profile page) that can be reused or lightly adapted instead of rewritten.

Save anything gathered into `website/assets/` and note where each thing came from in the plan.

### 3. Inspiration gathering

Ask for 2-3 websites whose *look* the user likes - competitors, aspirational brands, anything. For each one, get specific: what exactly do they like (layout, colors, fonts, tone, imagery style, a particular section)? "I just like it" isn't enough - dig one level deeper.

If they can't think of any offhand:
- Prompt them: "any site you've visited recently that felt easy to use, or just looked good to you?"
- Or propose 2-3 example directions yourself and let them react - reacting to options is easier than generating from a blank page.

Record the sites plus the specific things they liked in the plan - this becomes the visual brief `build-website` works from.

### 4. Sitemap

Propose a minimal page list based on the snapshot. Most simple sites need 1-5 pages: Home, About, Services/Products/Work, Contact, maybe a portfolio or testimonials page. Let the user add or cut pages, but default to fewer - a good one-pager beats a thin five-pager, and it's much faster to build and maintain.

### 5. Copy planning per page

Before drafting page-by-page copy, nail down two things once so every page stays consistent:

- **Voice/tone.** Friendly and casual? Polished and expert? Warm? Let the inspiration sites and any existing copy from step 2 inform this rather than asking in the abstract.
- **Key messages / proof points.** The 2-3 things that should land on every page - what makes this trustworthy or different (experience, reviews, credentials, past work, guarantees).

Then, page by page: headline, key points, calls to action. Reuse existing copy/assets where you have them. Where nothing exists, offer to draft copy in the voice you've established - but never invent facts on the user's behalf. Flag anything that needs the user to confirm or supply (a real price, a real credential, a real quote).

### 6. Visual direction

Combine the brand assets (step 2) and inspiration sites (step 3) into one concrete direction: color palette, fonts, tone words, layout style. If there's neither existing brand material nor clear inspiration, propose 2-3 simple visual directions and let the user pick rather than leaving it open-ended. If the user wants an actual mood board or logo concept sketched out, use the `canvas-design` skill for that.

### 7. Write the plan

Compile everything into `website/site-plan.md`:

- Project snapshot
- Existing site / asset audit (with sources)
- Inspiration references and what was liked about each
- Sitemap
- Voice and key messages
- Per-page content/copy
- Visual direction
- Open questions / assets still needed

Read the plan back to the user in plain language and confirm before finishing - this is their chance to catch anything off before it turns into a build.

## Handoff

When the plan is confirmed, tell the user it's ready to build, and that running `build-website` next will turn it into an actual site. If anything important is still missing (a photo, a real price, a decision they were unsure about), say so explicitly rather than letting it slide.
