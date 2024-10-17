#----------------------------------------------------------------------------------------------------
# Oh My Zsh
#----------------------------------------------------------------------------------------------------

export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="spaceship"
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"
VI_MODE_SET_CURSOR=true
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true

plugins=(
    git
    zsh-autosuggestions
    # zsh-vi-mode
    npm
    fzf
    asdf
    flutter
    gh
    ruby
    rails
    docker
)

source $ZSH/oh-my-zsh.sh

#----------------------------------------------------------------------------------------------------
# Configurations
#----------------------------------------------------------------------------------------------------

export MYVIMRC="~/.vim/vimrc"
export EDITOR='nvim'
export VISUAL='nvim'

setopt extendedglob

export FZF_BASE=$HOME/.oh-my-zsh/plugins/fzf

. /usr/share/autojump/autojump.sh

#----------------------------------------------------------------------------------------------------
# Aliases
#----------------------------------------------------------------------------------------------------

alias reload='source ~/.zshrc'

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

alias vim=nvim

#----------------------------------------------------------------------------------------------------
# Aliases (Methods)
#----------------------------------------------------------------------------------------------------

dotfiles() {
  cd ~/dotfiles
}

best_release() {
  grep -F -x -v -f <(git log "$1" --pretty=format:"%s" | sed 's/ (#[0-9]*)//g') <(git log "$2" --pretty=format:"%s" | sed 's/ (#[0-9]*)//g') | uniq | grep -e DPMS -e DUV -e SDPMS
}

best_release_hash() {
  git log "$2" --pretty=format:"%H - %s" | grep -f <(best_release "$1" "$2")
}

fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" | fzf -m --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

lowercase_user_folders() {
  cd ~

  sed -ri 's/[a-zA-Z]+\"/\L&/g' .config/user-dirs.dirs

  folders=( "Desktop" "Documents" "Downloads" "Music" "Pictures" "Public" "Templates" "Videos" )
  for i in "${folders[@]}"
  do
    mv $i $(echo $i | tr '[:upper:]' '[:lower:]') &> /dev/null
  done
}

j() {
    local preview_cmd="ls {2..}"
    if command -v exa &> /dev/null; then
        preview_cmd="exa -l {2}"
    fi

    if [[ $# -eq 0 ]]; then
                 cd "$(autojump -s | sort -k1gr | awk -F : '$1 ~ /[0-9]/ && $2 ~ /^\s*\// {print $1 $2}' | fzf --height 40% --reverse --inline-info --preview "$preview_cmd" --preview-window down:50% | cut -d$'\t' -f2- | sed 's/^\s*//')"
    else
        cd $(autojump $@)
    fi
}

#----------------------------------------------------------------------------------------------------
# Miscellaneous
#----------------------------------------------------------------------------------------------------

fpath=(~/.zsh/completions $HOME/.oh-my-zsh/plugins/git $HOME/.oh-my-zsh/functions $HOME/.oh-my-zsh/completions $HOME/.oh-my-zsh/cache/completions /usr/local/share/zsh/site-functions /usr/share/zsh/vendor-functions /usr/share/zsh/vendor-completions /usr/share/zsh/functions/Calendar /usr/share/zsh/functions/Chpwd /usr/share/zsh/functions/Completion /usr/share/zsh/functions/Completion/AIX /usr/share/zsh/functions/Completion/BSD /usr/share/zsh/functions/Completion/Base /usr/share/zsh/functions/Completion/Cygwin /usr/share/zsh/functions/Completion/Darwin /usr/share/zsh/functions/Completion/Debian /usr/share/zsh/functions/Completion/Linux /usr/share/zsh/functions/Completion/Mandriva /usr/share/zsh/functions/Completion/Redhat /usr/share/zsh/functions/Completion/Solaris /usr/share/zsh/functions/Completion/Unix /usr/share/zsh/functions/Completion/X /usr/share/zsh/functions/Completion/Zsh /usr/share/zsh/functions/Completion/openSUSE /usr/share/zsh/functions/Exceptions /usr/share/zsh/functions/MIME /usr/share/zsh/functions/Math /usr/share/zsh/functions/Misc /usr/share/zsh/functions/Newuser /usr/share/zsh/functions/Prompts /usr/share/zsh/functions/TCP /usr/share/zsh/functions/VCS_Info /usr/share/zsh/functions/VCS_Info/Backends /usr/share/zsh/functions/Zftp /usr/share/zsh/functions/Zle ${ASDF_DIR}/completions $ZSH_CUSTOM/plugins/gh.zsh)

autoload -Uz compinit; compinit -C
(autoload -Uz compinit; compinit &)

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions



# Custom commands

# On Startup
if [ "$TMUX" = "" ]; then tmux attach || tmux; fi
