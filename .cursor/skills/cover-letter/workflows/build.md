# Workflow: Build cover letter PDF only

Use when `cover-letter-<voice>.md` exists and the user wants a PDF without
redrafting.

**Voice:** use **`Selected voice`** from `notes.md` → `## Cover letter` when
set; otherwise the voice named in the user request.

Layout spec: [references/pdf-layout.md](../references/pdf-layout.md).

## Build

```bash
./template/cover-letter-build.sh roles/<company-slug>/<role-slug> <voice>
```

Voice: `professional` | `conversational` | `bold`

Run `./template/setup.sh` once per machine if `pandoc` or `pdflatex` is missing.

## What the build produces

PDF layout order (ATS gut-check): **header → date → salutation → body → sign-off**.

| Layer | Source |
|-------|--------|
| Header (name, contact) | Injected from `resume.md` YAML at build |
| Date | `generated:` HTML comment in letter md, else build date (UK long form) |
| Body | `cover-letter-<voice>.md` (salutation through sign-off) |

Uses `template/cover-letter.latex` — Lato 11pt, 1 inch margins, no page numbers.
Not AltaCV.

## Output files

| File | Purpose |
|------|---------|
| `cover-letter-<voice>.pdf` | Build artefact (voice selects source markdown) |
| `{Name-Slug}-{Role-Label}-cover-letter.pdf` | Submission copy (voice not in filename) |

Role label: YAML `output_role` → `tagline` → role directory slug (from sibling `resume.md`).

Preview submission name without building:

```bash
./template/output-name.sh roles/<company-slug>/<role-slug> --cover-letter
```

## Verify

Confirm build output paths. Select-all text in PDF reads in layout order above.

Full checklist: [references/verification.md](../references/verification.md).
