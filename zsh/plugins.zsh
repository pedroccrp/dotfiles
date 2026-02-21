# ~~~~~~~~~~~~~~~~~~~~~~~~~~ AUR/APT ~~~~~~~~~~~~~~~~~~~~~~~~~
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
elif [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~ Manual ~~~~~~~~~~~~~~~~~~~~~~~~~
if [ -z "$SSH_CONNECTION" ]; then
  source $HOME/.local/share/zsh/plugins/flatpak-zsh-completion/flatpak.plugin.zsh
fi

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ FzF ~~~~~~~~~~~~~~~~~~~~~~~~~~~
if [ -f /usr/share/fzf/key-bindings.zsh ]; then
  source /usr/share/fzf/key-bindings.zsh
elif [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]; then
  source /usr/share/doc/fzf/examples/key-bindings.zsh
fi

if [ -f /usr/share/fzf/completion.zsh ]; then
  source /usr/share/fzf/completion.zsh
elif [ -f /usr/share/doc/fzf/examples/completion.zsh ]; then
  source /usr/share/doc/fzf/examples/completion.zsh
fi

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Personal ~~~~~~~~~~~~~~~~~~~~~~
source $HOME/dotfiles/zsh/custom-plugins/vi-mode.zsh
source $HOME/dotfiles/zsh/custom-plugins/tmux-session-kill.zsh

# ~~~~~~~~~~~~~~~~~~~~~~ Syntax Highlighting ~~~~~~~~~~~~~~~~~
if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
elif [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi
