#!/usr/bin/env bash

ROOT=$(dirname $(readlink -f $(which "$0")))

source $ROOT/print.sh

source $ROOT/check-requirements.sh

! checkRequirements "fzf";

[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"

fileLines=()
while IFS=";" read -u3 var val; do
      fileLines=("$val" "${fileLines[@]}")
done 3<$HISTFILE

command=$(printf "%s\n" "${fileLines[@]}" | fzf)

echo "$command"
