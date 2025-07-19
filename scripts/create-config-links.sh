DOTFILES=$HOME/dotfiles

ln -sf $DOTFILES/tmux/.tmux.conf $HOME/.tmux.conf
if [ -d $HOME/.config/nvim ]; then rm -rf $HOME/.config/nvim; fi
ln -sf $DOTFILES/nvim $HOME/.config/nvim
ln -sf $DOTFILES/zsh/.zshrc $HOME/.zshrc
if [ -d $HOME/.config/kitty ]; then rm -rf $HOME/.config/kitty; fi
ln -sf $DOTFILES/kitty $HOME/.config/kitty
