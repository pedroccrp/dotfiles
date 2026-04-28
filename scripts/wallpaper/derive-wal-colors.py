#!/usr/bin/env python3

import argparse
import colorsys
import json
from pathlib import Path


BLACK_RGB = (0.0, 0.0, 0.0)
PRIMARY_MIN_CONTRAST = 7.0
SECONDARY_MIN_CONTRAST = 4.5
INACTIVE_TEXT_MIN_CONTRAST = 3.0


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
    return "#%02x%02x%02x" % tuple(int(round(clamp(c) * 255)) for c in rgb)


def quantized_rgb(rgb):
    return hex_to_rgb(rgb_to_hex(rgb))


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


def darken(rgb, amount=0.15):
    h, l, s = colorsys.rgb_to_hls(*rgb)
    l = clamp(l - amount)
    return colorsys.hls_to_rgb(h, l, s)


def ensure_contrast_lighten_only(rgb, min_ratio):
    rgb_q = quantized_rgb(rgb)
    if contrast_ratio(rgb_q, BLACK_RGB) >= min_ratio:
        return rgb_q

    h, l, s = colorsys.rgb_to_hls(*rgb)
    lo = l
    hi = 1.0

    if contrast_ratio(quantized_rgb(colorsys.hls_to_rgb(h, hi, s)), BLACK_RGB) < min_ratio:
        return None

    for _ in range(24):
        mid = (lo + hi) / 2.0
        candidate = quantized_rgb(colorsys.hls_to_rgb(h, mid, s))
        if contrast_ratio(candidate, BLACK_RGB) >= min_ratio:
            hi = mid
        else:
            lo = mid

    return quantized_rgb(colorsys.hls_to_rgb(h, hi, s))


def fallback_light_same_hue(rgb, lightness=0.90):
    h, _, s = colorsys.rgb_to_hls(*rgb)
    return colorsys.hls_to_rgb(h, lightness, s)


def choose_on_color(background_rgb, preferred_rgb, min_ratio=4.5):
    preferred_q = quantized_rgb(preferred_rgb)
    if contrast_ratio(preferred_q, background_rgb) >= min_ratio:
        return preferred_q

    candidates = [
        quantized_rgb((1.0, 1.0, 1.0)),
        quantized_rgb((0.0, 0.0, 0.0)),
    ]
    valid = [c for c in candidates if contrast_ratio(c, background_rgb) >= min_ratio]
    if valid:
        valid.sort(key=lambda c: contrast_ratio(c, background_rgb), reverse=True)
        return valid[0]

    candidates.sort(key=lambda c: contrast_ratio(c, background_rgb), reverse=True)
    return candidates[0]


def is_green_hue(rgb):
    h, _, _ = colorsys.rgb_to_hls(*rgb)
    return 80 / 360 <= h <= 160 / 360


