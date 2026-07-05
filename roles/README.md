# Roles directory

Applications live under **`roles/<company-slug>/<role-slug>/`**. Each role folder is one job application. Only `resume.md` is compiled to AltaCV PDF; cover letters are plain markdown with optional pandoc PDF. Other files in the folder are optional context (job specs, notes, research, drafts, and so on).

## Application workflow

1. **`/resume`** — scaffold (if needed), tailor `resume.md`, build CV PDF
2. **`/cover-letter`** — deep research, checkpoint, three letter variants (requires tailored `resume.md`)

Do **not** invoke `/cover-letter` without a tailored `resume.md` and `job-spec.md`.

## Creating a new role

From the repository root:

```bash
./template/new-role.sh <company-slug> <role-slug> --url "https://..."
```

Example:

```bash
./template/new-role.sh anthropic applied-ai-architect --url "https://..."
# → roles/anthropic/applied-ai-architect/
```

Then follow [`.cursor/skills/resume/SKILL.md`](../.cursor/skills/resume/SKILL.md) for tailoring with a coding agent, or edit `resume.md` manually and build:

```bash
./template/build.sh roles/<company-slug>/<role-slug>
```

## Slug naming

Use lowercase, hyphen-separated, descriptive slugs for **both** levels:

| Level | Pattern | Example |
|-------|---------|---------|
| Company | short org name | `anthropic`, `google`, `acme` |
| Role | role + optional year | `applied-ai-2026`, `sre`, `staff-backend` |

**Rules:**

- **Company slug** = first directory under `roles/` (not `roles/_template`).
- **Role slug** = subdirectory under the company folder.
- No spaces; avoid ambiguous names (`test`, `new`).
- Lowercase letters, digits, and hyphens only (enforced by `new-role.sh`).

## Standard layout

Every role folder must contain `resume.md`. Everything else is optional.

```text
roles/<company-slug>/
  <role-slug>/
    resume.md              # tailored CV (required — sole AltaCV build input)
    resume.pdf             # generated build artefact (gitignored)
    *-resume.pdf           # submission copy (gitignored)
    job-spec.md            # from /resume (required for cover letter)
    notes.md               # interview + mapping + iteration (includes Active application)
    AGENTS.md              # per-role scope guard (scaffolded by new-role.sh)
    company-research.md    # cover-letter research audit trail
    research-summary.md    # human verify + checkpoint
    cover-letter-*.md      # professional / conversational / bold
    cover-letter-*.pdf     # optional pandoc output (gitignored)
    submission-audit.md    # post-voice subagent audit record (optional until submission gate)
    resume.tex             # generated (gitignored)
    …                      # other optional context
  <other-role-slug>/
    …
```

`new-role.sh` scaffolds `job-spec.md`, `notes.md`, and `AGENTS.md`; add cover-letter files via `/cover-letter`. Only `resume.md` uses the AltaCV build pipeline.

After choosing a voice variant, record **`Selected voice`** in `notes.md`; edit and rebuild only that `cover-letter-<voice>.md` thereafter. Run the submission subagent suite (see `.cursor/skills/cover-letter/references/subagents.md`) before the final PDF.

## `_template` folder

**`roles/_template` is not an application** — do not build or submit it. It is used only as the copy source for `new-role.sh`.

## Existing roles

| Path | Notes |
|------|-------|
| `anthropic/applied-ai-architect/` | Reference tailored CV (Applied AI Architect) |
| `car/senior-ai-software-engineer/` | Senior AI Software Engineer; includes alternate drafts and HTML exports |
| `ing/senior-ai-engineer-agentic-ai/` | Cover-letter gold standard (research + three variants) |
| `dex/founding-senior-product-engineer/` | Founding Senior Product Engineer at Dex; apply via Built In |

Update this table manually as new roles are added.

## Cleaning artefacts

```bash
./template/build.sh roles/<company-slug>/<role-slug> --clean
```

Removes LaTeX auxiliary files and generated `resume.tex` from the role folder.

## Do not

- Run `make` (root Makefile removed — use `template/build.sh`)
- Build from `master.md` directly (`master.md` is a content library, not a build input)
- Invoke `/cover-letter` without tailored `resume.md` and `job-spec.md`
- Build cover letters with `template/build.sh` (use `cover-letter-build.sh`)
- Commit LaTeX auxiliary files (`.aux`, `.log`, etc.)
