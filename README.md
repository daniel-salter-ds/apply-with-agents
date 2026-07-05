# Resume repository

Markdown CVs compiled to AltaCV-styled PDFs (single column). One folder per job application under `roles/<company-slug>/<role-slug>/`.

For architecture and design decisions, see [DESIGN.md](DESIGN.md). For build mechanics, see [BUILD.md](BUILD.md). See [roles/README.md](roles/README.md) for naming and layout.

## Prerequisites

- macOS (paths assume Homebrew + BasicTeX)
- `brew install --cask basictex`
- `brew install pandoc`
- Add to `~/.zshrc`: `export PATH="/Library/TeX/texbin:$PATH"`
- One-time: `./template/setup.sh`

## Quick start — new role CV

1. Scaffold a role folder:

   ```bash
   ./template/new-role.sh acme staff-backend --url "https://..."
   ```

2. Tailor `roles/acme/staff-backend/resume.md` (from `master.md`), or invoke **`/resume`** — agent playbook at [`.cursor/skills/resume/`](.cursor/skills/resume/SKILL.md) (router + workflows).

3. Build:

   ```bash
   ./template/build.sh roles/acme/staff-backend
   ```

4. Output: `roles/acme/staff-backend/resume.pdf` (build artefact) and a submission copy:

   `Daniel-Salter-<role-label>-resume.pdf`

   Role label comes from YAML `output_role`, then `tagline`, then the role directory slug. Company slug is **not** included in the filename.

## Quick start — cover letter

**Prerequisite:** tailored `resume.md` and `job-spec.md` from **`/resume`**.

1. Invoke **`/cover-letter`** with the role path (e.g. `roles/ing/senior-ai-engineer-agentic-ai/`) — agent playbook at [`.cursor/skills/cover-letter/`](.cursor/skills/cover-letter/SKILL.md).

2. Review `research-summary.md` at the research checkpoint; confirm the hook.

3. Paste `cover-letter-professional.md` (or chosen variant) into the ATS.

4. Optional PDF:

   ```bash
   ./template/cover-letter-build.sh roles/ing/senior-ai-engineer-agentic-ai professional
   ```

Gold-standard example: `roles/ing/senior-ai-engineer-agentic-ai/`.

## Markdown authoring rules

| Element | Format |
|---------|--------|
| Metadata | YAML block at top |
| Sections | `## Profile`, `## Experience`, etc. |
| Job entry | `**Company — Title** · *dates \| location*` |
| Sub-sections | `**Sub-section Name**` then bullets |
| Skills | `## Technical Skills` bullet list — one `- **Category:**` line per group |
| Education | Plain markdown under `## Education` — not job-line format |

Do not use sidebar files or LaTeX for routine edits. See [DESIGN.md](DESIGN.md) for the full mapping and filter behaviour.

## Updating an existing role

```bash
vim roles/anthropic/applied-ai-architect/resume.md
./template/build.sh roles/anthropic/applied-ai-architect
```

## Cleaning build artefacts

```bash
./template/build.sh roles/anthropic/applied-ai-architect --clean
```

## Repository layout

```text
master.md                        # content library — copy from here
template/                        # shared LaTeX class, pandoc template, filters, build
roles/<company-slug>/<role-slug>/  # per-application resume.md + optional cover letters
  resume.md                      # AltaCV build input
  job-spec.md, notes.md          # from /resume
  company-research.md            # cover-letter research audit trail
  research-summary.md            # human verify + checkpoint
  cover-letter-*.md              # three voice variants
```

`master.md` is the canonical content library, not a build input. For a new role, use `./template/new-role.sh` and tailor from `master.md`. For cover letters, run `/cover-letter` after `/resume`.

## Troubleshooting

| Problem | Fix |
|---------|-----|
| `latexmk not found` | Run `./template/setup.sh`, check PATH |
| `pandoc not found` | `brew install pandoc` |
| `fontawesome.sty not found` | `./template/setup.sh` (tlmgr install fontawesome) |
| Build says up-to-date but no PDF | `./template/build.sh roles/X --clean` then rebuild |
| Job line not `\cvevent` | Check `**Org — Title** · *dates \| location*` format; not under Education |
| Cover letter skill says no resume | Run **`/resume`** first for that role folder |

## Committing PDFs

Generated `roles/**/resume.pdf` and `roles/**/*-resume.pdf` files are **gitignored** by default. To commit a PDF for a role, force-add it (`git add -f roles/acme/staff-backend/Daniel-Salter-Staff-Backend-resume.pdf`) or adjust `.gitignore`.
