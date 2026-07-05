# Setup guide

Plain-language path to start tailoring CVs and cover letters with an AI agent (Cursor, Claude Code, or any tool that reads [Agent Skills](https://agentskills.io)).

## 1. Clone and open in your agent

```bash
git clone https://github.com/daniel-salter-ds/apply-with-agents.git
cd apply-with-agents
```

Open the folder in Cursor or Claude Code. Skills live in `.agents/skills/`.

**Symlinks:** `.cursor/agents` and `.claude/agents` point to `.agents/agents/`. On Windows, if symlinks fail after clone, run:

```bash
ln -sf ../.agents/agents .cursor/agents
ln -sf ../.agents/agents .claude/agents
```

## 2. First run — `/setup`

In agent chat, invoke **`/setup`**. The agent will:

1. Check your machine can build PDFs (install BasicTeX, pandoc, and related tools if needed — you do not need to do this yourself first)
2. Ask you to paste or upload existing CVs (as many as you have)
3. Collect a short **search brief** (target roles, company stage, country, sector)
4. Research what strong CVs look like for those roles
5. Interview you to build **`master.md`** (your canonical experience library)
6. Write **`config/profile.yaml`** (contact details and links)

You do not need to understand folder layout — the agent handles it.

## 3. Apply for a job — `/resume`

Paste a job URL or description. Invoke **`/resume`**. The agent reads the posting, asks tailoring questions, drafts your CV, and produces a submission PDF — you do not need to run build commands yourself.

## 4. Cover letter — `/cover-letter`

After the CV exists, invoke **`/cover-letter`** for the same role folder. Review `research-summary.md`, confirm the hook and location wording, then choose a voice variant.

## 5. Update experience later — `/master`

When you gain new experience or remember a metric, invoke **`/master`** — do not edit role folders in isolation without updating `master.md`.

## Manual PDF toolchain (optional)

If you prefer to install dependencies yourself before **`/setup`**, or if guided install fails:

- macOS with [Homebrew](https://brew.sh)
- `brew install --cask basictex pandoc`
- Add to `~/.zshrc`: `export PATH="/Library/TeX/texbin:$PATH"`
- Run: `./scripts/setup.sh`

## Your editable settings

All preferences live in **`config/`**:

| File | What it controls |
|------|------------------|
| `profile.yaml` | Name, email, phone, home base, links |
| `locale.yaml` | Spelling (default en-GB) |
| `resume.defaults.yaml` | Page count, skills section heading |
| `cover-letter.defaults.yaml` | Word range, voices, close style |
| `cover-letter-banned-patterns.txt` | Words to avoid in letters |

Copy from `config/profile.example.yaml` if you need a reference shape.
