#!/usr/bin/env zsh

set -euo pipefail

if (( EUID != 0 )); then
  sudo -v || exit 1
fi

# Bluetooth
echo "Starting bluetooth services..."
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

sudo systemctl enable docker.service
sudo usermod -aG docker $USER

sudo systemctl enable ly@tty2.service
sudo systemctl start ly@tty2.service

sudo ufw default deny
sudo ufw enable
