#!/usr/bin/env bash

CONFIG_SESSIONS=$(basename -s .yaml $DOTFILES/tmux/sessions/*.yaml 2>/dev/null | sort -r)
CHOICE=$(echo "$CONFIG_SESSIONS" | fzf --prompt="Pick a session: " --border --height=40%)

[ -z "$CHOICE" ] && exit 0

yes | tmuxp load "$DOTFILES/tmux/sessions/$CHOICE.yaml" > /dev/null 2>&1
