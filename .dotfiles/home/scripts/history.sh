#!/usr/bin/env bash

FILE_DIR=$(dirname $(readlink -f $(which "$0")))

source $FILE_DIR/print.sh

source $FILE_DIR/check-requirements.sh

! checkRequirements "fzf";

[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"

fileLines=()
while IFS=";" read -u3 var val; do
      fileLines=("$val" "${fileLines[@]}")
done 3<$HISTFILE

command=$(printf "%s\n" "${fileLines[@]}" | fzf)

echo "$command"
