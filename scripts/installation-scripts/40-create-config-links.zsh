DOTFILES=$HOME/dotfiles

ln -sf $DOTFILES/tmux/.tmux.conf $HOME/.tmux.conf
if [ -d $HOME/.config/nvim ]; then rm -rf $HOME/.config/nvim; fi
ln -sf $DOTFILES/nvim $HOME/.config/nvim
if [ -d $HOME/.ideavimrc ]; then rm -rf $HOME/.ideavimrc; fi
ln -sf $DOTFILES/ideavim/.ideavimrc $HOME/.ideavimrc
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
if [ -d $HOME/.config/rofi ]; then rm -rf $HOME/.config/rofi; fi
ln -sf $DOTFILES/rofi $HOME/.config/rofi
if [ -d $HOME/.config/mako ]; then rm -rf $HOME/.config/mako; fi
ln -sf $DOTFILES/mako $HOME/.config/mako
if [ -d $HOME/.config/lazygit ]; then rm -rf $HOME/.config/lazygit; fi
ln -sf $DOTFILES/lazygit $HOME/.config/lazygit
if [ ! -d $HOME/.config/opencode ]; then mkdir -p $HOME/.config/opencode; fi
if [ -d $HOME/.config/opencode/opencode.jsonc ]; then rm -rf $HOME/.config/opencode/opencode.jsonc; fi
if [ -d $HOME/.config/opencode/opencode.json ]; then rm -rf $HOME/.config/opencode/opencode.json; fi
ln -sf $DOTFILES/opencode/opencode.jsonc $HOME/.config/opencode/opencode.jsonc
if [ -d $HOME/.config/opencode/AGENTS.md ]; then rm -rf $HOME/.config/opencode/AGENTS.md; fi
ln -sf $DOTFILES/opencode/AGENTS.md $HOME/.config/opencode/AGENTS.md
if [ -d $HOME/.config/opencode/agents ]; then rm -rf $HOME/.config/opencode/agents; fi
ln -sf $DOTFILES/opencode/agents $HOME/.config/opencode/agents
