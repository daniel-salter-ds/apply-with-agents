# Reference: Cover letter location close

Companion to [close.md](./close.md). Logistics in the final paragraph must
reflect where the candidate **actually lives or works from**, not the
advantageous city on the CV header.

## Two different locations

| Context | Source | Purpose |
|---------|--------|---------|
| **Resume YAML `location`** | Resume skill — often job city for ATS/header | PDF contact block; "most advantageous for the role" |
| **Cover letter logistics** | `master.md` home base + user-confirmed close line | Spoken availability in the close paragraph |

**Hard rule:** Never copy resume YAML `location` into the letter close without
the user confirming it at the location checkpoint ([new-cover-letter.md](../workflows/new-cover-letter.md) step 6c).

Common pattern when they differ (e.g. Utrecht resident, Amsterdam role):

- YAML: `Amsterdam, Netherlands` (header)
- Letter: "I am in Utrecht and can work hybrid in Amsterdam."

## Default home base

Unless the user overrides:

- Read `master.md` Profile and current role lines (e.g. Yera → Utrecht).
- Read `notes.md` → `## Interview` → `**Home base:**` if recorded during `/resume`.
- Job city from `job-spec.md` informs commute/hybrid wording only.

## Checkpoint (mandatory before drafting)

At step 6c the agent must:

1. Propose an **exact logistics sentence** (or `omit`).
2. Show resume YAML `location` separately labelled **header only**.
3. Wait for user: **confirm / correct / omit**.
4. Record in `notes.md` → `## Cover letter`:

```markdown
**Location close:** I am in Utrecht and can work hybrid in Amsterdam.
```

or:

```markdown
**Location close:** omit
```

Do not draft cover letters until `**Location close:**` is recorded.

## Approved patterns

| Situation | Example line |
|-----------|--------------|
| Home base + job city (hybrid) | I am in Utrecht and can work hybrid in Amsterdam. |
| Home base + on-site in job country | I am in Utrecht and can work on site in the Netherlands. |
| Same city | I am based in London and can work on site as required. |
| Remote-first role | I am in Utrecht and work remotely across European time zones. |
| Relocation | I am relocating to Amsterdam and available from [month]. |
| User opts out | omit — close uses interest + company tie + thanks only |

Use UK English. Keep to one sentence in the close.

## Omit logistics

Valid when the user says **omit** or JD has no location signal. Mode A close
still needs specific interest, company tie, and brief thanks.

## Verification

- Pre-present: logistics in all three variants match `**Location close:**` ([verification.md](./verification.md))
- Submission: experience auditor dimension **E7** ([cover-letter-experience-auditor.md](../../../agents/cover-letter-experience-auditor.md))

## Cross-links

- Resume interview should record `**Home base:**` and `**Location (YAML):**` separately ([resume workflows/new-role.md](../../resume/workflows/new-role.md))
- Gold standard: ING `notes.md` + `cover-letter-professional.md` close
