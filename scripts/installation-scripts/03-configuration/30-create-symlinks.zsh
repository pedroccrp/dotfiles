#!/usr/bin/env zsh

set -euo pipefail

DOTFILES=$HOME/dotfiles

link() {
    local src="$1"
    local dest="$2"
    local parent
    parent=$(dirname "$dest")
    
    mkdir -p "$parent"
    [[ -e "$dest" || -L "$dest" ]] && rm -rf "$dest"
    ln -sf "$src" "$dest"
}

link "$DOTFILES/tmux/.tmux.conf" "$HOME/.tmux.conf"
link "$DOTFILES/nvim" "$HOME/.config/nvim"
link "$DOTFILES/ideavim/.ideavimrc" "$HOME/.ideavimrc"
link "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
link "$DOTFILES/kitty" "$HOME/.config/kitty"
link "$DOTFILES/hypr" "$HOME/.config/hypr"
link "$DOTFILES/xkb/br_custom" "$HOME/.xkb/symbols/br_custom"
link "$DOTFILES/waybar" "$HOME/.config/waybar"
link "$DOTFILES/rofi" "$HOME/.config/rofi"
link "$DOTFILES/mako" "$HOME/.config/mako"
link "$DOTFILES/lazygit" "$HOME/.config/lazygit"
link "$DOTFILES/colors/default/gtk-3.0-settings.ini" "$HOME/.config/gtk-3.0/settings.ini"
link "$DOTFILES/colors/default/gtk-4.0-settings.ini" "$HOME/.config/gtk-4.0/settings.ini"
link "$DOTFILES/opencode/opencode.jsonc" "$HOME/.config/opencode/opencode.jsonc"
link "$DOTFILES/opencode/AGENTS.md" "$HOME/.config/opencode/AGENTS.md"
link "$DOTFILES/opencode/agents" "$HOME/.config/opencode/agents"
