---
name: master
description: >
  Update the canonical master.md experience library: add roles, import CVs,
  correct dates or metrics, review gaps. Use when user invokes /master or wants
  to add experience after setup. Requires setup complete.
disable-model-invocation: true
---

# Master — router

Updates **`master.md`** — sole facts source for `/resume` and `/cover-letter`.

## Prerequisites

- `config/profile.yaml` with `setup_complete: true`
- If missing → route to **`/setup`**

## User communication

Follow [../../references/audience-comms.md](../../references/audience-comms.md).

## Route to workflow

| User intent | Read |
|-------------|------|
| Add new experience | [workflows/add-experience.md](workflows/add-experience.md) |
| Update existing entry | [workflows/update-experience.md](workflows/update-experience.md) |
| Import document | [workflows/import-document.md](workflows/import-document.md) |

If ambiguous, ask once.

## Rules

Follow [../resume/references/master-sync.md](../resume/references/master-sync.md): user statements are correct; update master before tailoring.

## Related

- [../resume/SKILL.md](../resume/SKILL.md)
- [../cover-letter/SKILL.md](../cover-letter/SKILL.md)
