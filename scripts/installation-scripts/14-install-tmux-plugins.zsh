#!/usr/bin/env zsh

set -euo pipefail

install_tpm() {
  local tpm_dir="$HOME/.tmux/plugins/tpm"
  if [[ ! -d "$tpm_dir" ]]; then
    git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
    
    local started_server=false
    if ! tmux has-session 2>/dev/null; then
      tmux start-server
      started_server=true
    fi
    
    tmux new-session -d -s install-tpm-plugins '$SHELL' 2>/dev/null || true
    "$tpm_dir/bin/install_plugins"
    tmux kill-session -t install-tpm-plugins 2>/dev/null || true
    
    if $started_server; then
      tmux kill-server 2>/dev/null || true
    fi
  fi
}

install_tpm
