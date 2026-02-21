#!/usr/bin/env bash

set -euo pipefail

wallpapers_dir="$HOME/wallpapers"

if [ ! -d "$wallpapers_dir" ]; then
	rofi -e "No wallpapers folder found at $wallpapers_dir"
	exit 0
fi

wallpapers=$(find "$wallpapers_dir" -type f \( \
	-iname '*.jpg' -o \
	-iname '*.jpeg' -o \
	-iname '*.png' -o \
	-iname '*.webp' \
	\) | sort)

if [ -z "$wallpapers" ]; then
	rofi -e "No wallpapers found in $wallpapers_dir"
	exit 0
fi

selection=$(printf '%s\n' "$wallpapers" | rofi -dmenu -i -p "Wallpapers")

if [ -z "$selection" ]; then
	exit 0
fi

bash "$HOME/dotfiles/scripts/wallpaper/apply-wallpaper.sh" "$selection"
