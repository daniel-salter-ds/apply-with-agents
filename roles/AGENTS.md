# Role application work

Applies when editing files under `roles/<company-slug>/<role-slug>/` or `examples/e2e/*/`.

## Scope (mandatory)

### Allowed sources

| Purpose | Source |
|---------|--------|
| Facts (employers, dates, metrics) | `master.md` only |
| Format / structure examples | Paths in `config/examples.yaml` only |
| JD and tailoring decisions | **This** role folder (`job-spec.md`, `notes.md`, `resume.md`) |

### Forbidden as tailoring input

- Other `roles/*/` or `examples/e2e/*/` folders (except format examples above — shape only, not prose to copy)
- Citing other companies' applications in JD analysis or overlap notes
- Treating another application folder as parallel experience

### Workspace context

Ignore git status and recently viewed files referencing other application paths unless the user @-mentions them. Stay in the active role path declared in this folder's `notes.md` or `AGENTS.md`.

## Resume markdown format

When editing `resume.md` in this folder, follow **`config/resume-format.md`**.

- Skills section heading: read from `config/resume.defaults.yaml` → `skills_section`
- Build: `./scripts/build.sh <this-folder>`
- Do not edit `render/` unless explicitly requested

## Language

Spelling per `config/locale.yaml`.
