# Reference: research-summary.md format

Human-facing summary written **when research completes**, **before** the
research checkpoint. The agent presents this file (or a digest) to the user
for hook confirmation.

After `research-summary.md` is written, the agent runs the research auditor
(step 5b) before presenting the checkpoint digest. Reflect WARN/FAIL items in
the recommended checkpoint mode when relevant.

**Gold-standard example:**
[`examples/e2e/software-engineer/research-summary.md`](../../../../examples/e2e/software-engineer/research-summary.md)

## Pre-checkpoint sections (required)

### Header metadata

- Role title + link to posting
- Squad/team if known
- Research date
- Research depth count (search/fetch calls)
- Link to full audit trail: `company-research.md`

### Sourced facts by theme

Group verified facts with inline links and published dates. Themes typically
include: platform/engineering, product/agentic AI, governance, culture,
location/hybrid, **hiring manager** (when a name was provided — observation
only; list do-not-imply items). Flag secondary sources.

### Hiring manager (when provided)

Separate subsection — do not fold into "culture":

- Name, role, source links
- Observation-only findings (posts, talks, tenure)
- **Do-not-imply** list for the letter (no fabricated familiarity)
- Salutation recommendation (named vs Dear Hiring Team)

### Hook candidates

For each candidate:

- One-line summary
- Primary source link + published date
- Adequacy note (strong / adequate / weak)
- Why it maps to the candidate's experience from `resume.md`

### Gaps / conflicts / do-not-cite

- Facts that could not be verified
- Conflicting numbers or dates
- Items to avoid implying in interview

### Checkpoint mode recommendation

State **Mode 1**, **Mode 2**, or **Mode 3** with rationale:

| Mode | When |
|------|------|
| 1 — Insufficient | Gaps block a credible hook; more research or user context needed |
| 2 — Clear lead | One hook clearly strongest; ask user to confirm/correct/veto |
| 3 — Alternatives | 2+ adequate hooks; user picks |

### Location close (proposed)

Present at hook checkpoint; user must confirm before drafting
([location.md](./location.md)):

- **Proposed line:** exact sentence for the close, or `omit`
- **Home base:** from `master.md` / `notes.md` `**Home base:**`
- **Job city:** from `job-spec.md`
- **Resume YAML `location`:** value from `resume.md` — label **header only; do not auto-use in letter**

## Post-draft appendix (optional)

Append after letters are drafted:

### Cover letter claims → sources

Table: what each letter says about the **company** → verify link → published date.

### Your claims → resume source

Table: experience claims → `resume.md` section/bullet.

### Interview prep angles

Likely questions bridging company research ↔ CV experience.

## Related

- Full research protocol: [research.md](./research.md)
- Location close rules: [location.md](./location.md)
- Audit trail shape: `examples/e2e/software-engineer/company-research.md`
