# Apply with agents

Tailor a CV and cover letter for each job application. Paste your experience once; an agent researches each role, drafts markdown, and builds AltaCV PDFs you can submit.

Works with [Cursor](https://cursor.com), [Claude Code](https://docs.anthropic.com/en/docs/claude-code), or any tool that reads [Agent Skills](https://agentskills.io).

## Who this is for

- Job seekers who want a repeatable process, not a one-off ChatGPT prompt
- People who already use an AI-assisted editor and want structured skills (`/setup`, `/resume`, `/cover-letter`)
- Anyone who prefers plain-language guidance. You do not need git, LaTeX, or folder layouts; the agent handles those.

A local repo the agent maintains: one folder per application, one experience library, markdown in and PDFs out. Not a drag-and-drop resume site.

## What you can do

| Goal | Type in agent chat |
|------|---------------------|
| First-time setup | **`/setup`** |
| CV for a specific job | **`/resume`** (paste the job URL or description) |
| Cover letter variants | **`/cover-letter`** (after `/resume` for the same role) |
| Update your experience library | **`/master`** |

Each run produces AltaCV-styled PDFs (`{Name}-{Role}-resume.pdf`) and optional cover letter PDFs. Applications live under `roles/<company>/<role>/`.

## Get started

Step-by-step guide: **[SETUP.md](SETUP.md)**.

1. **Install PDF tools once** (macOS + Homebrew): BasicTeX and pandoc. See [SETUP.md §1](SETUP.md#1-prerequisites-once-per-machine), or ask your agent to run `./scripts/setup.sh`.

2. **Clone and open the repo** in Cursor or Claude Code:

   ```bash
   git clone https://github.com/daniel-salter-ds/apply-with-agents.git
   cd apply-with-agents
   ```

3. **Run setup in chat:** type **`/setup`**. The agent asks for existing CVs, a short search brief (target roles, geography, sector), and a short interview. It writes **`master.md`** (your experience library) and **`config/profile.yaml`** (contact details). Both stay on your machine and are not committed.

4. **Apply for a role:** paste a job link, type **`/resume`**. The agent reads the posting, asks tailoring questions, drafts your CV, and builds a PDF.

5. **Cover letter (optional):** type **`/cover-letter`** for the same application. Review the research summary, pick a voice, get letter variants and an optional PDF.

```text
/setup, then /resume for each job, then /cover-letter if you want one.
Use /master when your experience changes.
```

## Skills

Skills live in [`.agents/skills/`](.agents/skills/). Entry point: [AGENTS.md](AGENTS.md) ([CLAUDE.md](CLAUDE.md) for Claude Code).

| Skill | When |
|-------|------|
| `/setup` | First run; missing `master.md` or profile |
| `/master` | Update your master CV with a missing role, corrected dates, forgotten metrics, etc... |
| `/resume` | Build tailored resume for a new job via posting URL or text, or refresh an existing resume |
| `/cover-letter` | Write tailored cover letter after `resume.md` exists for that role |

## How it works

- **`master.md`**: employers, dates, metrics. Tailored CVs trim from here.
- **`roles/<company>/<role>/`**: one folder per application (`resume.md`, `job-spec.md`, notes, cover letters). Your applications are gitignored.
- **`scripts/` + `render/`**: pandoc and AltaCV turn markdown into PDF. The agent runs these.
- **`config/`**: locale, page defaults, cover-letter limits, banned phrases.

Format examples (fictional): [`software-engineer`](examples/e2e/software-engineer/), [`operations-leader`](examples/e2e/operations-leader/).

## Repository layout

```text
config/                 # shared defaults; profile.yaml is yours (gitignored)
master.template.md      # skeleton; /setup writes master.md (gitignored)
examples/e2e/           # synthetic CV + cover letter examples
roles/_template/        # scaffold for new applications
scripts/                # build, setup, checks
render/                 # AltaCV LaTeX + pandoc templates
.agents/skills/         # /setup, /master, /resume, /cover-letter
.agents/agents/         # cover-letter auditor subagents
```

Personal files (`master.md`, `config/profile.yaml`, `config/target-role-research.md`, `inputs/`, and `roles/*/` except `_template`) are gitignored.

## Advanced: command line

If you use a terminal, the same pipeline is available directly:

```bash
./scripts/setup.sh                                    # once per machine
./scripts/new-role.sh acme staff-backend --url "…"   # scaffold application folder
./scripts/build.sh roles/acme/staff-backend           # CV PDF
./scripts/cover-letter-build.sh roles/acme/staff-backend professional
./scripts/check-cover-letter.sh roles/acme/staff-backend
```

Details: [BUILD.md](BUILD.md), [DESIGN.md](DESIGN.md).

## Documentation

| Doc | Contents |
|-----|----------|
| [SETUP.md](SETUP.md) | Plain-language onboarding |
| [BUILD.md](BUILD.md) | Build pipeline and PDF naming |
| [DESIGN.md](DESIGN.md) | Architecture and markdown rules |
| [roles/README.md](roles/README.md) | Application folder naming |

## Troubleshooting

| Problem | What to do |
|---------|------------|
| Agent says run **`/setup`** | `master.md` or `config/profile.yaml` missing |
| Agent asks about PDF tools | Install BasicTeX + pandoc ([SETUP.md](SETUP.md)) or `./scripts/setup.sh` |
| Cover letter check fails | Ask the agent to fix the draft, or `./scripts/check-cover-letter.sh roles/…` |
| Symlinks missing after clone (Windows) | [SETUP.md §2](SETUP.md#2-clone-and-open-in-your-agent) |

## Requirements

- **OS:** macOS (Homebrew, BasicTeX). Linux works with adapted paths.
- **Tools:** [pandoc](https://pandoc.org), TeX Live (`latexmk`, `xelatex`) via `./scripts/setup.sh`
- **Agent:** Cursor, Claude Code, or compatible Agent Skills host
