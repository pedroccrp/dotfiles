#!/usr/bin/env bash

set -euo pipefail

action_change_wallpaper="Change wallpaper"

if [ "$#" -eq 0 ]; then
	printf '%s\n' "$action_change_wallpaper"
	exit 0
fi

selection="$*"
selection=$(printf '%s' "$selection" | tr -d '\r')
selection=${selection#\"}
selection=${selection%\"}

case "$selection" in
"$action_change_wallpaper")
	if [ -x "$HOME/.config/rofi/scripts/wallpaper-picker.sh" ]; then
		setsid -f "$HOME/.config/rofi/scripts/wallpaper-picker.sh" >/dev/null 2>&1
	else
		rofi -e "Wallpaper picker not found or not executable"
	fi
	;;
*)
	rofi -e "No action matched: $selection"
	;;
esac
