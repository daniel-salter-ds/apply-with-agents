#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
RENDER_DIR="$REPO_ROOT/render"
export PATH="/Library/TeX/texbin:${PATH:-}"
# shellcheck source=lib/yaml-fields.sh
source "$SCRIPT_DIR/lib/yaml-fields.sh"

ROLE_ARG="${1:-}"
VOICE="${2:-}"

if [[ -z "$ROLE_ARG" || -z "$VOICE" ]]; then
  echo "Usage: $0 <role-directory> <voice>" >&2
  echo "  voice: professional | conversational | bold" >&2
  exit 1
fi

case "$VOICE" in
  professional|conversational|bold) ;;
  *)
    echo "Unknown voice: $VOICE (expected professional, conversational, or bold)" >&2
    exit 1
    ;;
esac

if ! command -v pandoc >/dev/null || ! command -v pdflatex >/dev/null; then
  echo "Run $SCRIPT_DIR/setup.sh first" >&2
  exit 1
fi

ROLE_DIR="$(cd "$ROLE_ARG" && pwd)"
RESUME_MD="$ROLE_DIR/resume.md"
LETTER_MD="$ROLE_DIR/cover-letter-${VOICE}.md"
LETTER_PDF="$ROLE_DIR/cover-letter-${VOICE}.pdf"

if [[ ! -f "$RESUME_MD" ]]; then
  echo "Missing $RESUME_MD" >&2
  exit 1
fi

if [[ ! -f "$LETTER_MD" ]]; then
  echo "Missing $LETTER_MD" >&2
  exit 1
fi

NAME="$(get_yaml_field "$RESUME_MD" name)"
EMAIL="$(get_yaml_field "$RESUME_MD" email)"
PHONE="$(get_yaml_field "$RESUME_MD" phone)"
LOCATION="$(get_yaml_field "$RESUME_MD" location)"
LINKEDIN_RAW="$(get_yaml_field "$RESUME_MD" linkedin)"
WEBSITE_RAW="$(get_yaml_field "$RESUME_MD" website)"

for var_name in NAME EMAIL PHONE LOCATION; do
  if [[ -z "${!var_name}" ]]; then
    echo "Missing required YAML field in $RESUME_MD (need name, email, phone, location)" >&2
    exit 1
  fi
done

LETTER_DATE_ISO="$(parse_letter_generated_date "$LETTER_MD")"
if [[ -z "$LETTER_DATE_ISO" ]]; then
  LETTER_DATE_ISO="$(date +%Y-%m-%d)"
fi
LETTER_DATE="$(format_uk_date "$LETTER_DATE_ISO")"

PANDOC_ARGS=(
  "$LETTER_MD"
  -o "$LETTER_PDF"
  --template="$RENDER_DIR/cover-letter.latex"
  --pdf-engine=pdflatex
  --from markdown
  --standalone
  -V "name=$NAME"
  -V "email=$EMAIL"
  -V "phone=$PHONE"
  -V "location=$LOCATION"
  -V "letter_date=$LETTER_DATE"
)

if [[ -n "$LINKEDIN_RAW" ]]; then
  LINKEDIN="$(format_linkedin_display "$LINKEDIN_RAW")"
  PANDOC_ARGS+=(-V "linkedin=$LINKEDIN")
fi

if [[ -n "$WEBSITE_RAW" ]]; then
  WEBSITE="$(format_linkedin_display "$WEBSITE_RAW")"
  PANDOC_ARGS+=(-V "website=$WEBSITE")
fi

cd "$ROLE_DIR"
pandoc "${PANDOC_ARGS[@]}"

OUTPUT_NAME="$("$SCRIPT_DIR/output-name.sh" "$ROLE_DIR" --cover-letter)"
OUTPUT_PDF="$ROLE_DIR/$OUTPUT_NAME"

rm -f ./*-cover-letter*.pdf 2>/dev/null || true
cp "$LETTER_PDF" "$OUTPUT_PDF"

echo "Wrote $LETTER_PDF"
echo "Wrote $OUTPUT_PDF"
