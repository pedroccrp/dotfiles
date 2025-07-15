path=(
  $path
)

fpath=(
  $fpath
  $ZSH/completions
  $ZSH_PLUGINS/zsh-completions/src
)

typeset -U path fpath

# Clears paths of invalid entries
path=($^path(N-/))
fpath=($^fpath(N-/))

export path
export fpath
