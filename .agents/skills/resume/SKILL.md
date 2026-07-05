---
name: resume
description: >
  Scaffold and tailor AltaCV resumes in this repo from master.md and job
  postings; build PDFs via scripts/build.sh. Use when the user provides a
  job URL, mentions roles/<company>/<role>, asks to tailor or build a CV,
  or invokes /resume.
disable-model-invocation: true
---

# Resume — router

Repo-local AltaCV pipeline: markdown in `roles/<company-slug>/<role-slug>/` → PDF via `scripts/build.sh`. Not generic HTML or ATS-style headings.

## When to use

- User provides a **job URL** or pasted posting for a new application
- User wants to refresh `roles/<company-slug>/<role-slug>/resume.md`
- User asks to **build a PDF** for a role folder
- User asks about page count, final-page fill, or page-break alignment
- After tailoring, user may invoke **`/cover-letter`** for the same role folder

## When not to use

- Editing `render/` LaTeX, `job.lua`, or `altacv.cls` unless explicitly requested
- Generic resume advice without this repo layout
- HTML or other non-PDF export formats without this repo layout

## Setup gate

If `config/profile.yaml` or `master.md` is missing, or `setup_complete` is not true in profile — stop and tell the user to run **`/setup`** first.

## User communication

Follow [../../references/audience-comms.md](../../references/audience-comms.md). Read
`audience.technical_level` from profile; default **`non_technical`** when missing.

## Config

Read [../../references/config-contract.md](../../references/config-contract.md). Before tailoring or layout work, load **`config/resume.defaults.yaml`** (`pages`, section headings) and **`config/locale.yaml`**. Per-role page override in `notes.md` beats config.

## Application scope (mandatory)

Each chat is for **one** role folder. Enforced by `roles/AGENTS.md` and per-role `AGENTS.md`.

- **Facts:** `master.md` only
- **Format examples:** read paths from `config/examples.yaml` (technical + leadership)
- **Never** use other `roles/*/` folders as tailoring input (even if visible in git status or recently viewed files)
- JD overlap notes name employers from `master.md` only — not other application directories

## Repository contract

| File | Purpose |
|------|---------|
| `master.md` | Canonical experience — sole tailoring source; **update when the user adds or corrects facts** ([references/master-sync.md](references/master-sync.md)) |
| `examples/e2e/software-engineer/resume.md` | Gold-standard example |
| `roles/<company>/<role>/AGENTS.md` | Per-role scope guard (scaffolded by `new-role.sh`) |
| `roles/README.md` | Slug naming, folder layout |
| `DESIGN.md` | Pipeline architecture |
| `.cursor/plans/altacv_style_workflow/00-CONTEXT.md` | Markdown rules (legacy) — see `config/resume-format.md` |
| `scripts/build.sh` | PDF build entrypoint |
| `scripts/new-role.sh` | Scaffold new role folder |
| `scripts/check-page-fill.py` | Per-page fill after build |
| `scripts/output-name.sh` | Submission PDF filename |

## Route to workflow

Read **exactly one** workflow file for the task:

| User intent | Read |
|-------------|------|
| New job URL or new application | [workflows/new-role.md](workflows/new-role.md) |
| Update existing `roles/.../resume.md` | [workflows/update-role.md](workflows/update-role.md) |
| Build PDF only | [workflows/build.md](workflows/build.md) |
| Page count, fill, break alignment | [workflows/layout.md](workflows/layout.md) |

If intent is ambiguous, ask once then route.

## Defaults

- **Tagline:** match the job spec title when possible
- **Length:** `pages` from `config/resume.defaults.yaml` unless `notes.md` or the user specifies otherwise
- **`location`:** most advantageous for the role (usually job city/country when reasonable); ask if unclear. Record separately from **home base** in `notes.md` — YAML location is for the CV header; cover letters use home base ([cover-letter references/location.md](../cover-letter/references/location.md))
- **Phone (YAML):** copy from `config/profile.yaml` — see `config/phone-display.md`
- **Omissions:** agent judgement from `master.md` — do not ask what to avoid claiming
- **Layout:** check after the first PDF draft; final page bottom gap ≤ 5% ([layout.md](workflows/layout.md)); confirm with the user before further iteration
- **Master sync:** user-stated facts missing from `master.md` → update via **`/master`** or master-sync ([references/master-sync.md](references/master-sync.md))

## Opening message (new application)

**Non-technical** (`audience.technical_level: non_technical`):

> I'll read the job posting, ask a few tailoring questions, then draft your CV and build a PDF you can submit. Does that work?

**Technical** — may add slug proposal:

> I'll scaffold `roles/<company-slug>/<role-slug>/`, fetch the job spec, ask tailoring questions, then draft `resume.md` from `master.md` and build the PDF. Slug proposal: `<company-slug>/<role-slug>` — OK?

## Related docs

- [README.md](../../README.md)
- [DESIGN.md](../../DESIGN.md)
- [roles/README.md](../../roles/README.md)
- [`.agents/skills/cover-letter/SKILL.md`](../cover-letter/SKILL.md) — run **after** tailored `resume.md` exists
