#!/usr/bin/env zsh

set -euo pipefail

DOTFILES=${DOTFILES:-"$HOME/dotfiles"}
PROFILE_NAME="main"
PROFILE_PATH="$DOTFILES/zen"
ZEN_CONFIG_DIR="$HOME/.config/zen"
PROFILES_INI="$ZEN_CONFIG_DIR/profiles.ini"

if ! command -v zen-browser >/dev/null 2>&1; then
  print -r -- "Skipping Zen profile setup: zen-browser not found."
  exit 0
fi

mkdir -p "$PROFILE_PATH/chrome/mods"

if [[ -f "$PROFILES_INI" ]] && grep -Eq '^Name=main$' "$PROFILES_INI"; then
  if grep -Eq "^Path=$PROFILE_PATH$" "$PROFILES_INI"; then
    print -r -- "Zen profile 'main' already exists."
  else
    print -r -- "Zen profile 'main' already exists at a different path."
  fi
  exit 0
fi

zen-browser --CreateProfile "$PROFILE_NAME $PROFILE_PATH"
