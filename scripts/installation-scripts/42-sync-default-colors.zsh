#!/usr/bin/env zsh

set -euo pipefail

DOTFILES="$HOME/dotfiles"
DEFAULTS_DIR="$DOTFILES/colors/default"
CACHE_DIR="$HOME/.cache/wal"

force_copy=false
if [ "${1:-}" = "--force" ]; then
  force_copy=true
fi

copy_default() {
  local src="$1"
  local dest="$2"

  if [ ! -f "$src" ]; then
    return 0
  fi

  if $force_copy || [ ! -f "$dest" ]; then
    mkdir -p "$(dirname "$dest")"
    cp -f "$src" "$dest"
  fi
}

copy_default "$DEFAULTS_DIR/rofi.rasi" "$CACHE_DIR/rofi.rasi"
copy_default "$DEFAULTS_DIR/waybar.css" "$CACHE_DIR/waybar.css"
copy_default "$DEFAULTS_DIR/colors-kitty.conf" "$CACHE_DIR/colors-kitty.conf"
copy_default "$DEFAULTS_DIR/hypr.conf" "$CACHE_DIR/hypr.conf"
copy_default "$DEFAULTS_DIR/tmux.conf" "$CACHE_DIR/tmux.conf"
