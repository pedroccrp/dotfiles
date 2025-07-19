if ! command -v yay >/dev/null 2>&1; then
  echo "Please install yay first!"
  exit
fi

yay -S --needed --noconfirm \
  zsh-vi-mode \
  zsh-completions \
  zsh-syntax-highlighting \
  spaceship-prompt
