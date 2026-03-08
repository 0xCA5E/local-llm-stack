#!/bin/bash
# Install Dependencies.command
# Legacy/manual dependency installer for users who are not using the Homebrew formula.

set -euo pipefail

say() { printf '%s\n' "$*"; }
say_err() { printf '%s\n' "$*" >&2; }

require_macos() {
  if [[ "$(uname -s)" != "Darwin" ]]; then
    say_err "This installer only supports macOS."
    exit 1
  fi
}

require_homebrew() {
  if command -v brew >/dev/null 2>&1; then
    return
  fi

  say_err "Homebrew is required for this legacy installer."
  say_err "Install Homebrew first: https://brew.sh"
  exit 1
}

has_docker_desktop_app() {
  open -Ra "Docker" >/dev/null 2>&1 || open -Ra "Docker Desktop" >/dev/null 2>&1
}

install_ollama_if_missing() {
  if command -v ollama >/dev/null 2>&1; then
    say "ollama already installed; skipping."
    return
  fi

  say "Installing ollama via Homebrew..."
  brew install ollama
}

install_docker_if_missing() {
  if command -v docker >/dev/null 2>&1 && has_docker_desktop_app; then
    say "Docker CLI + Docker Desktop already detected; skipping."
    return
  fi

  say "Installing Docker Desktop via Homebrew cask..."
  brew install --cask docker
}

main() {
  require_macos
  require_homebrew

  say "Legacy/manual installer mode."
  say "If you installed via Homebrew formula, skip this script and run: local-llm-doctor"

  install_ollama_if_missing
  install_docker_if_missing

  say ""
  say "Done. Next steps:"
  say "1) Open Docker Desktop once: open -a Docker"
  say "2) Run: local-llm-doctor"
  say "3) Run: local-llm-start"
}

main "$@"
