# Reference: Cover letter close

Companion to [structure-and-voices.md](./structure-and-voices.md) (skeleton)
and [ai-writing-tropes.md](./ai-writing-tropes.md) (banned stock closers).

The final paragraph confirms fit — it does **not** need to ask for an
interview. Applying with a tailored letter already expresses interest; in
enterprise and regulated hiring, explicitly proposing a call can read as
trying to set the pace of a process that is not the candidate's to set.

## Close modes

Choose one mode per role; record in `notes.md` under `## Cover letter mapping`
as **`Close mode:`** and surface to the user at presentation (see
`new-cover-letter.md` step 10).

| Mode | Label | When to use | What to write |
|------|-------|-------------|---------------|
| **A** | Substantive close | **Default** — enterprise, regulated, formal ATS, senior technical | Specific interest; logistics; company tie; **brief thanks**. **No call ask.** |
| **B** | Light invitational | Startup, small team, or user requests warmer tone | Mode A + one openness line (e.g. "happy to go deeper on X"). **No scheduling.** |
| **C** | Directive | **Never** | "I'll call Wednesday", "expect to hear from you", "look forward to discussing at your convenience". |

**Default for this repo:** mode **A**. Use mode B only when the user opts in
or company research shows an informal, founder-led process.

## Gratitude vs invitation vs directive

| Type | Example | Default |
|------|---------|---------|
| **Gratitude** | "Thank you for considering my application." | **Include** in mode A (one short clause before sign-off) |
| **Logistics** | "I am in Utrecht and can work hybrid in Amsterdam." | Include when JD-relevant |
| **Invitation** | "I'd welcome a conversation", "happy to discuss at your convenience" | **Omit** unless mode B and user opted in |
| **Directive** | "I'll call you Wednesday" | **Never** |

Gratitude is **not** a call to action and does not reopen presumptuousness.

## Availability is not an invitation

Logistics (location, hybrid, notice period) count as close content. Do
**not** treat missing "I'd welcome a conversation" as a failed close when
interest, logistics, company tie, and thanks are present.

## Mode A — substantive close (default)

Four elements, in order:

1. **Specific interest** — this squad, platform, or production standard
   (from `company-research.md`), not generic enthusiasm.
2. **Logistics** — use recorded `**Location close:**` from `notes.md`
   ([location.md](./location.md)); omit if user chose `omit`. **Never** copy
   resume YAML `location` unless it matches the confirmed line.
3. **Company tie** — one research-backed link between their model and your
   work (optional if already strong in body; do not restate the hook).
4. **Brief thanks** — e.g. "Thank you for considering my application."

**Do not** in mode A:

- Offer or propose a call, screen, or interview
- Use passive hope as the main close ("I hope to hear from you")
- Insert skill-gap disclosures mid-body unless the JD stresses that stack
  (see [Honest gaps](#honest-gaps-in-letter-vs-interview))

### Example (enterprise / regulated)

> I want to join the Analytics Engineering CoE squad building on ING's
> existing platform, not reinventing it. I am in Utrecht and can work hybrid
> in Amsterdam. ING's agentic mortgage assistant keeps a human on every
> final decision while scaling from its March pilot; that is the production
> standard I have been working to. Thank you for considering my application.

No call ask. Interest + logistics + company tie + thanks = complete close.

## Mode B — light invitational (opt-in)

Same as mode A (including thanks), plus one optional openness line:

> Happy to go deeper on how we constrained agent tool surfaces in production.

Still **no** scheduling language ("available this week", "let's schedule a call").

## Mode C — directive (never)

Ban entirely. See [banned-words.md](./banned-words.md) and
`ai-writing-tropes.md` §1.

## Voice variants and the close

Professional, conversational, and bold differ in **diction and rhythm** —
not in whether they ask for a call. All include thanks in mode A unless the
user explicitly opts out.

## Honest gaps: in letter vs interview

| Situation | Default |
|-----------|---------|
| Gap not stressed in JD (e.g. GCP when depth is AWS/Azure) | **Omit from letter**; note in `notes.md` for interview prep |
| JD explicitly requires the gap skill | Brief honest line in close or body — one sentence, not mid-paragraph interruption |
| User asks to disclose | Follow user; record in `notes.md` |

## Body depth vs breadth (related, not close)

The close is separate from body achievement density. Use **2–3 proof threads
maximum** in the body (one body paragraph = prefer **2** deep threads).
If the mapping table has more rows, **choose** the strongest for prose; log
the rest in `notes.md` for interview prep. Do not cram four+ systems into one
paragraph.

## Quick checklist

- [ ] Close mode recorded in `notes.md` and stated to user at presentation
- [ ] `**Location close:**` recorded in `notes.md` before drafting ([location.md](./location.md))
- [ ] Logistics in letter matches `**Location close:**` verbatim (or absent if `omit`)
- [ ] Logistics does not contradict `master.md` home base
- [ ] Specific interest in this role/squad (not generic)
- [ ] Brief thanks before sign-off (mode A/B default)
- [ ] No call/interview offers (modes A and B)
- [ ] No passive-hope sole closer
- [ ] Skill gaps omitted from letter unless JD-stressed or user requested
- [ ] Sign-off: `Kind regards` / `Best regards` + blank line + typed name
