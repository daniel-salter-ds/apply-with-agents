# Resume markdown format (AltaCV pipeline)

Applies when editing `roles/<company-slug>/<role-slug>/resume.md` or `examples/e2e/*/resume.md`.

## Facts

- Pull employers, dates, titles, and metrics from `master.md` only — no fabrication
- Tailor into the role folder — never compile `master.md` directly

## YAML front matter

Required fields: `name`, `email`, `phone`, `location`, `tagline`

Optional: `output_role`, `linkedin`, `website`, `github` (at least one professional link recommended)

## Sections

- Profile: `config/resume.defaults.yaml` → `profile_section`
- Skills: `config/resume.defaults.yaml` → `skills_section` — bullet list, one `- **Category:**` line per group
- Experience: job-line format below
- Education: plain markdown — not job-line format

## Job entries

```markdown
**Organisation — Title** · *Month Year - Present | City, Country*
```

Sub-sections: `**Name**` alone on a line → `\cvsubsection`

## Build

```bash
./scripts/build.sh roles/<company-slug>/<role-slug>
```

## Do not

- Use generic ATS headings (`# NAME`, `## PROFESSIONAL SUMMARY`)
- Edit `render/` (LaTeX, `job.lua`, `altacv.cls`) unless explicitly requested
- Create single-level `roles/<combined-slug>/` folders — use two-level layout

## Language

Spelling per `config/locale.yaml`.

## Full mapping

See `DESIGN.md` and format examples in `config/examples.yaml`.
