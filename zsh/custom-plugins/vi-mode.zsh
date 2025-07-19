bindkey -v

function zsh_cursor_block()  { echo -ne '\e[2 q' }
function zsh_cursor_beam()   { echo -ne '\e[6 q' }

function zle-keymap-select {
  case $KEYMAP in
    vicmd)      zsh_cursor_block ;;
    viins)      zsh_cursor_beam  ;;
    main)       zsh_cursor_beam  ;;
    *)          zsh_cursor_beam  ;;
  esac
}
zle -N zle-keymap-select

function zle-line-init {
  zsh_cursor_beam
}
zle -N zle-line-init

function zsh_cursor_reset {
  echo -ne '\e[2 q'
}
autoload -Uz add-zsh-hook
add-zsh-hook zshexit zsh_cursor_reset
