# Workflow: Update existing role

## 1. Read context

For `roles/<company-slug>/<role-slug>/`:

- `AGENTS.md` and `notes.md` **Active application** — confirm scope; do not read other `roles/*/` folders
- `job-spec.md`
- `notes.md`
- Current `resume.md`

Follow `roles/AGENTS.md`.

## 2. Short interview

What changed?

- New JD emphasis or keywords
- Feedback from prior PDF
- Length or layout preferences
- Sub-section order or terminology

## 3. Edit `resume.md`

Same drafting rules as [new-role.md](./new-role.md) step 7 (including master sync and location). Update `notes.md` with new decisions.

## 4. Build

Follow [build.md](./build.md).

## 5. Verify

Follow [references/verification.md](../references/verification.md).

## 6. Layout pass (after build)

Follow [layout.md](./layout.md). Check page count against `config/resume.defaults.yaml` → `pages` (or `notes.md` override), final-page bottom gap (≤ 5%), and breaks; ask the user whether the layout looks OK before iterating.

## 7. Offer iteration

Summarise diff; ask if another pass.
