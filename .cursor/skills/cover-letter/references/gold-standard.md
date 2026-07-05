# Reference: Gold-standard role folder

Canonical example: **`roles/ing/senior-ai-engineer-agentic-ai/`**

Use for shape and process — not as immutable prose. When cover-letter skill
rules change, update this folder in the same pass:

| Artefact | Purpose |
|----------|---------|
| `company-research.md` | Research audit trail + checkpoint |
| `research-summary.md` | Pre-checkpoint digest format |
| `cover-letter-professional.md` | Selected submission letter (when voice = professional) |
| `notes.md` | Selected voice, close mode, mapping, iteration log, research audit line |
| `submission-audit.md` | Submission gate record (new roles after subagent rework) |
| Submission PDF | Rebuild after letter edits |

## Subagent infrastructure

Skill subagents live in `.cursor/agents/`:

- `cover-letter-research-auditor` — before checkpoint
- `cover-letter-company-claims-auditor` — submission gate
- `cover-letter-experience-auditor` — submission gate
- `cover-letter-style-auditor` — submission gate

Orchestration: [subagents.md](./subagents.md).

The ING folder was submitted (2026-06-17) before `submission-audit.md` was first
written; the file is now present as the gold-standard example of a completed
submission gate.

## Current conventions demonstrated

- Close mode **A**: interest + logistics + company tie + thanks; no call ask
- **Location close:** Utrecht home base + hybrid Amsterdam (not resume YAML city alone) — see `notes.md` `**Location close:**` and [location.md](./location.md)
- Body: 2–3 proof threads with explicit JD connectors
- GCP and similar gaps in `notes.md` only, not in letter
- `check-cover-letter.sh` and `cover-letter-build.sh` pass on selected file

## Do not

- Point skill examples at ING without keeping files aligned with current rules
- Treat in-progress drafts as canon after skill updates
