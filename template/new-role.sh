#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEMPLATE_ROLE="$REPO_ROOT/roles/_template"

usage() {
  echo "Usage: $0 <company-slug> <role-slug> [--url <url>]" >&2
  echo "Creates roles/<company-slug>/<role-slug>/" >&2
  exit 1
}

validate_slug() {
  local label="$1"
  local slug="$2"

  if [[ "$slug" == "_template" ]]; then
    echo "Error: $label cannot be _template" >&2
    exit 1
  fi

  if [[ "$slug" != "$(printf '%s' "$slug" | tr '[:upper:]' '[:lower:]')" ]]; then
    echo "Error: $label must be lowercase (use hyphens, not uppercase)" >&2
    exit 1
  fi

  if [[ ! "$slug" =~ ^[a-z0-9][a-z0-9-]*$ ]]; then
    echo "Error: $label must match ^[a-z0-9][a-z0-9-]*$ (lowercase, hyphens, no spaces)" >&2
    exit 1
  fi
}

COMPANY_SLUG=""
ROLE_SLUG=""
URL=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --url)
      [[ $# -ge 2 ]] || usage
      URL="$2"
      shift 2
      ;;
    --help|-h)
      usage
      ;;
    -*)
      echo "Unknown option: $1" >&2
      usage
      ;;
    *)
      if [[ -z "$COMPANY_SLUG" ]]; then
        COMPANY_SLUG="$1"
      elif [[ -z "$ROLE_SLUG" ]]; then
        ROLE_SLUG="$1"
      else
        echo "Unexpected argument: $1" >&2
        usage
      fi
      shift
      ;;
  esac
done

[[ -n "$COMPANY_SLUG" && -n "$ROLE_SLUG" ]] || usage

validate_slug "company-slug" "$COMPANY_SLUG"
validate_slug "role-slug" "$ROLE_SLUG"

ROLE_DIR="$REPO_ROOT/roles/$COMPANY_SLUG/$ROLE_SLUG"
ROLE_PATH="roles/$COMPANY_SLUG/$ROLE_SLUG"

if [[ -d "$ROLE_DIR" ]]; then
  echo "Error: $ROLE_DIR already exists" >&2
  exit 1
fi

if [[ ! -f "$TEMPLATE_ROLE/resume.md" ]]; then
  echo "Error: missing $TEMPLATE_ROLE/resume.md" >&2
  exit 1
fi

mkdir -p "$ROLE_DIR"
cp "$TEMPLATE_ROLE/resume.md" "$ROLE_DIR/resume.md"

CAPTURED="$(date +%Y-%m-%d)"

if [[ -n "$URL" ]]; then
  cat > "$ROLE_DIR/job-spec.md" <<EOF
# Job specification

- **URL:** $URL
- **Captured:** $CAPTURED

## Raw posting

_Paste or fetch job description below._
EOF
else
  cat > "$ROLE_DIR/job-spec.md" <<'EOF'
# Job specification

_Paste job description or link above._

## Raw posting

EOF
fi

cat > "$ROLE_DIR/notes.md" <<EOF
# Tailoring notes

## Active application

- **Company:** $COMPANY_SLUG
- **Path:** $ROLE_PATH/
- **Scope:** This folder only. Facts from \`master.md\`. Do not reference other \`roles/*/\` folders.

## Interview (agent + user)

- Priorities:
- Emphasise:
- De-emphasise or omit:
- Tagline tweak:
- Location (YAML):
- Home base:

## Decisions

EOF

AGENTS_TEMPLATE="$TEMPLATE_ROLE/AGENTS.md"
if [[ -f "$AGENTS_TEMPLATE" ]]; then
  sed -e "s/COMPANY_SLUG/$COMPANY_SLUG/g" -e "s/ROLE_SLUG/$ROLE_SLUG/g" \
    "$AGENTS_TEMPLATE" > "$ROLE_DIR/AGENTS.md"
else
  cat > "$ROLE_DIR/AGENTS.md" <<EOF
# Active application scope

**This file applies only when working in this role folder.**

- **Path:** \`$ROLE_PATH/\`
- **Facts:** \`master.md\` only — no fabrication
- **Format examples:** \`roles/anthropic/applied-ai-architect/\`, \`roles/ing/senior-ai-engineer-agentic-ai/\` only

Do **not** read or use as tailoring input:

- Other \`roles/*/\` folders (CVs, cover letters, job-specs, notes, research)
- Recently viewed files or git status mentioning other applications

JD overlap and interview emphasis must name employers/projects from \`master.md\` only (e.g. Yera, Finbourne/Candela, Luminesce, Quantifi).
EOF
fi

echo "Created $ROLE_DIR"
echo "  resume.md    — edit and build"
echo "  job-spec.md  — job description"
echo "  notes.md     — tailoring decisions"
echo "  AGENTS.md    — per-role scope guard"
echo ""
echo "Next: tailor resume.md, then ./template/build.sh $ROLE_PATH"
