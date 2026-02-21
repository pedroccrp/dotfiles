setopt prompt_subst

function git_prompt() {
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    if [ -z "$branch" ]; then
      branch=$(git rev-parse --short HEAD 2>/dev/null)
      [ -n "$branch" ] && branch="detached@$branch"
    fi
    echo " on %F{magenta}${branch}%f"
  fi
}

function ssh_prompt_prefix() {
  if [ -n "$SSH_CONNECTION" ] || [ -n "$SSH_TTY" ]; then
    echo "%F{red}%B[SSH]%b%f "
  fi
}

PROMPT='%F{cyan}%n@%m%f %F{blue}%~%f$(git_prompt)
$(ssh_prompt_prefix)%(?.%F{green}➜ .%F{red}➜ )%f '
