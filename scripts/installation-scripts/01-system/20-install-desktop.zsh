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
  tealdeer
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
  wireguard-tools
  openresolv
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
  jq
  the_silver_searcher
  python-setuptools # Needed for indicator-sound-switcher
  python-build # Needed for some libs
  stylua
  perl-io-socket-ssl # Needed for git send-email
  perl-authen-sasl # Needed for git send-email
  perl-net-smtp-ssl # Needed for git send-email
  codespell # Linux Kernel development
  man-db
  man-pages
)

languages=()

fonts=(
  ttf-firacode-nerd
  noto-fonts-cjk # Ensure Japanese/Chinese glyphs
  noto-fonts-emoji # Ensure emojis exist
)

media=(
  grim
  vlc
  vlc-plugin-ffmpeg
  kooha
  hyprshot
  satty
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
