source $HOME/dotfiles/zsh/configs.zsh
source $HOME/dotfiles/zsh/environment.zsh
source $HOME/dotfiles/zsh/aliases.zsh
source $HOME/dotfiles/zsh/paths.zsh
source $HOME/dotfiles/zsh/prompt-theme.zsh
source $HOME/dotfiles/zsh/plugins.zsh
source $HOME/dotfiles/zsh/bindings.zsh

for file in $HOME/dotfiles/zsh/scripts/*.zsh; do
  source "$file"
done
