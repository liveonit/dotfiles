# [C-r, C-xf, C-xj] - fzf widgets
bindkey -v
bindkey -M viins '^r' fzf-history-widget # (r)everse history search
bindkey -M viins '^x^f' fzf-file-widget  # (f)ile
bindkey -M viins '^x^j' fzf-cd-widget    # (j)ump

# [C-x] - Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x' edit-command-line

# [C-space] - Accept current suggestion
bindkey '^ ' autosuggest-accept

# [C-j] - Search history backwards
bindkey '\C-k' history-search-backward
# [C-k] - Search history forwards.
bindkey '\C-j' history-search-forward

# [C-b] - Move backwards one word.
bindkey '\C-b' backward-word
# [C-w] - Move forwards one word.
bindkey '\C-w' forward-word

# =============
# Key-bindings
# =============
bindkey -s '^p' ' tls^M'
bindkey -s '^n' ' tns^M'
bindkey -s '^w' ' tnw^M'
bindkey -s '^e' ' hexec.sh^M'
bindkey -s '^h' ' history.sh^M'
