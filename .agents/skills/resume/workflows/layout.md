# Workflow: Layout and page fill

Use when the user specifies a page budget, asks to fill empty space, wants cleaner page breaks, or after first build when a multi-page CV looks sparse or splits awkwardly.

## Two-phase workflow

1. Hit page count target
2. Tune final-page bottom gap and page-break alignment

## Check page count

```bash
export PATH="/Library/TeX/texbin:$PATH"
./scripts/build.sh roles/<company-slug>/<role-slug> 2>&1 | grep "Output written"
# → Output written on resume.pdf (2 pages, …).
```

Or read PDF — page markers appear as `-- N of M --`.

Do **not** guess page count from markdown length.

## Final page bottom gap

Page count is necessary but not sufficient. A multi-page CV with a sparse last page looks unfinished.

- **Target:** final page **bottom gap ≤ 5%** (whitespace below the last line of text)
- **Not a fill-percentage target:** `check-page-fill.py` also reports top gap and a derived “filled %” spanning top-to-bottom content — ignore filled % for pass/fail. Top gap (e.g. a job header starting the page) is expected and does not need to be “filled away”
- Add content in **1–2 bullet increments** from `master.md`; rebuild after each
- Overflow to an extra page happens quickly — add incrementally
- Do not over-trim into a half-empty last page unless the user asks

## Measuring layout

**Qualitative:** read `resume.pdf` — note what sits on the last page and whitespace below the final line.

**Quantitative:**

```bash
python3 ./scripts/check-page-fill.py roles/<company-slug>/<role-slug>
```

Script parses pdftex `Td` positions. Usable height assumes A4 with 1.25 cm top/bottom margins from `render/resume.latex`. **Pass when final page `bottom gap` ≤ 5%.**

## Page-break alignment (soft rule)

Prefer job entries (`**Org — Title**`) or sub-section headers to **start at the top of a page**, not split (title on page N, dates on page N+1).

- **Fix:** add content **earlier** (usually page 1) to push the next entry down — no `\newpage` in the pipeline
- **Soft only:** never sacrifice JD-critical content, Profile clarity, or page budget
- Record in `notes.md` (e.g. "`<Role entry>` starts page 2")

Generic example:

```
Page 1 ends: job title + company name for <Role entry>
Page 2 starts: dates + body
  → Add 2–3 bullets to preceding role on page 1
  → <Role entry> header starts at top of page 2
```

## Diagnose overflow

If pages exceed target:

1. Read PDF — where breaks fall; what sits on overflow page(s)
2. **Tiny trailing page** (e.g. Education only) → trim ~3–5 lines, not whole sections
3. Record trim decisions in `notes.md`

## Iterative trim loop

Repeat until page count ≤ target:

1. Edit `resume.md` — compress per trim priority below
2. Rebuild and re-check
3. Stop when target met; do not over-trim unless user asks

Respect user hard constraints (e.g. keep `<employer>` as separate job entries) — trim elsewhere first.

## Trim priority (over budget)

| Priority | Action | Typical saving |
|----------|--------|----------------|
| 1 | Merge adjacent bullets in same sub-section | 2–4 lines |
| 2 | Collapse skill categories or shorten lists | 3–6 lines |
| 3 | Tighten Profile | 2–3 lines |
| 4 | Remove lowest-JD-relevance bullets from older roles | 2–4 lines each |
| 5 | Compress sub-sections within a role | 1–2 lines |
| 6 | Shorten Education & Mentoring | 1–2 lines |

Do **not** remove entire employers or merge job entries the user wants kept separate.

## Adding content back (under budget)

1. Rebuild to confirm page count and bottom gap
2. Restore high-value JD bullets from `master.md` in small increments
3. Stop when final page bottom gap ≤ 5% without exceeding page count

## Example loop

```
Build → 3 pages (target 2)
  → Read PDF: page 3 = Education only (~small fraction of page)
  → Trim: merge 2 bullets, compress Education — ~4 lines
Build → 2 pages ✓  check-page-fill: page 2 bottom gap ~30%
User: fill page 2; <Role entry> should start page 2
  → Add bullets to page 1 → <Role entry> at top of page 2
  → Restore role detail on page 2 in 1–2 bullet increments
Build → 2 pages ✓  check-page-fill: page 2 bottom gap ≤ 5%
```
