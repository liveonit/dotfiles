# # [C-x] - Edit the current command line in $EDITOR
bindkey '^x' edit-command-line

# # [C-space] - Accept current suggestion
bindkey '^ ' autosuggest-accept

# # =============
# # Key-bindings
# # =============
bindkey -s '^p' 'tls^M'
bindkey -s '^n' 'tns^M'
bindkey -s '^e' '. hexec.sh^M'
bindkey -s '^h' '. history.sh^M'
bindkey -s '^g' '. get-process.sh^M'
bindkey -s '^k' '. select-command.sh^M'
