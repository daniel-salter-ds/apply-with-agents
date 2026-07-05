# Workflow: Build PDF only

Use when `resume.md` exists and the user wants a PDF without a tailoring pass.

## Build

```bash
export PATH="/Library/TeX/texbin:$PATH"
./scripts/build.sh roles/<company-slug>/<role-slug>
```

Run `./scripts/setup.sh` once per machine if `latexmk` or `pandoc` is missing.

## Stale build

If PDF content disagrees with `resume.md`:

```bash
./scripts/build.sh roles/<company-slug>/<role-slug> --clean
./scripts/build.sh roles/<company-slug>/<role-slug>
```

## Submission PDF naming

Each build produces:

| File | Purpose |
|------|---------|
| `resume.pdf` | LaTeX artefact (fixed name for `latexmk`) |
| `{Name-Slug}-{Role-Label}-resume.pdf` | Submission copy |

Role label: YAML `output_role` → `tagline` → role directory slug.

Example: `tagline: Senior Widget Engineer` → `Alex-Chen-Senior-Widget-Engineer-resume.pdf`

Generic tagline → set `output_role` in YAML for a distinct filename.

Preview without building:

```bash
./scripts/output-name.sh roles/<company-slug>/<role-slug>
```

## Verify

Confirm `Output written` and `Wrote …/<Name>-<Role>-resume.pdf` in build output.

Full checklist: [references/verification.md](../references/verification.md).
