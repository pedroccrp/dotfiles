#!/usr/bin/env zsh

set -euo pipefail

if ! command -v yay >/dev/null 2>&1; then
  echo "Please install yay first!"
  exit 1
fi

yay -S --needed --noconfirm \
  zsh-completions \
  zsh-syntax-highlighting \
  zsh-autosuggestions
