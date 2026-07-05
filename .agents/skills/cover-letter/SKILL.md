---
name: cover-letter
description: >
  Write tailored cover letters for roles with an existing resume.md;
  deep company research, checkpoint, three voice variants. Requires /resume
  first. Use when user invokes /cover-letter or asks for a cover letter
  for roles/company/role.
disable-model-invocation: true
---

# Cover letter — router

Repo-local cover-letter pipeline: deep research → checkpoint → three markdown
variants in `roles/<company-slug>/<role-slug>/` → optional PDF via
`scripts/cover-letter-build.sh`. Requires a tailored CV from `/resume` first.

## Setup gate

If `config/profile.yaml` or `master.md` is missing — route to **`/setup`** first (before `/resume`).

## User communication

Follow [../../references/audience-comms.md](../../references/audience-comms.md).

## Config

Read [../../references/config-contract.md](../../references/config-contract.md). Load **`config/cover-letter.defaults.yaml`** (word count, voices, salutation, close mode) and **`config/locale.yaml`** before drafting.

## When to use

- User invokes **`/cover-letter`** for an existing role folder
- User wants cover letters after `/resume` tailoring is complete
- User wants to update or rebuild cover-letter PDFs for a role

After `/resume` tailoring, the user may invoke `/cover-letter` for the same
role folder.

## When not to use (hard stops)

- **`resume.md` missing** → tell user to run `/resume` first; do not research or draft
- **`job-spec.md` missing** → tell user to run `/resume` first
- User wants a **new role folder only** → route to `/resume`
- Generic cover-letter advice without this repo layout

## Repository contract

| File | Purpose |
|------|---------|
| `master.md` | Canonical experience — fallback for metrics not in trimmed `resume.md` |
| `config/examples.yaml` | Format example paths (technical + leadership) |
| `roles/<company>/<role>/resume.md` | **Hard prerequisite** — tailored CV from `/resume` |
| `roles/<company>/<role>/job-spec.md` | **Hard prerequisite** — JD from `/resume` |
| `roles/<company>/<role>/notes.md` | Interview themes, mapping, iteration log, **selected voice** |
| `roles/<company>/<role>/company-research.md` | Agent audit trail; checkpoint status |
| `roles/<company>/<role>/research-summary.md` | Human verify + checkpoint input |
| `roles/<company>/<role>/cover-letter-*.md` | Three voice variants |
| `.agents/agents/cover-letter-*.md` | Readonly subagents (research + submission suite) |
| [references/subagents.md](references/subagents.md) | When/how to invoke subagents |
| `roles/<company>/<role>/submission-audit.md` | Submission gate audit record (post-voice) |
| [references/research.md](references/research.md) | Deep research protocol |
| [references/research-summary-format.md](references/research-summary-format.md) | `research-summary.md` sections |
| [references/structure-and-voices.md](references/structure-and-voices.md) | Letter shape + three voices |
| [references/close.md](references/close.md) | Close modes (default: substantive, no call ask) |
| [references/location.md](references/location.md) | Location close vs resume YAML; mandatory checkpoint |
| [references/gold-standard.md](references/gold-standard.md) | E2e example folders; sync when rules change |
| `scripts/check-cover-letter.sh` | Banned-pattern + em-dash mechanical check |
| `config/cover-letter-banned-patterns.txt` | Single source for banned grep patterns |
| [references/banned-words.md](references/banned-words.md) | Word blacklist + grep self-check |
| [references/ai-writing-tropes.md](references/ai-writing-tropes.md) | Phrase/structure tropes |
| [references/verification.md](references/verification.md) | Pre-present + submission checklists |
| [references/pdf-layout.md](references/pdf-layout.md) | PDF layout and ATS rules (applied at build) |
| `scripts/cover-letter-build.sh` | Styled PDF build (`render/cover-letter.latex`) |
| `render/cover-letter.latex` | Pandoc LaTeX template for letters |
| `scripts/output-name.sh` | Submission filename (`--cover-letter`; voice not in name) |

## Route to workflow

Read **exactly one** workflow file for the task:

| User intent | Read |
|-------------|------|
| New cover letter for role | [workflows/new-cover-letter.md](workflows/new-cover-letter.md) |
| Update existing letters | [workflows/update-cover-letter.md](workflows/update-cover-letter.md) |
| Build PDF only | [workflows/build.md](workflows/build.md) |

If intent is ambiguous, ask once then route.

## Defaults

Read **`config/cover-letter.defaults.yaml`** ([config-contract.md](../../references/config-contract.md)) — do not hardcode:

- **Variants:** `voices` list (same factual core across variants)
- **Length:** `word_count.min`–`word_count.max`; three-paragraph skeleton
- **Salutation:** `salutation_default` unless research finds a named contact
- **Sign-off:** first entry in `sign_off` unless voice rules say otherwise
- **Close:** `close_mode` (default A) — interest + logistics + company tie + **brief thanks**; no call ask ([close.md](references/close.md))
- **Research budget:** 8–15 search/fetch calls
- **Checkpoints:** hook confirm (step 6) and **location close** confirm (step 6c) — both blocking before drafting; see [location.md](references/location.md)
- **Location close:** user-confirmed sentence in `notes.md`; never copy resume YAML `location` without approval
- **Letter headers:** HTML comments only (voice, date, word count); naming from sibling `resume.md` YAML
- **Selected voice:** once the user picks a variant, record in `notes.md`; all later edits target that file only, with PDF rebuild each time ([workflows/update-cover-letter.md](workflows/update-cover-letter.md))
- **Subagents:** research auditor before checkpoint; submission suite (company-claims, experience, style) after voice selection, before PDF — [subagents.md](references/subagents.md)

## Opening message

> I'll validate `roles/<company-slug>/<role-slug>/` has a tailored `resume.md`, research the company, run a research audit, write `research-summary.md` for your review, then ask you to confirm the hook and location close before drafting three variants. Role path: `…` — OK?

## Related docs

- [README.md](../../README.md)
- [DESIGN.md](../../DESIGN.md)
- [roles/README.md](../../roles/README.md)
- [`.agents/skills/resume/SKILL.md`](../resume/SKILL.md) — run **before** cover letter
