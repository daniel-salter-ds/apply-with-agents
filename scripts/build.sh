#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
RENDER_DIR="$REPO_ROOT/render"
export PATH="/Library/TeX/texbin:${PATH:-}"
export TEXINPUTS="$RENDER_DIR:${TEXINPUTS:-}"

ROLE_ARG="${1:-}"
CLEAN=false

if [[ -z "$ROLE_ARG" ]]; then
  echo "Usage: $0 <role-directory> [--clean]" >&2
  exit 1
fi

if [[ "$ROLE_ARG" == "--clean" ]]; then
  echo "Usage: $0 <role-directory> [--clean]" >&2
  exit 1
fi

ROLE_DIR="$ROLE_ARG"
shift || true

while [[ $# -gt 0 ]]; do
  case "$1" in
    --clean)
      CLEAN=true
      shift
      ;;
    *)
      echo "Unknown option: $1" >&2
      exit 1
      ;;
  esac
done

ROLE_DIR="$(cd "$ROLE_DIR" && pwd)"
RESUME_MD="$ROLE_DIR/resume.md"
RESUME_PDF="$ROLE_DIR/resume.pdf"

if [[ ! -f "$RESUME_MD" ]]; then
  echo "Missing $RESUME_MD" >&2
  exit 1
fi

if [[ "$CLEAN" == true ]]; then
  cd "$ROLE_DIR"
  latexmk -C 2>/dev/null || rm -f resume.aux resume.log resume.bcf resume.bbl resume.blg \
    resume.fls resume.fdb_latexmk resume.out resume.run.xml resume.xdv resume.tex
  rm -f ./*-resume.pdf 2>/dev/null || true
  echo "Cleaned build artefacts in $ROLE_DIR"
  exit 0
fi

if ! command -v pandoc >/dev/null || ! command -v latexmk >/dev/null; then
  echo "Run $SCRIPT_DIR/setup.sh first" >&2
  exit 1
fi

cd "$ROLE_DIR"

pandoc resume.md \
  -o resume.tex \
  --template="$RENDER_DIR/resume.latex" \
  --lua-filter="$RENDER_DIR/job.lua" \
  --from markdown+yaml_metadata_block+raw_attribute \
  --standalone \
  --shift-heading-level-by=-1

if [[ ! -f resume.pdf ]] && [[ -f resume.fdb_latexmk || -f resume.aux ]]; then
  echo "Clearing stale state from a previous failed build..."
  latexmk -C >/dev/null 2>&1 || true
fi

latexmk -pdf -interaction=nonstopmode -file-line-error resume.tex

OUTPUT_NAME="$("$SCRIPT_DIR/output-name.sh" "$ROLE_DIR")"
OUTPUT_PDF="$ROLE_DIR/$OUTPUT_NAME"

rm -f ./*-resume.pdf 2>/dev/null || true
cp resume.pdf "$OUTPUT_PDF"

echo "Wrote $RESUME_PDF"
echo "Wrote $OUTPUT_PDF"
