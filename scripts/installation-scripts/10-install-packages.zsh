if ((EUID != 0)); then
  sudo -v || return 1
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
)

audio_pakages=(
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
sudo pacman -S --noconfirm --needed ${base_packages[@]} ${network_packages[@]} ${bluetooth_packages[@]} ${audio_pakages[@]} ${desktop_packages[@]} ${dev_packages[@]} ${font_packages[@]} ${packages[@]}
