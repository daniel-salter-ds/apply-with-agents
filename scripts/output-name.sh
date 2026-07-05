#!/usr/bin/env bash
# Resolve submission PDF filename from resume.md YAML and role directory.
# Usage: output-name.sh <role-directory> [--cover-letter]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=lib/yaml-fields.sh
source "$SCRIPT_DIR/lib/yaml-fields.sh"

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <role-directory> [--cover-letter]" >&2
  exit 1
fi

ROLE_DIR="$(cd "$1" && pwd)"
RESUME_MD="$ROLE_DIR/resume.md"
ROLE_DIR_SLUG="$(basename "$ROLE_DIR")"
COVER_LETTER=false

shift || true
while [[ $# -gt 0 ]]; do
  case "$1" in
    --cover-letter)
      COVER_LETTER=true
      shift
      ;;
    *)
      echo "Unknown option: $1" >&2
      exit 1
      ;;
  esac
done

if [[ ! -f "$RESUME_MD" ]]; then
  echo "Missing $RESUME_MD" >&2
  exit 1
fi

NAME="$(get_yaml_field "$RESUME_MD" name)"
OUTPUT_ROLE="$(get_yaml_field "$RESUME_MD" output_role)"
TAGLINE="$(get_yaml_field "$RESUME_MD" tagline)"

if [[ -z "$NAME" ]]; then
  echo "Missing required YAML field: name" >&2
  exit 1
fi

ROLE_LABEL="${OUTPUT_ROLE:-${TAGLINE:-$ROLE_DIR_SLUG}}"

NAME_SLUG="$(slugify "$NAME")"
ROLE_SLUG="$(slugify "$ROLE_LABEL")"

if [[ "$COVER_LETTER" == true ]]; then
  printf '%s\n' "${NAME_SLUG}-${ROLE_SLUG}-cover-letter.pdf"
else
  printf '%s\n' "${NAME_SLUG}-${ROLE_SLUG}-resume.pdf"
fi
