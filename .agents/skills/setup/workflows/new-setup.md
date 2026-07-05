# Workflow: New setup

## 1. Toolchain

Run `./scripts/setup.sh` (or verify pandoc + latexmk on PATH). Fail early with README prerequisites if missing.

Do **not** paste script output or manual scaffold commands to the user — see [../../references/audience-comms.md](../../references/audience-comms.md). Report toolchain status in plain language unless `audience.technical_level` is already `technical`.

## 2. Existing materials

Ask the user to upload or paste **all existing CVs, bios, LinkedIn exports, portfolio pages** — as many as they have.

- Save to `inputs/setup/` when files are provided
- Extract facts, dates, titles, metrics into a draft outline
- Flag conflicts between sources for the interview

## 3. Search brief (required)

Collect:

1. **Target roles** — 1–5 free-text entries (titles or short descriptions)
2. **Company stage** — pre-seed/seed · Series A–C · growth · enterprise · mixed
3. **Search geography** — single country (happy path)
4. **Sector focus** (optional) — e.g. fintech, B2B SaaS, healthtech
5. **Seniority** (optional) — IC · lead/manager · director/VP · C-suite/founder

Do **not** interview for full employment history yet.

## 4. Target-role research

Research high-yield resume and cover-letter patterns for the search brief. Write **`config/target-role-research.md`** with:

- Resume sections and metrics that matter for these roles
- Keywords and framing to use / avoid
- Cover letter hook patterns
- **Open questions for master interview** (agenda)

Budget: 8–15 search/fetch calls.

## 5. Master interview

Use uploaded CVs + research open questions. Flesh out **`master.md`** from [../../master.template.md](../../master.template.md).

- Treat user statements as correct ([../resume/references/master-sync.md](../resume/references/master-sync.md))
- Resolve conflicts between sources explicitly

## 6. Profile

Write **`config/profile.yaml`** from interview (copy shape from `config/profile.example.yaml`):

- name, email, phone, phone_e164, home_country, home_base
- linkedin, website (optional), github (optional)
- **`audience.technical_level`** — infer from CV + interview ([../../references/audience-comms.md](../../references/audience-comms.md)): set `technical` only when background clearly involves daily CLI/tooling; otherwise `non_technical`
- `setup_complete: true`

## 7. Verify (silent)

```bash
./scripts/build.sh examples/e2e/software-engineer
./scripts/build.sh examples/e2e/operations-leader
```

Report pass/fail only. User does not need to open example folders.

## 8. Done

Close using [../../references/audience-comms.md](../../references/audience-comms.md) — **skills only** for `non_technical` users (`/resume`, `/cover-letter`, `/master`). Never end setup with “scaffold manually” or `./scripts/new-role.sh` unless `audience.technical_level: technical`.

Confirm briefly what was saved (experience library, contact details, job-search preferences) without file paths unless the user is technical.
