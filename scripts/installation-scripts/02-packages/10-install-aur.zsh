#!/usr/bin/env zsh

set -euo pipefail

if ! command -v yay >/dev/null 2>&1; then
  echo "Please install yay first!"
  exit 1
fi

install_heavy=false
if [[ "${1:-}" == "--with-heavy" || "${1:-}" == "-y" ]]; then
  install_heavy=true
fi

light_packages=(
  asdf-vm
  autojump
  indicator-sound-switcher
  scrcpy
  timeshift
  waybar-module-pacman-updates-git
)

heavy_packages=(
  android-sdk-cmdline-tools-latest
  stremio
  postman-bin
)

echo "Installing light AUR packages..."
yay -S --needed --noconfirm "${light_packages[@]}"

if $install_heavy; then
  echo "Installing heavy AUR packages..."
  yay -S --needed --noconfirm "${heavy_packages[@]}"
else
  echo "Skipping heavy AUR packages. Run with --with-heavy to install them."
fi
