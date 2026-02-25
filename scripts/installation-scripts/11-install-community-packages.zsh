#!/usr/bin/env zsh

set -euo pipefail

install_yay() {
    local tmpdir
    tmpdir=$(mktemp -d)
    trap "rm -rf $tmpdir" EXIT

    echo "Installing yay..."
    git clone https://aur.archlinux.org/yay.git "$tmpdir/yay" >&2
    chown "$USER:$USER" "$tmpdir/yay" -R
    (cd "$tmpdir/yay" && makepkg -si --noconfirm --needed) || return 1
}

if ! command -v yay >/dev/null 2>&1; then
    install_yay
fi

if ! command -v yay >/dev/null 2>&1; then
    echo "Some error happened with installation, please check yay first!" >&2
    exit 1
fi

echo "Yay already installed!"

yay -S --needed --noconfirm \
  android-sdk-cmdline-tools-latest \
  neofetch \
  stremio \
  asdf-vm \
  autojump \
  scrcpy \
  indicator-sound-switcher \
  postman-bin \
  timeshift \
  waybar-module-pacman-updates-git \
  hyprshade
