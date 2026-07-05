# Reference: Cover letter location close

Companion to [close.md](./close.md). Logistics in the final paragraph must
reflect where the candidate **actually lives or works from**, not the
advantageous city on the CV header.

## Two different locations

| Context | Source | Purpose |
|---------|--------|---------|
| **Resume YAML `location`** | Resume skill — often job city for ATS/header | PDF contact block |
| **Cover letter logistics** | `config/profile.yaml` home_base + user-confirmed close line | Spoken availability in close |

**Hard rule:** Never copy resume YAML `location` into the letter close without
user confirmation at the location checkpoint.

Example when they differ:

- YAML: `Amsterdam, Netherlands` (header)
- Letter: "I am in Haarlem and can work hybrid in Amsterdam."

## Default home base

- Read `config/profile.yaml` → `home_base`
- Read `notes.md` → `**Home base:**` if recorded during `/resume`

## Checkpoint (mandatory before drafting)

Record in `notes.md` → `## Cover letter`:

```markdown
**Location close:** I am based in Amsterdam and can work on site as required.
```

or `**Location close:** omit`

## Approved patterns

| Situation | Example line |
|-----------|--------------|
| Same city | I am based in London and can work on site as required. |
| Home base + job city (hybrid) | I am in Haarlem and can work hybrid in Amsterdam. |
| Remote-first | I work remotely across European time zones. |
| User opts out | omit |

Spelling per `config/locale.yaml`.
