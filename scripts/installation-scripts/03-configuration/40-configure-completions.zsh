#!/usr/bin/env zsh

set -euo pipefail

if command -v docker >/dev/null 2>&1; then
  docker completion zsh > ~/.docker/completions/_docker
fi
