#!/usr/bin/env zsh

set -euo pipefail

# Install YAY
if ! command -v yay >/dev/null 2>&1; then
    echo "Installing yay..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay &>/dev/null
    cd /tmp/yay &>/dev/null
    chown $USER:$USER . -R
    makepkg -si 2>/dev/null
    cd - &>/dev/null
    yay -Syu
else
    echo "Yay already installed!"
fi

if ! command -v yay >/dev/null 2>&1; then
  echo "Some error happened with installation, please check yay first!"
  exit 1
fi

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
