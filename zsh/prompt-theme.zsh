_git_prompt_cache=""
_ssh_prompt_cache=""

function _update_prompt_cache() {
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    if [ -z "$branch" ]; then
      branch=$(git rev-parse --short HEAD 2>/dev/null)
      [ -n "$branch" ] && branch="detached@$branch"
    fi
    _git_prompt_cache=" on %F{magenta}${branch}%f"
  else
    _git_prompt_cache=""
  fi

  if [ -n "$SSH_CONNECTION" ] || [ -n "$SSH_TTY" ]; then
    _ssh_prompt_cache="%F{red}%B[SSH]%b%f "
  else
    _ssh_prompt_cache=""
  fi

  PROMPT='%F{cyan}%n@%m%f %F{blue}%~%f'"$_git_prompt_cache"'
'"$_ssh_prompt_cache"'%(?.%F{green}➜ .%F{red}➜ )%f '
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _update_prompt_cache
