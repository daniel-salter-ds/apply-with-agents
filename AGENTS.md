# Agent instructions — resume repository

Agentic resume and cover-letter pipeline. Markdown in role folders → AltaCV PDF via `scripts/build.sh`.

## First run

If `config/profile.yaml` or `master.md` is missing, route the user to **`/setup`** before `/resume` or `/cover-letter`.

## User communication

Read `audience.technical_level` from `config/profile.yaml` and follow
[.agents/references/audience-comms.md](.agents/references/audience-comms.md).
Default to plain language and **skills** (`/resume`, etc.) — not shell commands —
unless the user is clearly technical.

## Build commands

```bash
./scripts/setup.sh                                    # once per machine
./scripts/new-role.sh <company> <role> --url "..."   # scaffold application
./scripts/build.sh roles/<company>/<role>             # resume PDF
./scripts/cover-letter-build.sh roles/<company>/<role> professional
./scripts/check-cover-letter.sh roles/<company>/<role>
```

## User-configurable settings

All editable preferences live in **`config/`** — profile, locale, resume defaults, cover-letter defaults, banned patterns. See `config/profile.example.yaml`.

## Skills

| Skill | Purpose |
|-------|---------|
| `/setup` | First-run onboarding — profile + master.md |
| `/master` | Update canonical experience library |
| `/resume` | Tailor CV for a job |
| `/cover-letter` | Research + letter variants |

Skills live in `.agents/skills/`. Format examples: `config/examples.yaml`.

## Role folder rules

When working under `roles/` or `examples/e2e/`, read **`roles/AGENTS.md`**.

## Facts

- **`master.md`** — sole source for employers, dates, metrics
- Never use other application folders as tailoring input

## Spelling

Per `config/locale.yaml` (default: en-GB).
