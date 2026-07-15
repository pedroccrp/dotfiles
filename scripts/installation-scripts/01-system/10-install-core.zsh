#!/usr/bin/env zsh

set -euo pipefail

if (( EUID != 0 )); then
  sudo -v || exit 1
fi

packages=(
  neovim
)

gpu="${1:-none}"

if [[ "$gpu" == "nvidia" ]]; then
  packages+=(nvidia-dkms linux-headers)
fi

sudo pacman -S --noconfirm --needed "${packages[@]}"
