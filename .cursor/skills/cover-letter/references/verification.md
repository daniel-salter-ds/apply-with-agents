# Reference: Cover letter verification checklist

Two stages: **pre-present** (step 9, all variants, no subagents) and
**submission gate** (step 10b, selected file, subagent suite). See
[subagents.md](./subagents.md).

---

## Pre-present (step 9 — all variants, no subagents)

Run before presenting draft variants to the user. Mechanical + light parent skim.
Subagents are **not** used at this stage.

### Prerequisites

- [ ] `company-research.md` exists with `Checkpoint: confirmed`
- [ ] `research-summary.md` exists (written before checkpoint)

### Per-variant checks (all three files)

- [ ] Total length 250–350 words — `./template/check-cover-letter.sh --all-variants`
- [ ] HTML `words:` comment matches script output
- [ ] Obvious hook failure (clearly generic opener) — parent skim only
- [ ] Salutation present (`Dear Hiring Team` or named contact)
- [ ] Close logistics matches `notes.md` → `**Location close:**` verbatim, or logistics absent if `omit` ([location.md](./location.md))

Deep subjective checks → submission gate after voice selection.

---

## Submission gate (step 10b — selected file only)

Run after `Selected voice` is recorded and selected file passes mechanical check.
Spawn submission suite per [subagents.md](./subagents.md) § Phase B:

| Concern | Auditor |
|---------|---------|
| Company/role facts | `cover-letter-company-claims-auditor` |
| Experience claims | `cover-letter-experience-auditor` |
| Voice, tropes, close | `cover-letter-style-auditor` |

If Task tool unavailable, run this manual checklist on the **selected file**:

### Structure and voice

- [ ] Three paragraphs (four only for senior/staff if paragraph 4 adds new proof)
- [ ] Hook fails the "could be pasted elsewhere" test
- [ ] **≥2 quantified proof markers** in body; **≤3 proof threads**
- [ ] Each body thread has explicit JD connector when link not obvious
- [ ] No paragraph restates an earlier paragraph
- [ ] Salutation: named person if research found one; else `Dear Hiring Team`
- [ ] Sign-off: `Kind regards` or `Best regards` (voice-appropriate)
- [ ] Close per [close.md](./close.md): mode in `notes.md` (default A)
- [ ] Close logistics per [location.md](./location.md): matches `**Location close:**` or omitted if `omit`
- [ ] Brief thanks before sign-off (mode A); **no call/interview offers**
- [ ] AI tropes: [ai-writing-tropes.md](./ai-writing-tropes.md) §3–7
- [ ] Em-dash count ≤2

### Quantified proof (what counts)

At least **two** of the following in the body:

- Scale markers: "thousands of rows", "600+ page wiki", "enterprise customers"
- Production outcomes: "deployed serving …", "in production", "E2E tests against the deployed system"
- Governance outcomes: "audit trails by construction", "blocks … at compile time"
- Throughput/latency improvements only when present in `resume.md` / `master.md`

Input size alone must be paired with an outcome.

### Factual integrity

- [ ] Company facts trace to `company-research.md`
- [ ] Experience claims trace to `resume.md` / `master.md`
- [ ] Honest gaps omitted from letter; interview prep in `notes.md` if needed
- [ ] No implied hiring-manager familiarity without checkpoint confirm

### Mechanical (selected file)

```bash
./template/check-cover-letter.sh roles/<company-slug>/<role-slug>
```

Write `submission-audit.md` after audit passes.

---

## PDF build (step 10c / update step 7)

- [ ] Submission audit passed or skipped (typo-only edit)
- [ ] `Selected voice` in `notes.md`
- [ ] `./template/cover-letter-build.sh <role-dir> <voice>` succeeds
- [ ] Submission PDF name matches `output-name.sh --cover-letter`
- [ ] Header contact fields match sibling `resume.md` YAML
- [ ] UK long-form date present
- [ ] Layout per [pdf-layout.md](./pdf-layout.md) ATS checklist

## Gold-standard sync

When skill rules change, update `roles/ing/senior-ai-engineer-agentic-ai/` —
see [gold-standard.md](./gold-standard.md).
