export MYVIMRC="~/.vim/vimrc"
export EDITOR="nvim"
export VISUAL="nvim"
export BROWSER="firefox"
export MANPAGER="nvim +Man!"

if [ -n "$SSH_CONNECTION" ] || [ -n "$SSH_TTY" ]; then
  export TERM=xterm-256color
fi

export DOTFILES=$HOME/dotfiles
export NOTES=$HOME/notes
export ZSH=$DOTFILES/zsh
export ZSH_PLUGINS=$ZSH/plugins
export ANDROID_HOME=/opt/android-sdk
