source $HOME/dotfiles/zsh/.environment.zsh
source $HOME/dotfiles/zsh/.aliases.zsh
source $HOME/dotfiles/zsh/.paths.zsh
source $HOME/dotfiles/zsh/.bindings.zsh
source $HOME/dotfiles/zsh/.theme.zsh
source $HOME/dotfiles/zsh/.configs.zsh
source $HOME/dotfiles/zsh/.plugins.zsh

if [ "$TMUX" = "" ]; then tmux attach || tmux; fi
