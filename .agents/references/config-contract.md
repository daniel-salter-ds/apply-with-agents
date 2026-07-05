# Config contract

User-editable settings live under **`config/`**. Skills and scripts must read
these files — do not hardcode defaults that duplicate them.

## File map

| File | Keys | Used by | Wired |
|------|------|---------|-------|
| `profile.yaml` | `candidate.*`, `audience.technical_level`, `setup_complete` | `/setup`, `/resume`, `/cover-letter`, audience comms | Skills (gitignored) |
| `resume.defaults.yaml` | `pages`, `profile_section`, `skills_section`, `experience_section`, `education_section` | `/resume`, `roles/AGENTS.md`, `resume-format.md` | Skills + `config-read.sh` |
| `cover-letter.defaults.yaml` | `word_count.min/max`, `voices`, `close_mode`, `sign_off`, `salutation_default` | `/cover-letter`, `check-cover-letter.sh`, `cover-letter-build.sh` | Skills + scripts |
| `locale.yaml` | `spelling`, `date_format` | All prose; letter dates | Skills (`date_format` → scripts use UK long via `yaml-fields.sh`) |
| `examples.yaml` | `format_examples.*` | `/resume`, `/cover-letter` | Skills |
| `cover-letter-banned-patterns.txt` | grep tiers | `check-cover-letter.sh`, cover-letter refs | Script |
| `phone-display.md` | display rules | `/resume` YAML `phone` | Skills (doc) |
| `resume-format.md` | markdown rules | Role `resume.md` editing | Skills (doc) |
| `target-role-research.md` | setup research | `/setup`, `/master` | Skills (gitignored) |

## Resume defaults (`config/resume.defaults.yaml`)

Read at the start of tailoring or layout work:

| Key | Purpose |
|-----|---------|
| `pages` | Target CV page count (default **2**) |
| `profile_section` | Profile heading (default `## Profile`) |
| `skills_section` | Skills heading (default `## Core Competencies`) |
| `experience_section` | Experience heading (default `## Experience`) |
| `education_section` | Education heading (default `## Education & Mentoring`) |

Per-role override: record in `notes.md` (e.g. **Page budget:** 1) — user request beats config.

Script helper: `config_resume_pages` in `scripts/lib/config-read.sh`.

## Cover letter defaults (`config/cover-letter.defaults.yaml`)

| Key | Purpose |
|-----|---------|
| `word_count.min` / `max` | Body length — enforced by `check-cover-letter.sh` |
| `voices` | Variant list (default professional, conversational, bold) |
| `close_mode` | Default close mode A/B — see `close.md` |
| `sign_off` | Allowed sign-offs |
| `salutation_default` | When no named contact found |

Script helpers: `config_cover_letter_word_min`, `config_cover_letter_word_max`, `config_cover_letter_voices`.

## Locale (`config/locale.yaml`)

| Key | Purpose |
|-----|---------|
| `spelling` | en-GB default — all user-facing prose and letters |
| `date_format` | `uk_long` for cover letter PDF dates (`format_uk_date`) |

## Profile (`config/profile.yaml`)

Written by `/setup`. Read for contact YAML, `home_base`, phone display
(`phone-display.md`), and `audience.technical_level`.

## Examples (`config/examples.yaml`)

Read `format_examples.technical`, `.leadership`, or `.default` for gold-standard paths — never hardcode example role folders in skills.
