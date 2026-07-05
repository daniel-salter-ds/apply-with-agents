#!/usr/bin/env bash
set -euo pipefail

export PATH="/Library/TeX/texbin:${PATH:-}"

TEX_PACKAGES=(
  latexmk
  biber
  carlito
  lato
  fontawesome
  collection-fontsrecommended
  collection-latexextra
)

if ! command -v tlmgr >/dev/null; then
  cat >&2 <<'EOF'
TeX Live not found.

Install BasicTeX, then open a new terminal and run this script again:

  brew install --cask basictex
  eval "$(/usr/libexec/path_helper)"

Add to ~/.zshrc:

  export PATH="/Library/TeX/texbin:$PATH"

EOF
  exit 1
fi

echo "Updating tlmgr..."
sudo tlmgr update --self

echo "Installing required packages (no-op if already present)..."
sudo tlmgr install "${TEX_PACKAGES[@]}"

for cmd in xelatex biber latexmk; do
  if ! command -v "$cmd" >/dev/null; then
    echo "Error: $cmd not on PATH. Is /Library/TeX/texbin in your PATH?" >&2
    exit 1
  fi
done

if ! command -v pandoc >/dev/null; then
  echo "pandoc not found. Install with: brew install pandoc" >&2
  exit 1
fi

echo "Ready. Scaffold a role with: ./template/new-role.sh <company-slug> <role-slug>"
echo "Build a role CV with: ./template/build.sh roles/<company-slug>/<role-slug>"
