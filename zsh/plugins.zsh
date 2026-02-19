# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ AUR ~~~~~~~~~~~~~~~~~~~~~~~~~~~
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~ Manual ~~~~~~~~~~~~~~~~~~~~~~~~~
if [ -z "$SSH_CONNECTION" ]; then
  source $HOME/.local/share/zsh/plugins/flatpak-zsh-completion/flatpak.plugin.zsh
fi

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ FzF ~~~~~~~~~~~~~~~~~~~~~~~~~~~
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Personal ~~~~~~~~~~~~~~~~~~~~~~
source $HOME/dotfiles/zsh/custom-plugins/vi-mode.zsh
source $HOME/dotfiles/zsh/custom-plugins/tmux-session-kill.zsh
