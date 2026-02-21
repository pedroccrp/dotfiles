#!/usr/bin/env bash

set -euo pipefail

wallpaper_path="${1:-}"
wal_cache_dir="$HOME/.cache/wal"
wal_templates_source="$HOME/dotfiles/wal/templates"
wal_templates_dest="$HOME/.config/wal/templates"
derive_script="$HOME/dotfiles/scripts/wallpaper/derive-wal-colors.py"
current_wallpaper_link="$HOME/wallpapers/current"

die() {
	printf '%s\n' "$1" >&2
	exit 1
}

ensure_wallpaper_path() {
	[ -n "$wallpaper_path" ] || die "Usage: apply-wallpaper.sh /path/to/image"
	[ -f "$wallpaper_path" ] || die "Wallpaper not found: $wallpaper_path"
}

ensure_display_session() {
	if [ -z "${DISPLAY:-}" ] && [ -z "${WAYLAND_DISPLAY:-}" ]; then
		printf '%s\n' "No display detected. Skipping wallpaper apply."
		exit 0
	fi
}

sync_wal_templates() {
	if [ -d "$wal_templates_source" ]; then
		mkdir -p "$wal_templates_dest"
		cp -f "$wal_templates_source"/* "$wal_templates_dest"/ 2>/dev/null || true
	fi
}

run_pywal() {
	if command -v wal >/dev/null 2>&1; then
		wal -i "$wallpaper_path" -n
	else
		printf '%s\n' "pywal (wal) not found. Skipping color generation."
	fi
}

derive_wal_colors() {
	if [ -f "$derive_script" ]; then
		python "$derive_script" \
			--colors-json "$wal_cache_dir/colors.json" \
			--derived-json "$wal_cache_dir/colors-derived.json" \
			--hypr-conf "$wal_cache_dir/hypr.conf" \
			--tmux-conf "$wal_cache_dir/tmux.conf"
	fi
}

update_current_wallpaper_link() {
	mkdir -p "$HOME/wallpapers"
	ln -sfn "$wallpaper_path" "$current_wallpaper_link"
}

ensure_hyprpaper_running() {
	if command -v hyprpaper >/dev/null 2>&1; then
		hyprpaper >/dev/null 2>&1 &
	fi
}

apply_hyprpaper_wallpaper() {
	if command -v hyprctl >/dev/null 2>&1; then
		if ! hyprctl hyprpaper wallpaper ",${current_wallpaper_link},cover" >/dev/null 2>&1; then
			hyprctl hyprpaper wallpaper ",${current_wallpaper_link}" >/dev/null 2>&1 || true
		fi
	fi
}

reload_apps() {
	if command -v hyprctl >/dev/null 2>&1; then
		hyprctl reload >/dev/null 2>&1 || true
	fi

	if command -v waybar >/dev/null 2>&1; then
		pkill -SIGUSR2 waybar >/dev/null 2>&1 || true
	fi

	if command -v tmux >/dev/null 2>&1; then
		if tmux ls >/dev/null 2>&1; then
			tmux source-file "$HOME/.tmux.conf" >/dev/null 2>&1 || true
			tmux refresh-client -S >/dev/null 2>&1 || true
		fi
	fi
}

ensure_wallpaper_path
ensure_display_session
sync_wal_templates
run_pywal
derive_wal_colors
update_current_wallpaper_link
ensure_hyprpaper_running
apply_hyprpaper_wallpaper
reload_apps
