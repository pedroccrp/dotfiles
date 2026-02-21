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

mapfile -t wallpaper_paths < <(printf '%s\n' "$wallpapers")

labels=$(printf '%s\n' "$wallpapers" | python "$HOME/dotfiles/scripts/wallpaper/format-wallpaper-labels.py")

selection_index=$(printf '%s\n' "$labels" | rofi -dmenu -i -p "Wallpapers" -format i)

if [ -z "$selection_index" ]; then
	exit 0
fi

selected_path="${wallpaper_paths[$selection_index]}"
if [ -z "$selected_path" ]; then
	exit 0
fi

bash "$HOME/dotfiles/scripts/wallpaper/apply-wallpaper.sh" "$selected_path"
