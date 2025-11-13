path=(
  ${ASDF_DATA_DIR:-$HOME/.asdf}/shims
  $path
  /opt/android-sdk/emulator
  $HOME/.local/bin
  $HOME/.yarn/bin
)

fpath=(
  $fpath
  /usr/share/zsh/functions/Zle
  /usr/share/zsh/site-functions
)

typeset -U path fpath

# Clears paths of invalid entries
path=($^path(N-/))
fpath=($^fpath(N-/))

# The default java path is messing with asdf java
path=(${path:#/usr/lib/jvm/default/bin})

export path
export fpath
