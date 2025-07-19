if [ $(id -u) -ne 0 ]
  then echo Please run this script as root or using sudo!
  exit
fi

base_packages=(
	base-devel
  unzip
  xclip
  fzf
  ripgrep
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
	sway
	ly
)

dev_packages=(
	zsh
  curl
	openssh
	go
  gcc
	git
	github-cli
	tmux
)

packages=(
	firefox
	bitwarden-cli
)

echo "Installing packages..."
yes | pacman -S --needed ${base_packages[@]} ${bluetooth_packages[@]} ${audio_pakages[@]} ${desktop_packages[@]} ${dev_packages[@]} ${packages[@]}

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
