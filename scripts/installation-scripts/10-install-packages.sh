if [ $(id -u) -ne 0 ]
  then echo Please run this script as root or using sudo!
  exit
fi

base_packages=(
	base-devel
  xdg-desktop-portal
  xdg-desktop-portal-gtk
  xdg-desktop-portal-hyprland
  unzip
  zip
  xclip
  wl-clipboard
  fzf
  ripgrep
  tldr
  lsof
)

network_packages=(
  network-manager-applet
  iw
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
  waybar
  ly
  wofi
  mako
  ranger
  nautilus
  brightnessctl
  nwg-look
)

dev_packages=(
  strace
  zsh
  curl
  openssh
  go
  gcc
  git
  lazygit
  github-cli
  tmux
  clang
  cmake
  ninja
  xz
  mesa
  glibc
  bzip2
  docker
)

font_packages=(
  ttf-firacode-nerd
  ttf-terminus-nerd
  ttf-ubuntu-mono-nerd
  ttf-iosevka-nerd
  ttf-iosevkaterm-nerd
)

packages=(
  grim
  vlc
	bitwarden-cli
)

echo "Installing packages..."
yes | pacman -S --needed ${base_packages[@]} ${network_packages[@]} ${bluetooth_packages[@]} ${audio_pakages[@]} ${desktop_packages[@]} ${dev_packages[@]} ${font_packages[@]} ${packages[@]}

# Install YAY
if ! command -v yay >/dev/null 2>&1; then
    echo "Installing yay..."
    git clone https://aur.archlinux.org/yay.git /tmp/yay &>/dev/null
    pushd /tmp/yay &>/dev/null
    makepkg -si 2>/dev/null
    popd &>/dev/null
    yay -Syu
else
    echo "Yay already installed!"
fi
