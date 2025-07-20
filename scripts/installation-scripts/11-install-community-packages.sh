if ! command -v yay >/dev/null 2>&1; then
  echo "Please install yay first!"
  exit
fi

yay -S --needed --noconfirm \
  neofetch \
  stremio \
  asdf-vm \
  autojump \
  scrcpy \
  indicator-sound-switcher
