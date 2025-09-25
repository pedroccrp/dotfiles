if ! command -v yay >/dev/null 2>&1; then
  echo "Please install yay first!"
  exit
fi

yay -S --needed --noconfirm \
  zsh-completions \
  zsh-syntax-highlighting \
  zsh-autosuggestions

git clone git@github.com:bilelmoussaoui/flatpak-zsh-completion.git \
          ~/.local/share/zsh/plugins/flatpak-zsh-completion
