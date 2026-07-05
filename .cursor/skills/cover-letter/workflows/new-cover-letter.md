# Workflow: New cover letter

Full pipeline from prerequisite validation through presentation.

## 1. Parse request

Extract: role path (or infer from company/title), optional company URL,
optional hiring manager name/LinkedIn.

If role path ambiguous → ask once.

## 2. Validate prerequisites (hard stop)

```bash
ROLE=roles/<company-slug>/<role-slug>
test -f "$ROLE/resume.md" && test -f "$ROLE/job-spec.md" || exit 1
```

**If fail:** tell user to run `/resume` first. Do **not** research or draft.

Append to `notes.md` under `## Cover letter`: started date, company URL,
hiring manager if provided.

## 3. Read context

Read: `resume.md`, `job-spec.md`, `notes.md` (interview themes). Skim
`master.md` for fallback metrics.

Identify ≥3 achievement candidates with quantified outcomes.

Note `resume.md` YAML `location` as **header only** — do not use for letter
logistics until step 6c confirms. See [references/location.md](../references/location.md).

## 4. Deep research

Follow [references/research.md](../references/research.md):

- 8–15 search/fetch calls
- Cross-validation for hook facts; prefer recent primary sources
- Do **not** re-fetch the JD if `job-spec.md` is current
- Write `company-research.md` (shape: gold standard
  `roles/ing/senior-ai-engineer-agentic-ai/company-research.md`)
- Set status: `Checkpoint: pending`

## 5. Write research-summary.md

Follow [references/research-summary-format.md](../references/research-summary-format.md).

Include **recommended checkpoint mode (1/2/3)** with rationale and **proposed
location close** (see location.md).

Do **not** draft letters yet.

## 5b. Research audit (blocking if Task tool available)

Follow [references/subagents.md](../references/subagents.md) § Phase A.

1. Spawn `cover-letter-research-auditor` (foreground, readonly) with context bundle.
2. If **FAIL** on R1 or R2 → return to step 4 or present gaps to user; **no checkpoint** until fixed.
3. If **WARN** → include warnings in checkpoint digest; user may proceed.
4. Log verdict in `notes.md` → `## Cover letter` → `**Research audit:** PASS|WARN|FAIL (date)`.

If Task tool unavailable → note in `notes.md` per subagents.md fallback; continue to checkpoint.

## 6. Research checkpoint (blocking)

Present digest of `research-summary.md` to user.

| Mode | Agent action |
|------|--------------|
| **1 — Insufficient** | List gaps; offer more research or user context; **no drafting** |
| **2 — Clear lead** | One recommended hook; ask confirm/correct/veto |
| **3 — Alternatives** | Present 2+ hook options; user picks |

Wait for user response. Update `company-research.md`:
`Checkpoint: confirmed`, log source statuses, add `## Checkpoint notes`.

Mode 1 → return to step 4 or stop.

## 6c. Location checkpoint (blocking)

**After hook confirmed, before achievement mapping and drafting.**

Follow [references/location.md](../references/location.md):

1. Propose **exact logistics sentence** for the close (or `omit`).
2. State sources: `master.md` home base, `job-spec.md` job city,
   `notes.md` `**Home base:**` / `**Location (YAML):**` if present.
3. Show `resume.md` YAML `location` labelled **header only — not for letter**.
4. Ask user: **confirm / correct / omit**.
5. Record verbatim in `notes.md` → `## Cover letter`:

```markdown
**Location close:** <exact sentence or omit>
```

**Do not draft** until `**Location close:**` is recorded.

If user corrects home base during `/resume` but `notes.md` is stale, update
`## Interview` and re-propose.

## 7. Achievement mapping

Append `notes.md` → `## Cover letter mapping` (table: achievement → JD
requirement → source).

Record: shared hook, supporting threads, **`Close mode:`** (default A per
[references/close.md](../references/close.md)), **`Location close:`** (from
step 6c), body thread count (2–3 max), depth-vs-breadth note.

## 8. Draft three variants

Follow [references/structure-and-voices.md](../references/structure-and-voices.md),
[references/close.md](../references/close.md), and
[references/location.md](../references/location.md) for the final paragraph.

Use recorded `**Location close:**` verbatim in all three variants, or omit
logistics if user chose `omit`.

Write with HTML comment headers (voice, date, word count):

- `cover-letter-professional.md`
- `cover-letter-conversational.md`
- `cover-letter-bold.md`

Same factual core; voice differs per spec.

## 9. Pre-present self-check (no subagents)

**Scope:** all three variants — mechanical and light parent skim only.

Run [references/verification.md](../references/verification.md) § Pre-present, and:

```bash
./template/check-cover-letter.sh roles/<company-slug>/<role-slug> --all-variants
```

Skim for obvious failures (hook clearly generic, missing salutation). Do **not**
spawn submission-suite subagents here.

Update each file's HTML `words:` comment to match the script's reported count.
Fix mechanical failures before step 10.

Subjective fact-checking and voice polish → step 10b after voice selection.

### 9a. Optional post-draft appendix

Append to `research-summary.md`: "Cover letter claims → sources" section
(see [research-summary-format.md](../references/research-summary-format.md)).

## 10. Present and iterate

Summarise variants; recommend **professional** for enterprise/regulated
contexts (ING-style).

State for the user: **close mode** used (default A), **location close** used
or omitted, body thread count, and whether brief thanks is included.

Ask the user which voice to submit. When they choose, record in `notes.md`
under `## Cover letter`:

```markdown
**Selected voice:** professional   # professional | conversational | bold
**Selected file:** cover-letter-professional.md
**Close mode:** A
```

Until a voice is selected, iteration may touch any variant. **After selection:**
all revisions edit **only** `cover-letter-<selected-voice>.md`; do not drift
the other two files unless the user explicitly switches voice or requests a
full re-draft of all variants.

Submission audit (step 10b) is required before final PDF for application.

## 10b. Submission audit (blocking if Task tool available)

**Prerequisites:** `Selected voice` in `notes.md`; selected file passes:

```bash
./template/check-cover-letter.sh roles/<company-slug>/<role-slug>
```

Follow [references/subagents.md](../references/subagents.md) § Phase B.

1. Spawn in parallel (foreground, readonly):
   - `cover-letter-company-claims-auditor`
   - `cover-letter-experience-auditor`
   - `cover-letter-style-auditor`
2. Context: selected file path only + files listed in subagents.md.
3. Fix all **FAIL** items; resolve or accept **WARN** in `submission-audit.md`.
4. Write `submission-audit.md` in role folder.
5. Re-run mechanical check on selected file.

If Task tool unavailable → manual [verification.md](../references/verification.md)
§ Submission gate + note in `notes.md`.

Do not run 10b on non-selected variants.

## 10c. Build PDF

After submission audit passes (or user approves edits on first selection):

```bash
./template/cover-letter-build.sh roles/<company-slug>/<role-slug> <selected-voice>
```

Record each pass in `notes.md` → `## Cover letter iteration` (include
`Submission audit: PASS|WARN`).

PDF layout: [references/pdf-layout.md](../references/pdf-layout.md); letter markdown is body-only.