def derive_palette(data):
    special = data.get("special", {})
    colors = data.get("colors", {})

    palette = {k: clamp_saturation(hex_to_rgb(v)) for k, v in colors.items()}
    bg_rgb = BLACK_RGB
    fg_rgb = clamp_saturation(hex_to_rgb(special.get("foreground", "#ffffff")))

    palette_sats = sorted(saturation(c) for c in palette.values())
    median_sat = palette_sats[len(palette_sats) // 2] if palette_sats else 0.0

    is_neutral = median_sat < 0.18

    accent_candidates = [palette.get(f"color{i}") for i in range(1, 7) if palette.get(f"color{i}")]
    accent_pool = accent_candidates
    if is_neutral and accent_candidates:
        non_green = [c for c in accent_candidates if not is_green_hue(c)]
        if non_green:
            accent_pool = non_green

    accent_rgb = max(accent_pool, key=luminance) if accent_pool else palette.get("color1", fg_rgb)
    muted_base_rgb = palette.get("color8", fg_rgb)
    warn_rgb = palette.get("color3", accent_rgb)
    secondary_rgb = palette.get("color2", accent_rgb)
    urgent_rgb = palette.get("color3", accent_rgb)

    fg_alt = palette.get("color15", fg_rgb)
    fg_best = fg_rgb
    if contrast_ratio(fg_alt, bg_rgb) > contrast_ratio(fg_best, bg_rgb):
        fg_best = fg_alt

    adjusted_fg = ensure_contrast_lighten_only(fg_best, PRIMARY_MIN_CONTRAST)
    if adjusted_fg is None:
        fg_best = (1.0, 1.0, 1.0)
    else:
        fg_best = adjusted_fg

    def adjust_text_color(rgb):
        adjusted = ensure_contrast_lighten_only(rgb, SECONDARY_MIN_CONTRAST)
        if adjusted is not None:
            return adjusted

        fallback = fallback_light_same_hue(rgb)
        adjusted_fallback = ensure_contrast_lighten_only(fallback, SECONDARY_MIN_CONTRAST)
        if adjusted_fallback is not None:
            return adjusted_fallback

        h, _, s = colorsys.rgb_to_hls(*rgb)
        return colorsys.hls_to_rgb(h, 1.0, s)

    accent_rgb = adjust_text_color(accent_rgb)
    warn_rgb = adjust_text_color(warn_rgb)
    secondary_rgb = adjust_text_color(secondary_rgb)
    urgent_rgb = adjust_text_color(urgent_rgb)

    muted_text_rgb = adjust_text_color(muted_base_rgb)

    inactive_text_base = darken(muted_text_rgb, 0.20)
    adjusted_inactive = ensure_contrast_lighten_only(inactive_text_base, INACTIVE_TEXT_MIN_CONTRAST)
    if adjusted_inactive is None:
        inactive_text_rgb = fallback_light_same_hue(inactive_text_base, lightness=0.75)
    else:
        inactive_text_rgb = adjusted_inactive

    ui_bg = lighten(bg_rgb, 0.08)
    ui_border = lighten(bg_rgb, 0.18)
    ui_muted_rgb = muted_base_rgb
    inactive_rgb = darken(ui_muted_rgb, 0.20)
    on_accent_rgb = choose_on_color(accent_rgb, fg_best, min_ratio=SECONDARY_MIN_CONTRAST)
    on_warn_rgb = choose_on_color(warn_rgb, fg_best, min_ratio=SECONDARY_MIN_CONTRAST)
    on_secondary_rgb = choose_on_color(secondary_rgb, fg_best, min_ratio=SECONDARY_MIN_CONTRAST)
    on_urgent_rgb = choose_on_color(urgent_rgb, fg_best, min_ratio=SECONDARY_MIN_CONTRAST)
    on_muted_rgb = choose_on_color(ui_muted_rgb, fg_best, min_ratio=SECONDARY_MIN_CONTRAST)

    return {
        "background": rgb_to_hex(bg_rgb),
        "foreground": rgb_to_hex(fg_best),
        "accent": rgb_to_hex(accent_rgb),
        "on_accent": rgb_to_hex(on_accent_rgb),
        "muted": rgb_to_hex(ui_muted_rgb),
        "on_muted": rgb_to_hex(on_muted_rgb),
        "muted_text": rgb_to_hex(muted_text_rgb),
        "warn": rgb_to_hex(warn_rgb),
        "on_warn": rgb_to_hex(on_warn_rgb),
        "secondary": rgb_to_hex(secondary_rgb),
        "on_secondary": rgb_to_hex(on_secondary_rgb),
        "urgent": rgb_to_hex(urgent_rgb),
        "on_urgent": rgb_to_hex(on_urgent_rgb),
        "ui_bg": rgb_to_hex(ui_bg),
        "ui_border": rgb_to_hex(ui_border),
        "inactive": rgb_to_hex(inactive_rgb),
        "inactive_text": rgb_to_hex(inactive_text_rgb),
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
        f"set -g @wal_muted_text \"{derived['muted_text']}\"",
        f"set -g @wal_ui_muted \"{derived['muted']}\"",
        f"set -g @wal_accent \"{derived['accent']}\"",
        f"set -g @wal_warn \"{derived['warn']}\"",
        f"set -g @wal_inactive \"{derived['inactive']}\"",
        f"set -g @wal_inactive_text \"{derived['inactive_text']}\"",
    ]

    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text("\n".join(lines) + "\n")


def write_waybar_css(path: Path, derived):
    lines = [
        f"@define-color primary {derived['background']};",
        f"@define-color text-primary {derived['foreground']};",
        f"@define-color text-focused {derived['accent']};",
        f"@define-color border {derived['ui_border']};",
    ]

    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text("\n".join(lines) + "\n")


def write_rofi_rasi(path: Path, derived):
    lines = [
        "* {",
        f"  primary: {derived['background']};",
        f"  text-primary: {derived['foreground']};",
        f"  text-secondary: {derived['accent']};",
        f"  border: {derived['ui_border']};",
        "}",
    ]

    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text("\n".join(lines) + "\n")


def write_mako_conf(path: Path, derived):
    lines = [
        f"background-color={derived['background']}",
        f"text-color={derived['foreground']}",
        "markup=1",
        "",
        "[urgency=low]",
        f"border-color={derived['ui_border']}",
        f"format=<span foreground=\"{derived['muted_text']}\">•</span> <b>%s</b>\\n%b",
        "",
        "[urgency=normal]",
        f"border-color={derived['ui_border']}",
        f"format=<span foreground=\"{derived['secondary']}\">●</span> <b>%s</b>\\n%b",
        "",
        "[urgency=high]",
        f"border-color={derived['warn']}",
        f"format=<span foreground=\"{derived['warn']}\">⚠</span> <b>%s</b>\\n%b",
        "default-timeout=0",
    ]

    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text("\n".join(lines) + "\n")


def write_kitty_conf(path: Path, derived):
    colors = {
        "color0": derived["background"],
        "color1": derived["warn"],
        "color2": derived["secondary"],
        "color3": derived["warn"],
        "color4": derived["accent"],
        "color5": derived["secondary"],
        "color6": derived["accent"],
        "color7": derived["foreground"],
        "color8": derived["muted"],
        "color9": derived["warn"],
        "color10": derived["secondary"],
        "color11": derived["warn"],
        "color12": derived["accent"],
        "color13": derived["secondary"],
        "color14": derived["accent"],
        "color15": derived["foreground"],
    }

    lines = [
        f"foreground {derived['foreground']}",
        f"background {derived['background']}",
        f"selection_foreground {derived['foreground']}",
        f"selection_background {derived['ui_bg']}",
        f"cursor {derived['foreground']}",
        f"cursor_text_color {derived['background']}",
        f"url_color {derived['accent']}",
        f"active_tab_foreground {derived['foreground']}",
        f"active_tab_background {derived['ui_bg']}",
        f"inactive_tab_foreground {derived['inactive_text']}",
        f"inactive_tab_background {derived['background']}",
        f"active_border_color {derived['accent']}",
        f"inactive_border_color {derived['ui_border']}",
    ]

    lines.extend(f"{key} {value}" for key, value in colors.items())

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

    cache_dir = Path(args.derived_json).parent
    write_waybar_css(cache_dir / "waybar.css", derived)
    write_mako_conf(cache_dir / "mako.conf", derived)
    write_rofi_rasi(cache_dir / "rofi.rasi", derived)
    write_kitty_conf(cache_dir / "colors-kitty.conf", derived)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
