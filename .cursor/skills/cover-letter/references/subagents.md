# Reference: Cover letter subagents

Readonly subagents provide **independent** subjective verification. The parent
agent spawns them via the Task tool. See `.cursor/agents/cover-letter-*.md`.

## Overview

| Agent | Phase | Workflow step | Question |
|-------|-------|---------------|----------|
| [cover-letter-research-auditor](../../../agents/cover-letter-research-auditor.md) | Research | 5b (new), hook change (update) | Is research good enough to checkpoint? |
| [cover-letter-company-claims-auditor](../../../agents/cover-letter-company-claims-auditor.md) | Submission | 10b / 6b | Is everything **about them** true? |
| [cover-letter-experience-auditor](../../../agents/cover-letter-experience-auditor.md) | Submission | 10b / 6b | Is everything **about me** true? |
| [cover-letter-style-auditor](../../../agents/cover-letter-style-auditor.md) | Submission | 10b / 6b | Does it read well for this **voice**? |

**Two phases:** research before drafting; submission suite after voice selection,
before PDF build. Do **not** run submission auditors on all three variants at
pre-present (step 9).

---

## Phase A — Research auditor (step 5b)

### When

After `company-research.md` is written and `research-summary.md` drafted,
**before** the research checkpoint digest.

### Blocking

- **FAIL** on R1 (hook traceability) or R2 (source tier) → fix research (step 4)
  or present gaps; **no checkpoint** until resolved
- **WARN** → include in checkpoint digest; user may proceed
- **PASS** → proceed to checkpoint

### Context bundle

```text
Use cover-letter-research-auditor (foreground, readonly).

Role path: roles/<company-slug>/<role-slug>

Read from disk only:
- roles/<company-slug>/<role-slug>/company-research.md
- roles/<company-slug>/<role-slug>/research-summary.md
- roles/<company-slug>/<role-slug>/job-spec.md
- .cursor/skills/cover-letter/references/research.md

Return the full structured report per your output schema. Do not edit files.
```

### Logging

Append to `notes.md` → `## Cover letter`:

```markdown
**Research audit:** PASS | WARN | FAIL (YYYY-MM-DD)
```

---

## Phase B — Submission suite (step 10b / 6b)

### When

- `Selected voice` recorded in `notes.md`
- Selected file passes `./template/check-cover-letter.sh <role-dir>` (no
  `--all-variants`)
- **Before** `./template/cover-letter-build.sh`

### Blocking

Fix all auditor **FAIL** before PDF build. **WARN** may be accepted if recorded
in `submission-audit.md`.

### Scope

`cover-letter-<selected-voice>.md` **only** — never all three variants.

### Context bundle

Spawn **three Task calls in one parent message** (parallel, foreground,
readonly):

```text
Role path: roles/<company-slug>/<role-slug>
Selected voice: <voice>
Selected file: roles/<company-slug>/<role-slug>/cover-letter-<voice>.md

Do not include parent drafting rationale from this conversation.
```

**Company-claims auditor** — read:

- Selected letter
- `company-research.md`, `research-summary.md`, `job-spec.md`

**Experience auditor** — read:

- Selected letter
- `resume.md`, `master.md`, `notes.md` (`**Location close:**`, mapping), `job-spec.md`
- `.cursor/skills/cover-letter/references/location.md` (dimension E7)

**Style auditor** — read:

- Selected letter
- `notes.md` (selected voice, close mode, `**Location close:**`)
- `references/structure-and-voices.md`, `ai-writing-tropes.md`, `close.md`,
  `location.md`, `banned-words.md`

### Artefact

Write `roles/<company-slug>/<role-slug>/submission-audit.md`:

```markdown
# Submission audit — <company> / <role>

**Date:** YYYY-MM-DD
**Selected voice:** professional
**File:** cover-letter-professional.md
**Overall:** PASS | WARN

## Auditor verdicts

| Auditor | Overall | Notes |
|---------|---------|-------|
| company-claims | | |
| experience | | |
| style | | |

## Issues fixed this pass

-

## Open warnings (accepted)

-
```

Log one line in `notes.md` → `## Cover letter iteration` including
`Submission audit: PASS|WARN`.

---

## Task tool unavailable — fallback

1. Run the relevant sections of [verification.md](./verification.md) manually
2. Append to `notes.md`:

```markdown
Subagent audit skipped (Task tool unavailable) — YYYY-MM-DD
```

3. Continue workflow; do not block indefinitely on platform limits

---

## Partial re-run matrix (update workflow)

| Change type | Re-run |
|-------------|--------|
| Typo, punctuation, thanks wording | `./template/check-cover-letter.sh` only |
| Hook or company fact | Research auditor (if sources changed) + **company-claims** |
| CV bullet, metric, tech claim | **experience** only |
| Tone, close, structure, voice | **style** only |
| User says "ready to submit" after substantive edit | **Full submission suite** (all three) |

---

## Anti-patterns

- Passing parent chat history or drafting rationale to subagents
- Running submission suite on all three variants before voice selection
- Skipping submission suite because mechanical check passed
- Accepting summary-only subagent output — require full output schema
