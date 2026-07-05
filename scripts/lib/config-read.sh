#!/usr/bin/env bash
# Read scalar and list values from repo config/*.yaml (no external YAML parser).
# Source from scripts; do not execute directly.
#
#   source "$SCRIPT_DIR/lib/config-read.sh"
#   REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
#   pages="$(config_resume_pages)"
#   min="$(config_cover_letter_word_min)"

_config_file() {
  local name="$1"
  printf '%s/config/%s' "$REPO_ROOT" "$name"
}

_config_scalar() {
  local file="$1" key="$2"
  [[ -f "$file" ]] || return 1
  awk -v k="$key" '
    $1 == k ":" {
      sub(/^[^:]*:[[:space:]]*/, "")
      sub(/[[:space:]]+#.*$/, "")
      gsub(/^"/, "")
      sub(/"$/, "")
      print
      exit
    }
  ' "$file"
}

_config_nested_scalar() {
  local file="$1" section="$2" key="$3"
  [[ -f "$file" ]] || return 1
  awk -v section="$section" -v key="$key" '
    $1 == section ":" { in_section=1; next }
    in_section && /^[^[:space:]]/ { in_section=0 }
    in_section && $1 == key ":" {
      sub(/^[^:]*:[[:space:]]*/, "")
      sub(/[[:space:]]+#.*$/, "")
      print
      exit
    }
  ' "$file"
}

_config_list() {
  local file="$1" key="$2"
  [[ -f "$file" ]] || return 1
  awk -v k="$key" '
    $1 == k ":" { in_list=1; next }
    in_list && /^[^[:space:]#-]/ { exit }
    in_list && /^[[:space:]]+-[[:space:]]/ {
      sub(/^[[:space:]]+-[[:space:]]*/, "")
      sub(/[[:space:]]+#.*$/, "")
      gsub(/^"/, "")
      sub(/"$/, "")
      print
    }
  ' "$file"
}

config_resume_pages() {
  local pages
  pages="$(_config_scalar "$(_config_file resume.defaults.yaml)" pages)"
  if [[ -z "$pages" ]]; then
    echo 2
  else
    echo "$pages"
  fi
}

config_resume_section() {
  local key="$1" fallback="$2"
  local value
  value="$(_config_scalar "$(_config_file resume.defaults.yaml)" "$key")"
  if [[ -z "$value" ]]; then
    echo "$fallback"
  else
    echo "$value"
  fi
}

config_cover_letter_word_min() {
  local min
  min="$(_config_nested_scalar "$(_config_file cover-letter.defaults.yaml)" word_count min)"
  if [[ -z "$min" ]]; then
    echo 250
  else
    echo "$min"
  fi
}

config_cover_letter_word_max() {
  local max
  max="$(_config_nested_scalar "$(_config_file cover-letter.defaults.yaml)" word_count max)"
  if [[ -z "$max" ]]; then
    echo 350
  else
    echo "$max"
  fi
}

config_cover_letter_voices() {
  _config_list "$(_config_file cover-letter.defaults.yaml)" voices
}

config_cover_letter_salutation_default() {
  local value
  value="$(_config_scalar "$(_config_file cover-letter.defaults.yaml)" salutation_default)"
  if [[ -z "$value" ]]; then
    echo "Dear Hiring Team"
  else
    echo "$value"
  fi
}

config_locale_spelling() {
  local value
  value="$(_config_scalar "$(_config_file locale.yaml)" spelling)"
  if [[ -z "$value" ]]; then
    echo "en-GB"
  else
    echo "$value"
  fi
}
