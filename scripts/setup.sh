#!/usr/bin/env bash
set -euo pipefail

export PATH="/Library/TeX/texbin:${PATH:-}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

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

# Agent symlinks (no-op if already correct)
ensure_symlink() {
  local link_path="$1"
  local target="$2"
  if [[ -L "$link_path" ]] && [[ "$(readlink "$link_path")" == "$target" ]]; then
    return 0
  fi
  mkdir -p "$(dirname "$link_path")"
  ln -sfn "$target" "$link_path"
}

ensure_symlink "$REPO_ROOT/.cursor/agents" "../.agents/agents"
ensure_symlink "$REPO_ROOT/.claude/agents" "../.agents/agents"

echo "Toolchain ready."

# Smoke test e2e examples when render toolchain is available
if [[ -f "$REPO_ROOT/examples/e2e/software-engineer/resume.md" ]]; then
  echo "Smoke test: building examples/e2e/software-engineer..."
  "$SCRIPT_DIR/build.sh" "$REPO_ROOT/examples/e2e/software-engineer" >/dev/null
  echo "Smoke test: building examples/e2e/operations-leader..."
  "$SCRIPT_DIR/build.sh" "$REPO_ROOT/examples/e2e/operations-leader" >/dev/null
  echo "Smoke test: OK"
fi
