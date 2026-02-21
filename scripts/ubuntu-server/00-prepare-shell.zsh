sudo apt install -y zsh

if [ "$SHELL" != "$(which zsh)" ]; then
  sudo chsh -s "$(which zsh)"
fi
