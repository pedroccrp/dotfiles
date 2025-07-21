setopt extended_glob null_glob

WORDCHARS='*?[]~=&;!#$%^(){}<>'

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~~~~
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt interactivecomments
setopt hist_ignore_dups
setopt hist_ignore_space
setopt share_history

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Completion ~~~~~~~~~~~~~~~~~~~~~~~~~~~
autoload -Uz compinit

if [[ ! -f ~/.zcompdump || $(find ~/.zcompdump -mtime +3 2>/dev/null) ]]; then
    compinit -d ~/.zcompdump
else
    compinit -C -d ~/.zcompdump
    touch ~/.zcompdump
fi
