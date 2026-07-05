# Reference: Cover letter PDF layout and design

Companion to `structure-and-voices.md` (content) and `build.md` (build
mechanics). This file governs how the ~250-350 words get laid out once
content is finalized — applies after a `cover-letter-<voice>.md` is
approved, before/during `pandoc cover-letter-<voice>.md -o
cover-letter-<voice>.pdf`.

## The two competing constraints

Every decision below balances two things that pull in slightly different
directions, and both matter:

1. **Visual coherence with `resume.pdf`** — a cover letter that looks like
   it belongs to a different application package than the CV it accompanies
   reads as careless. The header should mirror the resume header: same
   name treatment, same contact fields, same general font family.
2. **ATS-safety** — many employers run the cover letter through the same
   parser as the resume. Anything that breaks resume parsing breaks cover
   letter parsing identically, and a cover letter has no JD-keyword density
   to "win back" if the parser mangles it.

The resolution used throughout this file: match the resume's font family,
sizing, and content order, but never reproduce the resume's icon glyphs
(FontAwesome symbols) or any layout the AltaCV class produces — those are
exactly the elements that cause ATS parsing problems and have no upside in
a plain prose letter. Plain text labels ("Email:", "Phone:") achieve the
same visual coherence without the parsing risk.

## Page setup

| Property | Value |
|---|---|
| Length | One page, no exceptions — if content overflows, cut content, never shrink font/margins to fit |
| Margins | 1 inch (2.54 cm) on all sides — slightly more generous than the resume's 1.25 cm, since a cover letter has far less to fit |
| Alignment | Left-aligned throughout. Never justified, never centered body text |
| Columns | Single column only — no exceptions, this is the single most-cited ATS failure mode for PDFs |

## Header block

Mirror the resume's header content and order, in plain text, no icons:

```
Alex Chen
Email: alex@example.com   Phone: 06 12345678   Location: Amsterdam, NL
LinkedIn: linkedin.com/in/alex-chen
```

- Name: bold, 14-16pt — slightly larger than body text, matching whatever
  size the resume's `\name{}` renders at.
- Contact line: same body font, 10-11pt, plain-text separators (use a
  visible separator like a pipe `|` or extra spacing — never an icon glyph
  or a table).
- Pull these fields directly from the role's `resume.md` YAML front matter at
  **PDF build time** (`render/cover-letter-build.sh`) — never duplicate
  them in `cover-letter-*.md`. The letter markdown is **body only**
  (salutation through sign-off); HTML comment metadata is not rendered.
- Skip a decorative rule/divider line under the header — acceptable on a
  resume's section headers, unnecessary here and adds nothing for a
  three-paragraph letter.

## Date and salutation block

- Date in full written form, not numeric: `16 June 2026` (UK convention,
  consistent with UK locale in `config/locale.yaml`) rather than `6/16/2026` or
  `2026-06-16`. Place it below the header with one blank line above and
  below.
- Skip the full mailing-address block (employer name/street
  address/city) that print-era letter templates include — this is a
  digital PDF upload, not a posted letter, and including a fake postal
  address adds clutter without signal. Go straight from date to salutation.
- Salutation per `structure-and-voices.md`: named person if research found
  one, otherwise "Dear Hiring Team," — never "To Whom It May Concern."

## Typography

| Property | Value |
|---|---|
| Font | Match the resume's body font (Lato, per `render/resume.latex`) where the build tooling allows it; fall back to a standard ATS-safe sans-serif (Calibri, Arial, Helvetica) if Lato isn't reliably available in the simpler pandoc/LaTeX path used for the letter |
| Body size | 11pt (match the resume's body text exactly if known) |
| Line spacing | Single-spaced within each paragraph; one full blank line between paragraphs — never double-space the whole letter |
| Color | Body text in black or near-black only. A single subtle accent (e.g. the resume's IFBlue for the name only) is acceptable for visual coherence but optional — never use color in body text or as a substitute for emphasis |
| Emphasis | Minimal. No bold/italic inside body paragraphs — emphasis here reads as trying too hard in a three-paragraph letter; reserve bold for the header name only |

## Sign-off

```
Kind regards,

Alex Chen
```

- One blank line between the closing word and the typed name — no
  signature image needed for a digitally-submitted PDF.
- Sign-off phrase follows `structure-and-voices.md`'s per-voice table
  (default "Kind regards" / "Best regards" unless a specific voice
  variant calls for something else).
- No repeated contact details below the signature — they're already in the
  header; repeating them is the print-letter convention and adds nothing
  in a one-page digital document.

## ATS-safety checklist (apply before finalizing the PDF)

- [ ] Single column, no tables used for layout (a one-row data table, if
  any, is fine; layout tables are not)
- [ ] No text boxes, no floating elements
- [ ] No icon glyphs (FontAwesome or otherwise) anywhere in the document
- [ ] No images, including no logo or letterhead graphic
- [ ] Standard, embeddable font — confirm the chosen font isn't a Type 3
  font that strips on export (this matters most if Lato is reused; verify
  the PDF's text layer is selectable and copyable, not rasterized)
- [ ] No content placed in a page header/footer area — most ATS parsers
  don't read headers/footers at all, so contact info there would be
  invisible to the parser, not just to humans
- [ ] File size reasonable (a one-page text PDF should be well under
  100KB — if it's large, something image-based has crept in)
- [ ] PDF is not password-protected or restricted from copying

## Quick gut-check

Open the finished PDF and select all the text with a mouse drag. If
anything doesn't highlight cleanly in reading order — header, date,
salutation, body, sign-off — top to bottom, that's the same failure mode
an ATS parser will hit. Fix the layout, not the content, when this happens.
