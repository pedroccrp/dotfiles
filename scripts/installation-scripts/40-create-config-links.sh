DOTFILES=$HOME/dotfiles

ln -sf $DOTFILES/tmux/.tmux.conf $HOME/.tmux.conf
if [ -d $HOME/.config/nvim ]; then rm -rf $HOME/.config/nvim; fi
ln -sf $DOTFILES/nvim $HOME/.config/nvim
ln -sf $DOTFILES/zsh/.zshrc $HOME/.zshrc
if [ -d $HOME/.config/kitty ]; then rm -rf $HOME/.config/kitty; fi
ln -sf $DOTFILES/kitty $HOME/.config/kitty
if [ -d $HOME/.config/hypr ]; then rm -rf $HOME/.config/hypr; fi
ln -sf $DOTFILES/hypr $HOME/.config/hypr
if [ -d $HOME/.xkb/symbols ]; then rm -rf $HOME/.xkb/symbols; fi
mkdir -p ~/.xkb/symbols
ln -sf $DOTFILES/xkb/br_custom $HOME/.xkb/symbols/br_custom
if [ -d $HOME/.config/waybar ]; then rm -rf $HOME/.config/waybar; fi
ln -sf $DOTFILES/waybar $HOME/.config/waybar
if [ -d $HOME/.config/wofi ]; then rm -rf $HOME/.config/wofi; fi
ln -sf $DOTFILES/wofi $HOME/.config/wofi
