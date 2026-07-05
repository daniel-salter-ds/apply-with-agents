# Reference: Banned words and phrases

Mechanical enforcement: **`template/check-cover-letter.sh`** reads
`template/cover-letter-banned-patterns.txt` (single source of truth).

Structural tropes (tricolons, negative parallelism, etc.) remain in
[ai-writing-tropes.md](./ai-writing-tropes.md) — manual read-aloud check.

## Run self-check

```bash
# Selected voice from notes.md (or all variants if none selected)
./template/check-cover-letter.sh roles/<company-slug>/<role-slug>

# All three variants (initial draft pass)
./template/check-cover-letter.sh roles/<company-slug>/<role-slug> --all-variants
```

Exit 0 = pass. Fix any `FAIL` lines before presenting.

Checks performed:

| Check | Rule |
|-------|------|
| Word count | 250–350 words (comment-stripped body); warns if HTML `words:` comment stale |
| Hard patterns | `[HARD]` + `[PHRASE]` — any match fails |
| Soft patterns | `[SOFT]` — **one** hit total OK; **two or more** hits fail |
| Em dashes | ≤2 |

## Tiered vocabulary

**Hard (zero tolerance):** passionate, leverage, utilize, delve, synergy,
landscape, tapestry, stock phrases, call offers — see `[HARD]` and
`[PHRASE]` in the patterns file.

**Soft (threshold):** robust, nuanced, pivotal, fundamentally, certainly,
etc. — see `[SOFT]`. One appearance in the whole letter is allowed; two or
more soft hits (any combination) fails. Matches [ai-writing-tropes.md](./ai-writing-tropes.md) §2.

## Allowed (not banned)

- **"Thank you for considering my application"** — gratitude, not a CTA
  ([close.md](./close.md))
- Banned: **"Thank you for your time and consideration"** as the *only*
  closing content (listed under `[PHRASE]`)

## Updating the list

Edit **`template/cover-letter-banned-patterns.txt` only** — use section
headers `[HARD]`, `[SOFT]`, `[PHRASE]`.
