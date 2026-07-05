# Reference: Fetch job specification

General patterns for retrieving job posting text — not vendor-specific.

## Procedure

1. Fetch URL via web tools or browser
2. Append full text to `roles/<company-slug>/<role-slug>/job-spec.md` under `## Raw posting`
3. If visible page is empty or client-rendered, try in order:
   - HTML source: `<script type="application/ld+json">` with `"@type": "JobPosting"` → `description` field
   - Meta tags: `og:description`, `name="description"`
   - Shell fetch: `curl -sL "<url>"` and parse JSON-LD or embedded HTML
4. If all fail → ask the user to paste the description

## Notes

- Many modern careers pages render client-side; structured data in page source is often complete when the visible page is not
- Convert HTML to readable markdown-friendly text; do not invent JD content
- Write a short analysis summary (must-haves, keywords, seniority, stack) at top of `job-spec.md` or in `notes.md` after fetch
