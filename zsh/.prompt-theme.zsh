function update_git_info() {
  local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  if [[ -n $branch ]]; then
    GIT_INFO=" on %F{magenta}$branch%f"
  else
    GIT_INFO=""
  fi
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd update_git_info

PROMPT="%F{cyan}%n@%m%f %F{blue}%~%f${GIT_INFO}
%(?.%F{green}➜.%F{red}➜)%f "
