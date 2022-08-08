#/usr/bin/env bash

ROOT=$(dirname $(readlink -f $(which "$0")))

source $ROOT/print.sh

[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"

fileLines=()
while IFS=";" read -u3 var val; do
      fileLines+=("$val")
done 3<$HISTFILE

command=$(printf "%s\n" "${fileLines[@]}" | fzf-tmux -p 95%,60% --reverse)

echo "$command"
