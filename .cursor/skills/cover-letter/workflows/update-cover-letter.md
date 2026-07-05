# Workflow: Update existing cover letter

Use when `cover-letter-*.md` already exist from a prior new-cover-letter run.

## 1. Read context

For `roles/<company-slug>/<role-slug>/`:

- `company-research.md`
- `research-summary.md`
- `notes.md` — mapping, iteration, **`Selected voice`** (under `## Cover letter`)
- `cover-letter-<selected-voice>.md` only (see step 2)
- `resume.md`, `job-spec.md`
- `submission-audit.md` (if present from prior submission gate)

## 2. Resolve selected voice

Read `notes.md` → `## Cover letter` → **`Selected voice`**.

| State | Action |
|-------|--------|
| **Recorded** | Edit **only** `cover-letter-<voice>.md`. Do not update other variants unless user explicitly switches voice or requests all three re-drafted. |
| **Not recorded** | Ask which voice to use; record per [new-cover-letter.md](./new-cover-letter.md) step 10 before editing. |

To **switch voice:** user confirms new choice → update `Selected voice` in
`notes.md` → edit the new file going forward (copy substance from old file if
helpful; do not auto-sync all three).

## 3. Short interview

What changed?

- Hook emphasis or new research
- Achievement mapping or body emphasis
- Feedback on the selected letter
- JD or resume updates since last draft

## 4. Re-check research staleness

Review published dates on hook facts in `company-research.md`. Re-research if
user requests or key facts are stale/expired.

## 5. Mini-checkpoint on hook change

If the hook changes materially → present updated hook summary; confirm before
redrafting. Update `company-research.md` checkpoint notes.

If logistics change → re-run location checkpoint per
[location.md](../references/location.md): propose line, confirm, update
`**Location close:**` in `notes.md` before editing the letter.

If research files updated materially → run `cover-letter-research-auditor` per
[references/subagents.md](../references/subagents.md) § Phase A before redrafting
the letter.

## 6. Edit selected letter only

Same drafting rules as [new-cover-letter.md](./new-cover-letter.md) step 8
([close.md](../references/close.md), [location.md](../references/location.md)
for final paragraph).

Update HTML comment `generated:` date and `words:` count (must match
`check-cover-letter.sh` output).

Re-run [references/verification.md](../references/verification.md) §
Pre-present (selected file) and:

```bash
./template/check-cover-letter.sh <role-dir>
```

## 6b. Submission audit (when substantive)

After mechanical check passes, run subagent audit per
[references/subagents.md](../references/subagents.md):

| Edit type | Auditors to run |
|-----------|-----------------|
| Typo / punctuation only | Skip — mechanical sufficient |
| Company hook or fact | `cover-letter-company-claims-auditor` (+ research auditor if hook source changed) |
| CV claim or metric | `cover-letter-experience-auditor` |
| Tone, close, structure | `cover-letter-style-auditor` |
| User says ready to submit | **Full submission suite** (all three) |

Update `submission-audit.md` after each audited pass. Fix **FAIL** before PDF build.

## 7. Rebuild PDF (mandatory)

**Prerequisite:** submission audit passed or skipped (typo-only) per step 6b.

After every edit to the selected letter:

```bash
./template/cover-letter-build.sh roles/<company-slug>/<role-slug> <selected-voice>
```

Do not leave the submission PDF stale relative to markdown. See [build.md](./build.md).

## 8. Update notes

Record changes in `notes.md` → `## Cover letter iteration` (include voice,
summary of diff, which auditors ran, `submission-audit.md` updated Y/N, rebuild
confirmed).

## 9. Offer iteration

Summarise diff; ask if another pass.
