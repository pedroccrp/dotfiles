source $HOME/dotfiles/zsh/.environment.zsh
source $HOME/dotfiles/zsh/.aliases.zsh
source $HOME/dotfiles/zsh/.paths.zsh
source $HOME/dotfiles/zsh/.plugins.zsh
source $HOME/dotfiles/zsh/.theme.zsh

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Configurations ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

bindkey -e

setopt extended_glob null_glob

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt hist_ignore_dups
setopt hist_ignore_space
setopt share_history

bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search

# autoload -Uz compinit && compinit

# HYPHEN_INSENSITIVE="true"
# COMPLETION_WAITING_DOTS="true"
# HIST_STAMPS="yyyy-mm-dd"
# VI_MODE_SET_CURSOR=true
# VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true
#
# plugins=(
#     git
#     zsh-autosuggestions
#     npm
#     fzf
#     asdf
#     flutter
#     gh
#     ruby
#     rails
#     docker
# )

# . /usr/share/autojump/autojump.sh


#----------------------------------------------------------------------------------------------------
# Miscellaneous
#----------------------------------------------------------------------------------------------------

# fpath=(~/.zsh/completions $HOME/.oh-my-zsh/plugins/git $HOME/.oh-my-zsh/functions $HOME/.oh-my-zsh/completions $HOME/.oh-my-zsh/cache/completions /usr/local/share/zsh/site-functions /usr/share/zsh/vendor-functions /usr/share/zsh/vendor-completions /usr/share/zsh/functions/Calendar /usr/share/zsh/functions/Chpwd /usr/share/zsh/functions/Completion /usr/share/zsh/functions/Completion/AIX /usr/share/zsh/functions/Completion/BSD /usr/share/zsh/functions/Completion/Base /usr/share/zsh/functions/Completion/Cygwin /usr/share/zsh/functions/Completion/Darwin /usr/share/zsh/functions/Completion/Debian /usr/share/zsh/functions/Completion/Linux /usr/share/zsh/functions/Completion/Mandriva /usr/share/zsh/functions/Completion/Redhat /usr/share/zsh/functions/Completion/Solaris /usr/share/zsh/functions/Completion/Unix /usr/share/zsh/functions/Completion/X /usr/share/zsh/functions/Completion/Zsh /usr/share/zsh/functions/Completion/openSUSE /usr/share/zsh/functions/Exceptions /usr/share/zsh/functions/MIME /usr/share/zsh/functions/Math /usr/share/zsh/functions/Misc /usr/share/zsh/functions/Newuser /usr/share/zsh/functions/Prompts /usr/share/zsh/functions/TCP /usr/share/zsh/functions/VCS_Info /usr/share/zsh/functions/VCS_Info/Backends /usr/share/zsh/functions/Zftp /usr/share/zsh/functions/Zle ${ASDF_DIR}/completions $ZSH_CUSTOM/plugins/gh.zsh)
#
# autoload -Uz compinit; compinit -C
# (autoload -Uz compinit; compinit &)
#

# Custom commands

if [ "$TMUX" = "" ]; then tmux attach || tmux; fi
