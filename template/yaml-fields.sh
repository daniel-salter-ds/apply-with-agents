#!/usr/bin/env bash
# Shared resume.md YAML helpers — source from build scripts; do not execute directly.
#
#   source "$TEMPLATE_DIR/yaml-fields.sh"
#   get_yaml_field "$RESUME_MD" name
#   format_uk_date 2026-06-16
#   parse_letter_generated_date "$LETTER_MD"
#   format_linkedin_display "https://linkedin.com/in/dan-salter"

get_yaml_field() {
  local file="$1"
  local field="$2"
  awk -v field="$field" '
    BEGIN { in_yaml = 0 }
    /^---$/ {
      in_yaml++
      next
    }
    in_yaml == 1 {
      if ($1 == field ":") {
        sub(/^[^:]*:[[:space:]]*/, "")
        gsub(/^"/, "")
        sub(/"$/, "")
        print
        exit
      }
    }
  ' "$file"
}

slugify() {
  local value="$1"
  value="${value// /-}"
  value="$(printf '%s' "$value" | sed 's/[^[:alnum:]-]//g')"
  value="$(printf '%s' "$value" | sed 's/--*/-/g; s/^-//; s/-$//')"
  printf '%s' "$value"
}

format_uk_date() {
  local iso="$1"
  local y m d
  IFS='-' read -r y m d <<< "$iso"
  local months=(
    January February March April May June
    July August September October November December
  )
  local month_idx=$((10#$m - 1))
  printf '%d %s %s' "$((10#$d))" "${months[$month_idx]}" "$y"
}

parse_letter_generated_date() {
  local file="$1"
  grep -oE 'generated: [0-9]{4}-[0-9]{2}-[0-9]{2}' "$file" 2>/dev/null \
    | head -1 \
    | sed 's/generated: //' \
    || true
}

format_linkedin_display() {
  local url="$1"
  url="${url#https://}"
  url="${url#http://}"
  url="${url#www.}"
  url="${url%/}"
  printf '%s' "$url"
}
