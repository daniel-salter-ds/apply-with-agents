# Audience-aware communication

Read `config/profile.yaml` → `audience.technical_level` before any **user-facing**
message (openers, closers, errors, next steps). Workflow steps may still run shell
commands internally — do not paste them into chat unless the rules below allow it.

## Levels

| Value | When to set |
|-------|-------------|
| `technical` | **Only when clear** from CV and interview: software/engineering, DevOps/SRE, data engineering, security engineering, or similar roles where daily terminal/CLI use is normal. Or the user explicitly says they are comfortable running commands. |
| `non_technical` | Default. Marketing, sales, ops, HR, general management, design, academia (non-CS), career changers, or **any ambiguous** background. Prefer simpler language when unsure. |

Set during **`/setup`** (step 6 — Profile). If missing on later skills, infer once from
`master.md` and write back to `profile.yaml`.

## Non-technical users (`non_technical`)

**Do**

- Lead with **skills**: `/resume`, `/cover-letter`, `/master`, `/setup`.
- Explain outcomes: “I'll tailor your CV and save a PDF you can submit.”
- Use plain language for what happens behind the scenes (research, folder created, PDF built).
- For toolchain problems, describe the fix in steps (“install the PDF tools once — I can walk you through it”) before showing a command block.

**Do not**

- Show `./scripts/...` or `git ...` unless the user must run something you cannot run for them **and** you have explained why in plain language first.
- Say “scaffold manually”, “run in terminal”, or “slug” without translating (use “company folder name” if needed).
- Dump raw output from `setup.sh` or build scripts.

### Setup complete (example)

> You're all set. Your experience library and contact details are saved.
>
> **Next:** when you find a role you like, paste the job link here and type **`/resume`**. I'll read the posting, tailor your CV, and produce a submission PDF.
>
> After that, **`/cover-letter`** can draft researched letter options. Use **`/master`** whenever you want to add or update experience.

## Technical users (`technical`)

May include concise command references when they save back-and-forth (build, scaffold, clean rebuild). Still lead with skills for the happy path.

### Setup complete (example)

> Setup complete — `master.md` and `config/profile.yaml` written.
>
> **Next:** **`/resume`** with a job URL (scaffolds via `new-role.sh`, builds with `build.sh`). **`/master`** for library updates.

## Toolchain failures

| Level | Approach |
|-------|----------|
| `non_technical` | Explain what's missing (PDF converter), offer guided install; one command at a time with what it does |
| `technical` | Show exact commands (`brew install …`, `./scripts/setup.sh`, PATH snippet) |

## Skill openers

Tailor the resume new-application opener the same way — non-technical: avoid slug jargon; technical: may propose `company-slug/role-slug` explicitly.
