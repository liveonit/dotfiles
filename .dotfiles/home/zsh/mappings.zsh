# # [C-x] - Edit the current command line in $EDITOR
bindkey '^x' edit-command-line

# # [C-space] - Accept current suggestion
bindkey '^ ' autosuggest-accept

# # =============
# # Key-bindings
# # =============
bindkey -s '^p' ' tls^M'
bindkey -s '^n' ' tns^M'
bindkey -s '^w' ' tnw^M'
bindkey -s '^r' ' hexec.sh^M'
bindkey -s '^h' ' history.sh^M'
