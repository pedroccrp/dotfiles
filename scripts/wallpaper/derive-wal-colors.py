#!/usr/bin/env python3

import argparse
import colorsys
import json
from pathlib import Path


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("--colors-json", required=True)
    parser.add_argument("--derived-json", required=True)
    parser.add_argument("--hypr-conf", required=True)
    parser.add_argument("--tmux-conf", required=True)
    return parser.parse_args()


def clamp(value, min_v=0.0, max_v=1.0):
    return max(min_v, min(max_v, value))


def hex_to_rgb(hex_color: str):
    hex_color = hex_color.lstrip("#")
    return tuple(int(hex_color[i : i + 2], 16) / 255.0 for i in (0, 2, 4))


def rgb_to_hex(rgb):
    return "#%02x%02x%02x" % tuple(int(clamp(c) * 255) for c in rgb)


def luminance(rgb):
    def adjust(c):
        return c / 12.92 if c <= 0.03928 else ((c + 0.055) / 1.055) ** 2.4

    r, g, b = [adjust(c) for c in rgb]
    return 0.2126 * r + 0.7152 * g + 0.0722 * b


def contrast_ratio(rgb1, rgb2):
    l1 = luminance(rgb1) + 0.05
    l2 = luminance(rgb2) + 0.05
    return max(l1, l2) / min(l1, l2)


def clamp_saturation(rgb, max_sat=0.80):
    h, l, s = colorsys.rgb_to_hls(*rgb)
    if s > max_sat:
        s = max_sat
    return colorsys.hls_to_rgb(h, l, s)


def saturation(rgb):
    _, _, s = colorsys.rgb_to_hls(*rgb)
    return s


def lighten(rgb, amount=0.1):
    h, l, s = colorsys.rgb_to_hls(*rgb)
    l = clamp(l + amount)
    return colorsys.hls_to_rgb(h, l, s)


def ensure_min_luminance(rgb, min_lum=0.20):
    if luminance(rgb) >= min_lum:
        return rgb
    h, l, s = colorsys.rgb_to_hls(*rgb)
    while luminance(colorsys.hls_to_rgb(h, l, s)) < min_lum and l < 1.0:
        l = clamp(l + 0.05)
    return colorsys.hls_to_rgb(h, l, s)


def is_green_hue(rgb):
    h, _, _ = colorsys.rgb_to_hls(*rgb)
    return 80 / 360 <= h <= 160 / 360


def derive_palette(data):
    special = data.get("special", {})
    colors = data.get("colors", {})

    palette = {k: clamp_saturation(hex_to_rgb(v)) for k, v in colors.items()}
    bg_rgb = clamp_saturation(hex_to_rgb(special.get("background", "#000000")))
    fg_rgb = clamp_saturation(hex_to_rgb(special.get("foreground", "#ffffff")))

    palette_sats = sorted(saturation(c) for c in palette.values())
    median_sat = palette_sats[len(palette_sats) // 2] if palette_sats else 0.0

    is_neutral = median_sat < 0.18
    if is_neutral:
        candidates = list(palette.values()) + [bg_rgb]
        candidates.sort(key=lambda c: (saturation(c), luminance(c)))
        bg_rgb = candidates[0]

    accent_candidates = [palette.get(f"color{i}") for i in range(1, 7) if palette.get(f"color{i}")]
    accent_pool = accent_candidates
    if is_neutral and accent_candidates:
        non_green = [c for c in accent_candidates if not is_green_hue(c)]
        if non_green:
            accent_pool = non_green

    accent_rgb = max(accent_pool, key=luminance) if accent_pool else palette.get("color1", fg_rgb)
    muted_rgb = ensure_min_luminance(palette.get("color8", fg_rgb), min_lum=0.18)
    warn_rgb = palette.get("color3", accent_rgb)
    secondary_rgb = palette.get("color2", accent_rgb)
    urgent_rgb = palette.get("color3", accent_rgb)

    fg_alt = palette.get("color15", fg_rgb)
    fg_best = fg_rgb
    if contrast_ratio(fg_alt, bg_rgb) > contrast_ratio(fg_best, bg_rgb):
        fg_best = fg_alt
    if contrast_ratio(fg_best, bg_rgb) < 4.5:
        fg_best = ensure_min_luminance(fg_best, min_lum=0.35)

    ui_bg = lighten(bg_rgb, 0.08)
    ui_border = lighten(bg_rgb, 0.18)

    return {
        "background": rgb_to_hex(bg_rgb),
        "foreground": rgb_to_hex(fg_best),
        "accent": rgb_to_hex(accent_rgb),
        "muted": rgb_to_hex(muted_rgb),
        "warn": rgb_to_hex(warn_rgb),
        "secondary": rgb_to_hex(secondary_rgb),
        "urgent": rgb_to_hex(urgent_rgb),
        "ui_bg": rgb_to_hex(ui_bg),
        "ui_border": rgb_to_hex(ui_border),
    }


def write_derived_json(path: Path, derived):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(derived, indent=2) + "\n")


def write_hypr_conf(path: Path, derived):
    def hex_nohash(value: str) -> str:
        return value.lstrip("#")

    lines = [
        f"$color_background = rgb({hex_nohash(derived['background'])})",
        f"$color_foreground = rgb({hex_nohash(derived['foreground'])})",
        f"$color_accent = rgb({hex_nohash(derived['accent'])})",
        f"$color_border = rgb({hex_nohash(derived['accent'])})",
        f"$color_secondary = rgb({hex_nohash(derived['secondary'])})",
        f"$color_urgent = rgb({hex_nohash(derived['urgent'])})",
        f"$color_muted = rgb({hex_nohash(derived['muted'])})",
    ]

    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text("\n".join(lines) + "\n")


def write_tmux_conf(path: Path, derived):
    lines = [
        f"set -g @wal_fg \"{derived['foreground']}\"",
        f"set -g @wal_bg \"{derived['background']}\"",
        f"set -g @wal_muted \"{derived['muted']}\"",
        f"set -g @wal_accent \"{derived['accent']}\"",
        f"set -g @wal_warn \"{derived['warn']}\"",
    ]

    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text("\n".join(lines) + "\n")


def main():
    args = parse_args()
    colors_path = Path(args.colors_json)
    if not colors_path.exists():
        return 0

    data = json.loads(colors_path.read_text())
    derived = derive_palette(data)

    write_derived_json(Path(args.derived_json), derived)
    write_hypr_conf(Path(args.hypr_conf), derived)
    write_tmux_conf(Path(args.tmux_conf), derived)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
