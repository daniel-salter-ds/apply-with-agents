#!/usr/bin/env bash
# Self-check cover letter markdown: banned patterns, em dashes, word count.
# Usage: check-cover-letter.sh <role-directory> [--all-variants]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
# shellcheck source=lib/config-read.sh
source "$SCRIPT_DIR/lib/config-read.sh"
PATTERNS_FILE="$REPO_ROOT/config/cover-letter-banned-patterns.txt"
MAX_EM_DASHES=2
SOFT_MATCH_THRESHOLD=1
WORD_MIN="$(config_cover_letter_word_min)"
WORD_MAX="$(config_cover_letter_word_max)"

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <role-directory> [--all-variants]" >&2
  exit 1
fi

ROLE_DIR="$(cd "$1" && pwd)"
ALL_VARIANTS=false
shift || true
while [[ $# -gt 0 ]]; do
  case "$1" in
    --all-variants) ALL_VARIANTS=true; shift ;;
    *) echo "Unknown option: $1" >&2; exit 1 ;;
  esac
done

if [[ ! -f "$PATTERNS_FILE" ]]; then
  echo "Missing $PATTERNS_FILE" >&2
  exit 1
fi

resolve_files() {
  if [[ "$ALL_VARIANTS" == true ]]; then
    find "$ROLE_DIR" -maxdepth 1 -name 'cover-letter-*.md' | sort
    return
  fi
  local voice=""
  if [[ -f "$ROLE_DIR/notes.md" ]]; then
    voice="$(grep -E '^\*\*Selected voice:\*\*' "$ROLE_DIR/notes.md" 2>/dev/null | head -1 | sed 's/^\*\*Selected voice:\*\*[[:space:]]*//' | sed 's/[[:space:]]*#.*//' | tr -d '[:space:]')"
  fi
  if [[ -n "$voice" ]]; then
    echo "$ROLE_DIR/cover-letter-${voice}.md"
  else
    find "$ROLE_DIR" -maxdepth 1 -name 'cover-letter-*.md' | sort
  fi
}

strip_comments() {
  sed '/^<!--/,/-->$/d' "$1"
}

count_pattern_matches() {
  local body="$1"
  local pattern="$2"
  local count=0
  local line
  while IFS= read -r line; do
    count=$((count + line))
  done < <(printf '%s' "$body" | grep -oiF "$pattern" || true)
  printf '%s' "$count"
}

FAILED=0
SECTION=""

while IFS= read -r file; do
  [[ -z "$file" || ! -f "$file" ]] && continue
  FILE_FAILED=0
  echo "=== $(basename "$file") ==="
  BODY="$(strip_comments "$file")"

  WORD_COUNT="$(printf '%s' "$BODY" | wc -w | tr -d ' ')"
  if [[ "$WORD_COUNT" -lt "$WORD_MIN" || "$WORD_COUNT" -gt "$WORD_MAX" ]]; then
    echo "FAIL word count: $WORD_COUNT (required $WORD_MIN-$WORD_MAX)"
    FILE_FAILED=1
    FAILED=1
  else
    echo "OK word count: $WORD_COUNT"
  fi

  COMMENT_WC="$(grep -oE 'words: [0-9]+' "$file" 2>/dev/null | head -1 | sed 's/words: //' || true)"
  if [[ -n "$COMMENT_WC" && "$COMMENT_WC" != "$WORD_COUNT" ]]; then
    echo "WARN HTML comment words: $COMMENT_WC (actual $WORD_COUNT) — update comment"
  fi

  SOFT_TOTAL=0

  while IFS= read -r line; do
    [[ "$line" =~ ^[[:space:]]*# ]] && continue
    [[ -z "${line// }" ]] && continue

    if [[ "$line" =~ ^\[(HARD|SOFT|PHRASE)\]$ ]]; then
      SECTION="${BASH_REMATCH[1]}"
      continue
    fi

    pattern="$line"
    hits="$(count_pattern_matches "$BODY" "$pattern")"
    [[ "$hits" -eq 0 ]] && continue

    case "$SECTION" in
      HARD|PHRASE)
        echo "FAIL banned ($SECTION): $pattern"
        FILE_FAILED=1
        FAILED=1
        ;;
      SOFT)
        SOFT_TOTAL=$((SOFT_TOTAL + hits))
        ;;
      *)
        echo "FAIL banned (unsectioned): $pattern"
        FILE_FAILED=1
        FAILED=1
        ;;
    esac
  done < "$PATTERNS_FILE"

  if [[ "$SOFT_TOTAL" -gt "$SOFT_MATCH_THRESHOLD" ]]; then
    echo "FAIL soft vocabulary: $SOFT_TOTAL hits (max $SOFT_MATCH_THRESHOLD)"
    FILE_FAILED=1
    FAILED=1
  elif [[ "$SOFT_TOTAL" -gt 0 ]]; then
    echo "OK soft vocabulary: $SOFT_TOTAL hit (allowed)"
  else
    echo "OK soft vocabulary: 0"
  fi

  EM_COUNT="$(printf '%s' "$BODY" | { grep -o '—' || true; } | wc -l | tr -d ' ')"
  if [[ "$EM_COUNT" -gt "$MAX_EM_DASHES" ]]; then
    echo "FAIL em dashes: $EM_COUNT (max $MAX_EM_DASHES)"
    FILE_FAILED=1
    FAILED=1
  else
    echo "OK em dashes: $EM_COUNT"
  fi

  if [[ "$FILE_FAILED" -eq 0 ]]; then
    echo "OK all checks"
  fi
done < <(resolve_files)

exit "$FAILED"
