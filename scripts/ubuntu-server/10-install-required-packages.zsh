#!/usr/bin/env zsh

echo "Installing required packages..."

sudo apt update

sudo apt install -y zsh zsh-autosuggestions zsh-syntax-highlighting fzf

sudo apt install -y git curl wget unzip

sudo apt install -y ripgrep

sudo apt install -y build-essential gcc clang

sudo apt install -y lua5.1 liblua5.1-0-dev

sudo apt install -y python3 python3-pip nodejs npm ruby

sudo apt install -y tmux

if [ ! -d ~/.tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

echo "Done!"
