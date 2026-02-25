#!/usr/bin/env zsh

set -euo pipefail

if ((EUID != 0)); then
  sudo -v || exit 1
fi

base_packages=(
  base-devel
  xdg-desktop-portal
  xdg-desktop-portal-gtk
  xdg-desktop-portal-hyprland
  unzip
  zip
  xclip
  xorg-xinput
  wl-clipboard
  fzf
  ripgrep
  tldr
  lsof
  rsync
  reflector
  htop
  bc
  gtk-layer-shell
  python-gobject
)

network_packages=(
  network-manager-applet
  iw
  ufw
)

bluetooth_packages=(
  bluez
  bluez-utils
  bluez-deprecated-tools
  blueman
)

audio_packages=(
  alsa-lib
  alsa-utils
  pipewire
  pipewire-pulse
  pavucontrol
)

desktop_packages=(
  hyprland
  hyprpaper
  hyprlock
  hypridle
  waybar
  ly
  rofi
  mako
  ranger
  nautilus
  brightnessctl
  nwg-look
  firefox
  python-pywal
)

dev_packages=(
  strace
  zsh
  curl
  wget
  openssh
  go
  gcc
  git
  lazygit
  github-cli
  tmux
  tmuxp
  clang
  ninja
  xz
  mesa
  glibc
  bzip2
  docker
  kitty
  shfmt # shell formatter
  fd
)

font_packages=(
  ttf-firacode-nerd
  ttf-terminus-nerd
  ttf-ubuntu-mono-nerd
  ttf-iosevka-nerd
  ttf-iosevkaterm-nerd
  noto-fonts-cjk
  noto-fonts-emoji
)

packages=(
  grim
  vlc
  vlc-plugin-ffmpeg
  kooha    # screen recorder
  hyprshot # screenshot tool
  swappy   # screenshot annotation tool
)

echo "Installing packages..."
sudo pacman -S --noconfirm --needed ${base_packages[@]} ${network_packages[@]} ${bluetooth_packages[@]} ${audio_packages[@]} ${desktop_packages[@]} ${dev_packages[@]} ${font_packages[@]} ${packages[@]}
