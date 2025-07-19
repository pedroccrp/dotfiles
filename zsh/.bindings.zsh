bindkey -v

# Used to remove the delay when pressing escape
# but can break other keybindings, make sure to check
KEYTIMEOUT=5

# Emacs-style bindings in vi insert mode
bindkey -M viins '^A' beginning-of-line
bindkey -M viins '^E' end-of-line
bindkey -M viins '^K' kill-line
bindkey -M viins '^U' backward-kill-line
bindkey -M viins '^W' backward-kill-word
bindkey -M viins '^Y' yank
bindkey -M viins '^H' backward-delete-char
bindkey -M viins '^?' backward-delete-char
bindkey -M viins '^[[3~' delete-char
bindkey -M viins '^[[1;5C' forward-word
bindkey -M viins '^[[1;5D' backward-word

# History search
autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey -M viins '^[[A' up-line-or-beginning-search
bindkey -M viins '^[[B' down-line-or-beginning-search
bindkey -M viins '' up-line-or-beginning-search
bindkey -M viins '' down-line-or-beginning-search
bindkey -M viins '^[k' up-line-or-beginning-search
bindkey -M viins '^[j' down-line-or-beginning-search

bindkey -M viins '^R' fzf-history-widget

# Autosuggest
bindkey -M viins '^@' autosuggest-accept
bindkey -M viins '' autosuggest-accept
bindkey -M viins '' undefined-key
bindkey -M viins '' forward-word
