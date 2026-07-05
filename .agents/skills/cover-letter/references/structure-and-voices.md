# Reference: Cover letter structure and voice variants

Companion to `research.md`, `banned-words.md`, `close.md`, and
`ai-writing-tropes.md`.
This file specifies the shape every draft must follow, then how
Professional / Conversational / Bold differ within that shape. Structure
is fixed across all three variants — voice changes word choice, sentence
rhythm, and risk tolerance, not the skeleton.

## Overall shape

| Property | Target |
|---|---|
| Length | 250-350 words total, one page |
| Paragraphs | 3 (4 only for senior/staff-level roles, and only if paragraph 4 adds genuinely new proof rather than restating) |
| Salutation | Named person if findable in research; otherwise "Dear Hiring Team"; "Dear Hiring Manager" only as a last resort |
| Sign-off | "Kind regards" / "Best regards" works across nearly all registers — default to it unless a voice calls for something else (see below) |

| Paragraph | Role | Length |
|---|---|---|
| 1 — Hook | Earn the next 10 seconds; must be unique to this company/role | 3-5 sentences |
| 2 (-3) — Body | Prove fit with achievement(s) mapped to JD requirements | 4-8 sentences each |
| Final — Close | Substantive close (see `close.md`); no restated content | 2-4 sentences |

Hiring managers report the introduction as the single most impactful part
of the letter — most of the available attention budget is spent there, so
the hook paragraph deserves disproportionate iteration relative to its
length.

## Paragraph 1 — the hook

The hook must fail the "could this be pasted into a letter for a different
company applying to a similar role" test — if it would survive that swap,
rewrite it. Never open with a restatement of the job title and company
name as the first move (see `ai-writing-tropes.md` §1 for the banned stock
openers).

Use whichever of these fits the confirmed research best — they're listed
in rough order of strength when genuinely available, weakest fallback last:

1. **Achievement lead.** Open with the single most relevant quantified
   result, stated plainly, then connect it to what the role needs. Works
   when there's a strong, directly-relevant metric in `resume.md`.
2. **Problem-solution hook.** Name a real, specific challenge the company
   is visibly facing (from `company-research.md` — a stated technical
   problem, a scaling challenge, a gap revealed by the JD) and connect it
   to direct experience solving exactly that.
3. **Personal connection / referral.** Only when genuinely true — a real
   mutual contact, a real prior interaction. Never implied or invented.
4. **Strategic insight.** A specific, accurate observation about the
   company's product, market position, or recent move (from
   `company-research.md`) that demonstrates real engagement, not a
   skimmed-headline reference.
5. **Mission/values alignment.** Use sparingly and only with a specific,
   current detail (a stated value tied to a concrete decision they made) —
   generic "I admire your innovative culture" framing is exactly the
   pattern that reads as AI-written and should never appear.

Every hook must trace to a confirmed fact in `company-research.md` or a
genuine achievement in `resume.md`/`master.md` — never invented context,
never a fabricated personal connection.

## Paragraph 2 (and optional 3) — the body

This is where the achievement-to-requirement mapping from the resume stage
gets spelled out in prose, not restated as a resume bullet:

- Use **2–3 proof threads maximum** in the body (prefer **2** deep threads in
  a single body paragraph). If the mapping table has more rows, choose the
  strongest; log others in `notes.md` for interview prep.
- Lead with the strongest mapped achievements; state the result first, then
  enough mechanism to make the proof credible.
- After each thread, when the JD link is not obvious, add **one explicit
  connector clause** — e.g. "that maps to your posting's …" or "the same
  governance bar your …" — do not leave the reader to infer.
- Tie each achievement explicitly to a requirement or theme in the JD.
- If using two body paragraphs, give each a distinct angle (e.g. one
  technical depth achievement, one cross-functional/ownership achievement)
  rather than two similar wins.
- Show, don't assert — replace any unverifiable adjective ("hard-working",
  "detail-oriented") with the evidence that would make a reader conclude it
  themselves.
- This is also where a company-specific detail from research can recur
  briefly (e.g. naming their actual tech stack or product) to reinforce
  that paragraph 1 wasn't a one-off — but don't force a second research
  reference if it doesn't fit naturally.

## Final paragraph — the close

Full rules: [close.md](./close.md). Summary:

**Default (mode A — substantive close):** specific interest; logistics;
company tie; brief thanks. **No ask for a call.**

**Never use:** passive hope as the sole close ("I hope to hear from you",
"I look forward to hearing from you"); directive scheduling ("I'll call
Wednesday"); call or interview offers ("available for a call", "let's
discuss at your convenience").

**Availability ≠ invitation:** stating where you are based and hybrid
fit **counts** as close content; it is not a missing CTA.

Match formality to company culture; never default to humour regardless of
voice.

## Letter markdown vs PDF layout

`cover-letter-*.md` is **body only** — salutation through sign-off. Do not
include the contact header or date; PDF build injects those from sibling
`resume.md` YAML (see [pdf-layout.md](./pdf-layout.md)).

Sign-off in markdown — blank line between closing phrase and typed name:

```markdown
Kind regards,

Alex Chen
```

## The three voice variants

All three share the same hook material, the same mapped achievements, and
the same structural skeleton above. They differ only in these dimensions:

| Dimension | Professional | Conversational | Bold |
|---|---|---|---|
| **Best fit** | Enterprise, consulting, regulated/compliance-heavy, larger established companies | Startups, smaller product teams, product-led companies | Crowded applicant pools, roles where a distinctive voice is itself a credible signal of fit |
| **Salutation** | Named person or "Dear Hiring Team" | Named person preferred; first name acceptable if research shows the company's own tone is informal | Named person strongly preferred — a generic salutation undercuts a bold letter |
| **Hook risk** | Achievement lead or strategic insight — measured, evidence-first | Achievement lead or problem-solution hook, slightly more first-person and direct | Problem-solution or strategic insight with a sharper, more declarative opening sentence — still grounded in real research, never gimmicky |
| **Sentence rhythm** | Slightly longer, fully formed sentences; minimal contractions | Shorter sentences, natural contractions ("I'd", "didn't"), reads like speech | Punchier, more sentence-length variation; confident, declarative statements — but must still avoid the structural tropes in `ai-writing-tropes.md` (no tricolon abuse, no negative-parallelism "it's not X, it's Y") |
| **Close** | Mode A: substantive interest + logistics + company tie | Same substance; warmer diction; **no call offers** | Same substance; sharper tone; **no call offers** |
| **Sign-off** | "Kind regards" / "Best regards" | "Best" / "Best regards" | "Best regards" — bold voice lives in the body and close content, not the sign-off |

None of the three should ever drift into a separate register from the
other two on substance — they are the same case, argued with a different
voice. If a reader compared all three side by side, the facts, achievements,
and research references should be identical; only word choice and rhythm
should differ.

## Quick checklist before presenting a draft

- [ ] Total length 250-350 words
- [ ] Hook fails the "could be pasted elsewhere" test — i.e. it's specific
- [ ] Hook traces to a confirmed `company-research.md` fact or `resume.md`
  achievement
- [ ] At least 2 quantified proof markers in body (see [verification.md](./verification.md)); max 3 threads
- [ ] Close per [close.md](./close.md) (default mode A; logistics ≠ missing CTA)
- [ ] Logistics matches `notes.md` `**Location close:**` ([location.md](./location.md))
- [ ] Salutation uses a name if research found one
- [ ] No paragraph restates content from an earlier paragraph
- [ ] Cross-check against `ai-writing-tropes.md` and `banned-words.md`
  before finalizing any variant
