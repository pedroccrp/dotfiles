#!/usr/bin/env zsh

set -euo pipefail

DOTFILES=${DOTFILES:-"$HOME/dotfiles"}

if ! command -v git >/dev/null 2>&1; then
  print -r -- "Skipping submodule sync: git not found."
  exit 0
fi

if [[ ! -d "$DOTFILES/.git" ]] || [[ ! -f "$DOTFILES/.gitmodules" ]]; then
  print -r -- "Skipping submodule sync: no git submodules configured."
  exit 0
fi

git -C "$DOTFILES" submodule update --init --recursive
