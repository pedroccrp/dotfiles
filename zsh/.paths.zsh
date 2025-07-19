path=(
  $path
  ${ASDF_DATA_DIR:-$HOME/.asdf}/shims
)

fpath=(
  $fpath
)

typeset -U path fpath

# Clears paths of invalid entries
path=($^path(N-/))
fpath=($^fpath(N-/))

export path
export fpath
