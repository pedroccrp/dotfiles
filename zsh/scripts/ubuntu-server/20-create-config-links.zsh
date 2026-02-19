#!/usr/bin/env zsh

DOTFILES=$HOME/dotfiles

if [ -d $HOME/.tmux.conf ]; then rm -rf $HOME/.tmux.conf; fi
ln -sf $DOTFILES/tmux/.tmux.conf $HOME/.tmux.conf

if [ -d $HOME/.config/nvim ]; then rm -rf $HOME/.config/nvim; fi
ln -sf $DOTFILES/nvim $HOME/.config/nvim

if [ -d $HOME/.zshrc ]; then rm -rf $HOME/.zshrc; fi
ln -sf $DOTFILES/zsh/.zshrc $HOME/.zshrc
