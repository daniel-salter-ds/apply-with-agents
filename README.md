# Resume repository

Agentic pipeline: markdown CVs → AltaCV PDFs; optional cover letters. One folder per job application under `roles/<company-slug>/<role-slug>/`.

**New here?** Read [SETUP.md](SETUP.md). **First step:** invoke **`/setup`** in your agent.

## Quick start

```bash
./scripts/setup.sh                              # once per machine
# In agent chat: /setup                         # first run — profile + master.md
# In agent chat: /resume with job URL           # tailor CV
./scripts/build.sh roles/acme/staff-backend     # PDF output
# In agent chat: /cover-letter                  # after resume exists
```

## Skills (`.agents/skills/`)

| Skill | When |
|-------|------|
| `/setup` | First run — profile + `master.md` |
| `/master` | Add or update experience |
| `/resume` | Tailor CV for a job |
| `/cover-letter` | Research + letter variants |

Agent entry point: [AGENTS.md](AGENTS.md). Claude Code: [CLAUDE.md](CLAUDE.md) imports it.

## Repository layout

```text
config/                 # user-editable settings (see profile.example.yaml)
master.template.md      # skeleton; /setup writes master.md (gitignored)
examples/e2e/           # synthetic format examples
roles/_template/        # scaffold for new applications
scripts/                # build, setup, checks
render/                 # AltaCV LaTeX + pandoc templates
.agents/skills/         # agent workflows
.agents/agents/         # cover-letter auditor subagents
```

Personal files (`master.md`, `config/profile.yaml`, and your `roles/*/` applications) are gitignored.

## Build commands

```bash
./scripts/new-role.sh acme staff-backend --url "https://..."
./scripts/build.sh roles/acme/staff-backend
./scripts/cover-letter-build.sh roles/acme/staff-backend professional
./scripts/check-cover-letter.sh roles/acme/staff-backend
```

Submission PDFs: `{Name}-{Role}-resume.pdf` from YAML in `resume.md`.

## Format examples

- `examples/e2e/software-engineer/` — technical role shape
- `examples/e2e/operations-leader/` — leadership / COO shape

Paths in `config/examples.yaml`.

## Documentation

- [SETUP.md](SETUP.md) — non-technical onboarding
- [BUILD.md](BUILD.md) — build mechanics
- [DESIGN.md](DESIGN.md) — architecture
- [roles/README.md](roles/README.md) — role folder naming

## Troubleshooting

| Problem | Fix |
|---------|-----|
| Agent says run `/setup` | Missing `master.md` or `config/profile.yaml` |
| `latexmk not found` | `./scripts/setup.sh`, check PATH |
| `pandoc not found` | `brew install pandoc` |
| Cover letter check fails | `./scripts/check-cover-letter.sh roles/X` |
