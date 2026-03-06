#!/usr/bin/env zsh

set -euo pipefail

if ((EUID != 0)); then
  sudo -v || exit 1
fi

system=(
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

network=(
  network-manager-applet
  iw
  ufw
)

bluetooth=(
  bluez
  bluez-utils
  bluez-deprecated-tools
  blueman
)

audio=(
  alsa-lib
  alsa-utils
  pipewire
  pipewire-pulse
  pavucontrol
)

desktop=(
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

dev_tools=(
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
  shfmt
  fd
)

languages=()

fonts=(
  ttf-firacode-nerd
  noto-fonts-cjk
  noto-fonts-emoji
)

media=(
  grim
  vlc
  vlc-plugin-ffmpeg
  kooha
  hyprshot
  swappy
  oculante
)

echo "Installing packages..."
sudo pacman -S --noconfirm --needed \
  "${system[@]}" \
  "${network[@]}" \
  "${bluetooth[@]}" \
  "${audio[@]}" \
  "${desktop[@]}" \
  "${dev_tools[@]}" \
  "${languages[@]}" \
  "${fonts[@]}" \
  "${media[@]}"
