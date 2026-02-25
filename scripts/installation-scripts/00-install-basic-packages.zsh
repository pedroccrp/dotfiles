#!/usr/bin/env zsh

set -euo pipefail

if (( EUID != 0 )); then
  sudo -v || exit 1
fi

sudo pacman -S --noconfirm --needed \
  neovim \
  nvidia-dkms \
  linux-headers
