# Reference: Gold-standard role folder

Canonical examples (read paths from `config/examples.yaml`):

| Path | Purpose |
|------|---------|
| `examples/e2e/software-engineer/` | Technical role — resume + cover letter shape |
| `examples/e2e/operations-leader/` | Leadership role — resume + cover letter shape |

Use for shape and process — not as immutable prose.

## Subagent infrastructure

`.agents/agents/`:

- `cover-letter-research-auditor` — before checkpoint
- `cover-letter-company-claims-auditor` — submission gate
- `cover-letter-experience-auditor` — submission gate
- `cover-letter-style-auditor` — submission gate

Orchestration: [subagents.md](./subagents.md).

## Conventions demonstrated

- Close mode **A**: interest + logistics + company tie + thanks; no call ask
- **Location close:** in `notes.md` — not resume YAML alone
- Body: 2–3 proof threads with JD connectors
- `scripts/check-cover-letter.sh` and `scripts/cover-letter-build.sh` pass on selected file
