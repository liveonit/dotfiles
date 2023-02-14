#!/usr/bin/env bash

ROOT=$(dirname $(readlink -f $(which "$0")))

source $ROOT/print.sh

JOBS=$(jobs | gawk '{
if(match($0, /\[([0-9]+)\].*suspended  (.*)/, arr)) { printf "%s,%s\n", arr[1], arr[2] } }')

processes=()
while IFS=";" read line; do
  processes+=("$line")
done <<<$JOBS


if [ -n "$processes" ]; then
  command=$(printf "%s\n" "${processes[@]}" | fzf-tmux -p 90%,60%)

  process_number=$(echo "$command" | cut -d',' -f1)
  echo $(green "Getting process ") $(yellow "$process_number")

  eval "fg %$process_number"
else
  echo $(yellow "There are not suspended processes")
fi
