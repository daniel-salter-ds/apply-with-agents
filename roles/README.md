# Roles directory

Applications live under **`roles/<company-slug>/<role-slug>/`**. Each role folder is one job application.

## Workflow

1. **`/setup`** — once: profile + `master.md`
2. **`/resume`** — scaffold (if needed), tailor `resume.md`, build CV PDF
3. **`/cover-letter`** — research, checkpoint, three letter variants

Do **not** invoke `/cover-letter` without tailored `resume.md` and `job-spec.md`.

## Creating a new role

```bash
./scripts/new-role.sh <company-slug> <role-slug> --url "https://..."
./scripts/build.sh roles/<company-slug>/<role-slug>
```

Or invoke **`/resume`** with a job URL — the agent scaffolds and tailors.

## Slug naming

Lowercase, hyphen-separated, both levels:

| Level | Example |
|-------|---------|
| Company | `acme`, `example-co` |
| Role | `staff-backend`, `coo-2026` |

## Standard layout

```text
roles/<company-slug>/<role-slug>/
  resume.md              # required — AltaCV build input
  job-spec.md            # from /resume
  notes.md               # tailoring + cover letter decisions
  AGENTS.md              # per-role scope (scaffolded)
  company-research.md    # cover letter research
  research-summary.md    # checkpoint digest
  cover-letter-*.md      # three voice variants
  submission-audit.md    # post-voice audit record
```

## `_template`

**`roles/_template`** is not an application — copy source for `new-role.sh` only.

## Format examples

See **`examples/e2e/`** and `config/examples.yaml` — not real applications.

## Scope rules

Read **`roles/AGENTS.md`** when editing any file under `roles/`.

## Cleaning artefacts

```bash
./scripts/build.sh roles/<company-slug>/<role-slug> --clean
```
