# Provider notes: Netlify & Vercel

General shape of each path as of this writing. CLI flags and web UI flows change - if a command below doesn't work as described, run it with `--help` or do a quick web search for the current syntax before guessing.

## Netlify

**CLI path** (`netlify-cli`, install with `npm install -g netlify-cli` if not already present):

- `netlify login` - opens a browser for the user to authenticate. Wait for them to confirm they've completed it.
- `netlify deploy` - deploys to a draft/preview URL first. Good for a sanity check before going live.
- `netlify deploy --prod` - deploys to the real production URL.
- First-time deploy in a folder will prompt to link or create a site - a static folder of HTML/CSS/JS can usually be deployed directly by pointing at its publish directory (commonly `--dir=website/src` or the generator's build output folder, e.g. `dist`).

**Drag-and-drop path** (no CLI/terminal):

- Sign in at Netlify's site (email or an existing GitHub/GitLab/Bitbucket account).
- Use the "deploy manually" / drag-and-drop area on the dashboard and drop the built site folder onto it.
- Netlify assigns a random subdomain immediately (e.g. `random-name-123.netlify.app`); the site name/subdomain can be changed after in site settings.

## Vercel

**CLI path** (`vercel` CLI, install with `npm install -g vercel` if not already present):

- `vercel login` - opens a browser (or sends an email link) for the user to authenticate.
- `vercel` (run from inside the site's folder) - deploys and, on the first run, asks a few setup questions (project name, framework detection). For a plain static folder, accept the defaults / no framework.
- `vercel --prod` - promotes to the production URL.

**Drag-and-drop / web path (no CLI/terminal):**

- Vercel's primary workflow is CLI or a connected Git repo rather than a drag-and-drop upload like Netlify's. If the user can't use a terminal and doesn't want to connect Git, Netlify's drag-and-drop is the smoother no-terminal option - say so and suggest switching providers if the user has no strong preference.

## Choosing between them for a no-terminal user

If the user is uncomfortable with a terminal and has no existing account with either provider, default to **Netlify** - its drag-and-drop deploy is the more mature no-terminal path. Reserve Vercel for users who are already CLI-comfortable or already have a Vercel account.
