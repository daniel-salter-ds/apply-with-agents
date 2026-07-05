# Workflow: New role from URL

## 0. Declare scope

Before any fetch, read, or draft:

1. Confirm **company-slug** and **role-slug**; active path is `roles/<company-slug>/<role-slug>/`
2. Follow `.cursor/rules/role-application-isolation.mdc` — do not read other `roles/*/` folders
3. After scaffold, verify `notes.md` **Active application** and `AGENTS.md` match this path

## 1. Parse request

Extract company, title, and URL. Propose **company-slug** and **role-slug** separately. Confirm with user if ambiguous.

**Slug rules:** lowercase, hyphen-separated; each must match `^[a-z0-9][a-z0-9-]*$`. Never `_template`, `test`, or `new`.

| Level | Examples |
|-------|----------|
| Company | `acme`, `example-co` |
| Role | `senior-backend`, `staff-sre-2026` |

## 2. Scaffold

```bash
./template/new-role.sh <company-slug> <role-slug> --url "<url>"
```

Creates `resume.md`, `job-spec.md`, `notes.md`, and `AGENTS.md` under `roles/<company-slug>/<role-slug>/`.

## 3. Fetch job spec

Follow [references/fetch-job-spec.md](../references/fetch-job-spec.md). Append full text to `job-spec.md` under `## Raw posting`.

## 4. Analyse JD

Extract must-haves, keywords, seniority, and tech stack. Write a short summary at top of `job-spec.md` or in `notes.md`.

**Scope:** Overlap and fit notes must name employers and projects from `master.md` only (Yera, Finbourne/Candela, Luminesce, Quantifi, etc.). Never cite other `roles/*/` application folders.

## 5. Interview user (mandatory before drafting)

1. Profile themes (max 2)?
2. Which roles or projects from **`master.md`** to emphasise or cut?
3. Tagline? **Default:** match the job spec title when possible (e.g. `Founding Senior Product Engineer`). Fall back to gold-standard YAML `tagline` only when the spec title is vague or misleading.
4. **Location (YAML)** for resume header? **Default:** most advantageous for the role (often job city). **Home base** for cover letters? **Default:** from `master.md` (e.g. Utrecht when job is Amsterdam). Record both separately in step 6.

Do not draft until user responds.

**Agent defaults (do not ask unless user overrides):**

- **Length:** two pages
- **Omissions / de-emphasis:** use judgement from `master.md` and the JD — trim low-relevance content without asking
- **Master sync:** if the user states facts missing from `master.md`, update master first — treat user statements as correct ([references/master-sync.md](../references/master-sync.md))

## 6. Record answers

Write to `notes.md` under `## Interview (agent + user)`:

- **Location (YAML):** advantageous header city/country for `resume.md`
- **Home base:** where the candidate actually lives/works from (`master.md`)

These differ when commuting to a nearby job city (e.g. YAML Amsterdam, home base Utrecht). Cover letter workflow uses **Home base** — see [cover-letter references/location.md](../../cover-letter/references/location.md).

## 7. Draft `resume.md`

- Start from scaffolded template under the role folder
- Facts from `master.md` only — no fabrication; if interview answers add facts, ensure they are in master first ([references/master-sync.md](../references/master-sync.md))
- Copy YAML contact block from gold-standard role unless user overrides
- **`location`:** most advantageous for the role (usually job city/country when reasonable); ask if unclear
- **`phone`:** `07…` for UK-based roles; `+44…` for roles based outside the UK (e.g. `+447906203975`)
- Set `tagline` to the job spec title when possible; optional `output_role` for submission filename when tagline is generic
- **Profile:** one sentence for *what* built (parenthetical names from master); separate sentence for *where* — no repeated explanations
- **Sub-sections:** mirror JD architecture when accurate; JD-strongest sub-section first within a role; name internal products from `master.md` in parentheses
- **Terminology:** distinguish product vs framework vs pipeline — match `master.md`, not JD copy alone
- **Technical Skills:** bullet list — one `- **Category:**` line per group; tailor categories to the JD
Markdown format: glob rule on `roles/**/resume.md` + altacv `00-CONTEXT.md`.

**Default page budget:** two pages unless the user specifies otherwise.

**Workflow anti-patterns:**

- Do not build from `master.md` directly
- Do not prescribe generic sections (`## PROFESSIONAL SUMMARY`, `# JOHN DOE`)
- Do not read or mirror other `roles/*/` tailored CVs

## 8. Build

Follow [build.md](./build.md).

## 9. Verify

Follow [references/verification.md](../references/verification.md).

## 10. Layout pass (after first draft)

Read [layout.md](./layout.md). Check page count (default budget: two pages), final-page bottom gap (≤ 5%), and page-break alignment. **Ask the user whether the layout looks OK** before iterating further. Record layout decisions in `notes.md`.

## 11. Offer iteration

Summarise changes (Profile themes, reordered roles, skills emphasis). Ask if another pass.

After the user approves the CV, they may run **`/cover-letter`** for the same role (requires `resume.md`).
