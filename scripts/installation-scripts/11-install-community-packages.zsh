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

light_packages=(
  asdf-vm \
  autojump \
  indicator-sound-switcher \
  scrcpy \
  timeshift \
  waybar-module-pacman-updates-git
)

heavy_packages=(
  android-sdk-cmdline-tools-latest \
  stremio \
  postman-bin
)

yay -S --needed --noconfirm ${light_packages[@]} ${heavy_packages[@]}
