---
name: setup
description: >
  First-run onboarding for the resume repo: ingest existing CVs, collect search
  brief, run target-role research, interview to build master.md and
  config/profile.yaml. Use when user invokes /setup or when profile/master
  is missing. Run before /resume or /cover-letter.
disable-model-invocation: true
---

# Setup — router

First-run onboarding. Creates `config/profile.yaml` and `master.md` from user materials.

## Hard stop if already complete

If `config/profile.yaml` exists with `setup_complete: true` and `master.md` exists — ask whether to re-run setup or route to `/master` for updates.

## Communication

Follow [../../references/audience-comms.md](../../references/audience-comms.md). Infer
`audience.technical_level` during the profile step; default **`non_technical`** when
unsure. Do not relay raw `setup.sh` output or shell commands to non-technical users.

## Route to workflow

Read [workflows/new-setup.md](workflows/new-setup.md).

## Repository outputs

| File | Purpose |
|------|---------|
| `config/profile.yaml` | Contact, country, phone, links (from profile.example.yaml) |
| `audience.technical_level` | In profile — plain vs command-heavy chat ([../../references/audience-comms.md](../../references/audience-comms.md)) |
| `config/target-role-research.md` | Role-type research from search brief |
| `master.md` | Canonical experience library |
| `inputs/setup/` | Uploaded CVs (gitignored) |

## Related

- [../master/SKILL.md](../master/SKILL.md) — post-setup updates
- [../resume/SKILL.md](../resume/SKILL.md) — after setup complete
