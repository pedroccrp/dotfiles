if ! command -v yay >/dev/null 2>&1; then
  echo "Please install yay first!"
  exit
fi

yay -S --needed --noconfirm \
  android-sdk-cmdline-tools-latest \
  neofetch \
  stremio \
  asdf-vm \
  autojump \
  scrcpy \
  indicator-sound-switcher \
  postman-bin \
  flameshot-git \
  timeshift \
