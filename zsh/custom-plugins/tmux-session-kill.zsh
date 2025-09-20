tmux_ctrl_d() {
  if [ "$IS_TMUX_POPUP" = "1" ]; then
    exit
  fi

  session_count=$(tmux list-sessions 2>/dev/null | wc -l)
  current_session=$(tmux display-message -p '#S')

  pane_count=$(tmux list-panes -t "$current_session" 2>/dev/null | wc -l)
  window_count=$(tmux list-windows 2>/dev/null | wc -l)

  if [ "$pane_count" -eq 1 ] && [ "$window_count" -eq 1 ] && [ "$session_count" -gt 1 ]; then
    target_session=$(tmux list-sessions | grep -v "$current_session" | head -n1 | cut -d: -f1)
    tmux switch-client -t "$target_session"
    tmux kill-session -t "$current_session"
    return
  fi

  exit
}

tmux_ctrl_d_widget() {
  tmux_ctrl_d
}

stty eof ''

zle -N tmux_ctrl_d_widget

bindkey '^D' tmux_ctrl_d_widget
bindkey -M vicmd '^D' tmux_ctrl_d_widget
bindkey -M viins '^D' tmux_ctrl_d_widget
