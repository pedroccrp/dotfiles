#!/usr/bin/env bash

set -euo pipefail

wallpaper_path="${1:-}"

if [ -z "$wallpaper_path" ]; then
	printf '%s\n' "Usage: apply-wallpaper.sh /path/to/image"
	exit 1
fi

if [ ! -f "$wallpaper_path" ]; then
	printf '%s\n' "Wallpaper not found: $wallpaper_path"
	exit 1
fi

if [ -z "${DISPLAY:-}" ] && [ -z "${WAYLAND_DISPLAY:-}" ]; then
	printf '%s\n' "No display detected. Skipping wallpaper apply."
	exit 0
fi

template_source="$HOME/dotfiles/wal/templates"
template_dest="$HOME/.config/wal/templates"

if [ -d "$template_source" ]; then
	mkdir -p "$template_dest"
	cp -f "$template_source"/* "$template_dest"/ 2>/dev/null || true
fi

if command -v wal >/dev/null 2>&1; then
	wal -i "$wallpaper_path" -n
else
	printf '%s\n' "pywal (wal) not found. Skipping color generation."
fi

copy_wal_file() {
	local src="$1"
	local dest="$2"

	if [ -f "$src" ]; then
		mkdir -p "$(dirname "$dest")"
		cp "$src" "$dest"
	fi
}

copy_wal_file "$HOME/.cache/wal/rofi.rasi" "$HOME/.config/rofi/wal.rasi"
copy_wal_file "$HOME/.cache/wal/waybar.css" "$HOME/.config/waybar/wal.css"
copy_wal_file "$HOME/.cache/wal/colors-kitty.conf" "$HOME/.config/kitty/wal.conf"
copy_wal_file "$HOME/.cache/wal/tmux.conf" "$HOME/dotfiles/tmux/wal-colors.conf"
copy_wal_file "$HOME/.cache/wal/nvim.lua" "$HOME/.config/nvim/wal.lua"

python - <<'PY'
import json
import os
from pathlib import Path

colors_path = Path.home() / ".cache" / "wal" / "colors.json"
dest_path = Path.home() / ".config" / "hypr" / "wal.conf"

if not colors_path.exists():
    raise SystemExit(0)

data = json.loads(colors_path.read_text())
special = data.get("special", {})
colors = data.get("colors", {})

def hex_nohash(value: str) -> str:
    return value.lstrip("#")

lines = [
    f"$color_background = rgb({hex_nohash(special.get('background', '#000000'))})",
    f"$color_foreground = rgb({hex_nohash(special.get('foreground', '#ffffff'))})",
    f"$color_accent = rgb({hex_nohash(colors.get('color1', '#ff0000'))})",
    f"$color_border = rgb({hex_nohash(colors.get('color1', '#ff0000'))})",
    f"$color_secondary = rgb({hex_nohash(colors.get('color2', '#00ff00'))})",
    f"$color_urgent = rgb({hex_nohash(colors.get('color3', '#ffff00'))})",
    f"$color_muted = rgb({hex_nohash(colors.get('color8', '#888888'))})",
]

dest_path.parent.mkdir(parents=True, exist_ok=True)
dest_path.write_text("\n".join(lines) + "\n")
PY

if command -v hyprctl >/dev/null 2>&1 && pgrep -x hyprpaper >/dev/null 2>&1; then
	if ! hyprctl hyprpaper wallpaper ",$wallpaper_path,cover" >/dev/null 2>&1; then
		hyprctl hyprpaper wallpaper ",$wallpaper_path" >/dev/null 2>&1 || true
	fi
fi

hyprpaper_conf="$HOME/.config/hypr/hyprpaper.conf"
python - "$hyprpaper_conf" "$wallpaper_path" <<'PY'
import pathlib
import re
import sys

conf_path = pathlib.Path(sys.argv[1])
wallpaper = sys.argv[2]

text = conf_path.read_text() if conf_path.exists() else ""

pattern = r"(wallpaper\s*\{[^}]*?\n\s*path\s*=)\s*.*"
replacement = r"\1 " + wallpaper
new_text, count = re.subn(pattern, replacement, text, flags=re.S)

if count == 0:
    if text.strip():
        text = text.rstrip() + "\n\n"
    text += (
        "wallpaper {\n"
        "    monitor =\n"
        "    path = " + wallpaper + "\n"
        "    fit_mode = cover\n"
        "}\n"
    )
    new_text = text

conf_path.parent.mkdir(parents=True, exist_ok=True)
conf_path.write_text(new_text)
PY

if command -v hyprpaper >/dev/null 2>&1; then
	hyprpaper >/dev/null 2>&1 &
fi

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
