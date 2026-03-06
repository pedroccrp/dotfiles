#!/usr/bin/env zsh

set -euo pipefail

DOTFILES=$HOME/dotfiles

sudo mkdir -p /etc/pacman.d/hooks
if [ -f /etc/pacman.d/hooks/timeshift.hook ] || [ -L /etc/pacman.d/hooks/timeshift.hook ]; then
  sudo rm -f /etc/pacman.d/hooks/timeshift.hook
fi
sudo ln -sf $DOTFILES/arch/pacman-hooks/timeshift.hook /etc/pacman.d/hooks/timeshift.hook
