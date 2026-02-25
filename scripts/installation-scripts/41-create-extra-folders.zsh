#!/usr/bin/env zsh

set -euo pipefail

mkdir -p "$HOME/notes"
mkdir -p ~/.docker/completions

if command -v docker >/dev/null 2>&1; then
  docker completion zsh > ~/.docker/completions/_docker
fi
