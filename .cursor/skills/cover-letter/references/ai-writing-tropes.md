# Reference: AI writing tropes to avoid

Self-check every cover-letter draft against this list before presenting it
to the user. These are the recurring tells that make text read as
LLM-generated rather than human-written — compiled from 2026 research on AI
writing detection, recruiter-reported red flags, and catalogued AI prose
patterns. Treat this as a companion to `banned-words.md` (single-word
blacklist) — this file covers phrases, sentence structures, formatting, and
tone-level patterns that a word-blacklist alone won't catch.

## 1. Stock cover-letter openers and closers (highest priority — recruiter-flagged)

These are reported as the single most reliable signals recruiters use to
fast-reject a letter. Never use any of these, or close paraphrases:

- "I am writing to express my interest in the [role] position at [company]"
- "I am excited about the opportunity to contribute to your team"
- "I believe I would be a great fit for this role"
- "I am a hard-working, detail-oriented professional"
- "Throughout my career, I have honed my skills in..."
- "I have a proven track record of..."
- "I am confident that my skills and experience make me an ideal candidate"
- "I look forward to hearing from you" / "I look forward to the opportunity
  to discuss further" (as a closer with no concrete next step attached)
- Any opener that restates the job title and company name as its first move

**Fix:** open with something specific to this company/role (see
`structure-and-voices.md`); close with substantive confirmed interest per
[close.md](./close.md) — not passive hope, and not a call/interview offer
unless mode B is explicitly chosen.

## 2. Overused vocabulary

Tiered enforcement via `template/cover-letter-banned-patterns.txt` and
`check-cover-letter.sh`:

| Tier | Section | Rule |
|------|---------|------|
| **Hard** | `[HARD]`, `[PHRASE]` | Any match → automatic fail |
| **Soft** | `[SOFT]` | One hit in the whole letter is OK; **two or more** soft hits → fail |

A single mild word (e.g. "robust") is not fatal. Two soft hits — whether
two different mild words or the same word twice — is a signal to rewrite.

**Lists:** see `cover-letter-banned-patterns.txt` — do not duplicate here.

## 3. Sentence-structure tropes

| Trope | Pattern | Why it reads as AI |
|---|---|---|
| Negative parallelism | "It's not X — it's Y" / "Not because X, but because Y" | Manufactures false profundity; one human writer in a hundred reaches for this naturally, AI reaches for it constantly |
| Triple negation reveal | "Not X. Not Y. Just Z." | Dramatic countdown formula, never how people actually talk about their own work |
| Rhetorical Q&A | "The result? Faster delivery." | AI asks a question nobody posed, then answers it for effect |
| Tricolon abuse | Three (or more) parallel clauses in a row, repeated across the letter | A single rule-of-three can land; three rule-of-threes in one letter is a pattern, not a style |
| Anaphora abuse | Repeating the same sentence opener several times in a row ("I led... I built... I delivered...") | Fine once; monotonous and robotic by the third repetition in a short letter |
| False ranges | "From debugging to deployment to culture change" | Implies a spectrum that isn't real; a list dressed up as a journey |
| "Serves as" dodge | "My background serves as a strong foundation for..." | Avoiding a plain "is"/"gave me" in favour of a fancier copula |
| Superficial -ing tack-on | "...reflecting my commitment to excellence" | An empty participial clause bolted onto a sentence to manufacture significance |

**Fix:** write the way Dan would actually say it out loud to a colleague —
plain subject-verb-object, no rhetorical theatrics.

## 4. Punctuation and formatting tells

- **Em dash overuse.** Max **two** per letter (~300 words). Prefer a comma,
  full stop, or parenthesis instead.
- **Bold-first bullets.** Don't use bullets in a cover letter at all — it's
  prose, not documentation. If a draft starts reaching for bullet points,
  that's a sign it's drifting into "AI README" mode.
- **Unicode arrows / smart-quote artefacts** (`→`, curly quotes pasted from
  a generator). Plain typing only.
- **Listicle-in-a-trench-coat.** "The first reason... The second reason...
  The third reason..." dressed up as paragraphs. If the letter has this
  shape, restructure into real connected prose.
- **Perfectly uniform sentence length and zero contractions.** Flawless,
  unvarying sentence rhythm with no contractions reads as machine-smoothed.
  Real prose has some short sentences, some longer ones, and contractions
  where Dan would naturally use them ("I'd", "didn't").

## 5. Paragraph- and composition-level tells

- **The signposted conclusion** — "In conclusion," "To sum up." A cover
  letter is three short paragraphs; it doesn't need to announce that it's
  ending.
- **"Despite its challenges" formula** — acknowledging a difficulty only to
  immediately wave it away with a tidy, optimistic bow. Real accounts of
  problems are messier than that.
- **Fractal summaries** — restating what's about to be said, then restating
  what was just said. A 300-word letter has no room for this and it never
  belongs in one anyway.
- **Dead metaphor beating** — introducing one metaphor and then running it
  into the ground across every paragraph.
- **Historical/analogy stacking** — "Just as Stripe simplified payments and
  AWS simplified infrastructure, this role simplifies..." Borrowed
  authority instead of an actual claim about Dan.
- **One-point dilution** — making a single claim and then restating it three
  different ways to sound substantial. Say it once, with the metric, and
  move on.
- **Vague attribution** — "Industry reports suggest..." with no named
  source. A cover letter should only ever cite Dan's own
  research-confirmed facts (see `research.md`), never invented authorities.
- **Grandiose stakes inflation** — treating an individual contributor role
  as a world-historical mission. Keep the stakes proportionate to an actual
  job application.
- **Invented concept labels** — coining faux-analytical compound nouns
  ("the velocity gap", "the integration trap") to sound more rigorous than
  the underlying claim supports.

## 6. Tone tells

- **"Let's break this down" / "Let's unpack this"** — a pedagogical voice
  that has no place addressing a hiring manager.
- **"Here's the kicker" / "Here's the thing" / "Here's what most people
  miss"** — manufactured suspense before an unremarkable point.
- **"Imagine a world where..."** — futurist invitation rhetoric, wildly out
  of register for a job application.
- **"Think of it as..." patronizing analogies** — assumes the reader needs
  a metaphor to understand a straightforward fact about Dan's experience.
- **False vulnerability** — performative humility or self-deprecation that
  reads as a rhetorical move rather than something genuine.
- **"The truth is simple" / unearned certainty** — asserting clarity instead
  of just being clear. If the point is obvious, it won't need the label.

## 7. Self-check heuristics (apply before presenting any draft)

1. Read it aloud. If it sounds like a script rather than something Dan would
   say in a conversation, rewrite the sentence.
2. Count em dashes — more than **two** in a ~300-word letter, revise.
3. Run `./template/check-cover-letter.sh` — word/phrase hits are automatic rewrites.
4. Scan for structural tropes in section 3 — if present, rewrite.
5. Check for back-to-back tricolons or repeated sentence openers (anaphora).
6. Confirm every sentence-length isn't suspiciously uniform — vary it.
7. Confirm no claim is attributed to an unnamed "industry" or "research" —
   every fact must trace to `master.md`, the tailored `resume.md`, or
   user-confirmed `company-research.md`.
8. Confirm the letter doesn't summarize itself at the start or end
   (no "In this letter I will..." / "In conclusion...").
9. If in doubt, prefer the simpler, blunter sentence over the more
   "polished" one — over-polish itself is now a recognized AI tell.
