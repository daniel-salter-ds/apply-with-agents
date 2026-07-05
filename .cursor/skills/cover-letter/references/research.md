# Reference: Deep company, team, and hiring-manager research

Companion to `verification.md` and the new-cover-letter workflow's research
stage. Most AI-assisted cover letters fail not because the prose is bad but
because the research behind them stopped at the "About" page and the job
description. This file exists to push the research stage meaningfully
deeper than that, in a structured, time-boxed way.

## The bar for "good enough" research

Research is sufficient when it produces:

1. A **hook candidate** specific enough that it could not be pasted into a
   letter for any other company applying to a similar role.
2. **1-2 supporting threads** — a real technical challenge, a recent
   strategic shift, a stated value — each tied to a specific JD requirement
   or to one of the achievements selected in the resume-mapping stage.
3. Enough hiring-manager context (when a name is given) to calibrate tone —
   never enough to fabricate a connection that doesn't exist.
4. Every fact recorded with its **source, date published, and date
   fetched**, so staleness and conflicts are visible at a glance.

If after a reasonable search budget (see below) none of the above is
findable, say so plainly in `company-research.md` rather than padding the
letter with generic mission-statement language.

## A. Company — mission, trajectory, recent news

| Find | Why it helps | Sources | Example queries |
|---|---|---|---|
| Funding stage / most recent round | Signals growth pace and what they likely need from this hire | Crunchbase, the company's own press/blog, TechCrunch and sector trade press | `<company> funding 2026`, `<company> raises Series B` |
| Leadership/team changes relevant to the role | Possible hook ("congratulations on the new Head of Platform"); signals shifting priorities | LinkedIn company page → People, press releases | `<company> appoints`, `<company> Head of Engineering` |
| Recent product launches / public roadmap moves | The single best generic-company hook material — shows what they're building *right now* | Company blog/changelog, Product Hunt, X/LinkedIn company posts | `<company> launches`, `<company> changelog 2026` |
| Current mission/values framing | Tone calibration — must be the live page, not a cached or out-of-date summary | Fetch the current About/Careers page directly | n/a — fetch, don't search |
| Customers and case studies | Concrete language for how they describe value delivered, useful for mirroring tone | Case studies page, G2/Capterra reviews | `<company> case study` |
| Competitive landscape | Frames a credible "why you, not a competitor" angle if relevant | Comparison pages, analyst write-ups, Crunchbase competitor lists | `<company> vs <competitor>` |

## B. Team and technical context (for engineering/AI roles specifically)

| Find | Why it helps | Sources | Example queries |
|---|---|---|---|
| Engineering blog posts | Best hook material for a technical hire — real problems in their own words | Company engineering blog, Substack/Medium publication | `<company> engineering blog` |
| Public tech stack signals | Lets the letter speak the team's own technical vocabulary | The job posting itself, StackShare, GitHub org page, conference talks | `<company> tech stack` |
| GitHub org activity | Shows what they actually build and value (test rigor, docs quality, license choices) | `github.com/<company>` | browse directly |
| Conference talks / podcast appearances by team members | Reveals engineering philosophy in their own words; doubles as hiring-manager research if they're the speaker | YouTube, podcast directories, conference sites (Latent Space, AI Engineer, etc.) | `<company> conference talk`, `<person> podcast` |
| Papers / technical write-ups (AI/ML-specific) | Shows research depth and the specific problems they care about | arXiv, company research page | `<company> arxiv` |

## C. Hiring manager / named contact (when provided)

| Find | Why it helps | Sources |
|---|---|---|
| Recent posts/articles (prefer last 6-12 months) | Current thinking, possible genuine reference point | LinkedIn activity tab, X, personal blog |
| Talks or podcast appearances | Gives a sense of voice and values before assuming any tone | YouTube, podcast search |
| Tenure and prior roles | Context for likely priorities (e.g. came from a large company vs. another startup) | LinkedIn profile |
| Mutual connections / shared background | A potential genuine point of connection — **only ever use if real and confirmed by the user** | LinkedIn profile, mutual connections list |

**Hard rule:** this is observation-only research. Do not message, follow,
connect with, or otherwise contact the hiring manager as part of this
skill — and never imply familiarity with their work that the user hasn't
explicitly confirmed at the research checkpoint (see the main workflow's
mandatory checkpoint step).

## Search technique notes

- **Add the current year explicitly** to anything growth/news-related —
  "funding", "raises", "appoints", "launches" — these go stale within
  months and an un-dated query will surface old results as if current.
- **Check what your actual search tool supports before relying on
  Google-style operators** (`site:`, `before:`, `after:`, `intitle:`,
  `filetype:`). Many programmatic search wrappers — including the
  `web_search` tool used elsewhere in this environment — explicitly do
  **not** support these and will either ignore them or return degraded
  results. If operators aren't available: include the domain name as a
  plain keyword instead of `site:`, sort/scan results by date manually
  instead of `before:`/`after:`, and run one narrow query per source rather
  than one combined query.
- **Start narrow, broaden only if needed** — a 2-4 word query beats a long
  natural-language one for this kind of lookup; refine based on what comes
  back rather than guessing the perfect query up front.
- **Always fetch the actual page** for anything that will be cited in the
  letter — don't rely on a search snippet alone, since snippets are
  frequently stale, truncated, or describe an older version of the page.
- **Prefer first-party sources** (the company's own blog/press release, the
  person's own post) over secondary aggregators whenever a fact is
  contested or load-bearing for the hook.
- **LinkedIn pages often can't be fetched directly** behind a login wall —
  work from search snippets where that's all that's available, and if a
  claim can't be verified beyond a snippet, mark it as unverified in
  `company-research.md` rather than treating it as confirmed.

## Cross-validation procedure

1. For any claim destined for the **hook** (the highest-scrutiny sentence in
   the letter), check at least two independent sources before treating it
   as settled.
2. Record the publish date of each source, not just the fetch date.
3. When sources conflict (company size, leadership names, product
   positioning, funding numbers), prefer the most recently published one —
   but log the conflict in `company-research.md` rather than silently
   picking a side.
4. Treat the following as **high-volatility** and re-verify even if a page
   looks authoritative, since "About" and "Team" pages are commonly stale:
   funding stage/amount, team size, current leadership names, product
   names/positioning, anything described as "recent" or "new."

## Research depth budget

Target roughly **8-15 search/fetch calls** for a full company + team +
hiring-manager pass — fewer for a large, well-documented company with
abundant clean sources; more if early results conflict or the company has
a thin public footprint. If the budget is being exceeded substantially
without resolving the core hook material, stop and tell the user what's
been found so far rather than continuing to search indefinitely.

## Output

Write findings into `roles/<company-slug>/<role-slug>/company-research.md`
with one entry per fact: the claim, its source URL, date published, date
fetched, and (after the mandatory research checkpoint) whether the user
confirmed, corrected, or vetoed it. See the main workflow file for the
checkpoint procedure — drafting must not begin until that checkpoint is
resolved.
