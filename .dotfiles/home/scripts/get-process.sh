#!/usr/bin/env bash

# Get suspended process and list them in fzf-tmux, to run the script in the
# right session we should execute the script as follow: . ./get-process.sh

FILE_DIR=$(dirname $(readlink -f $(which "$0")))

source $FILE_DIR/print.sh

source $FILE_DIR/check-requirements.sh

! checkRequirements "fzf" "gawk";

JOBS=$(jobs | gawk '{
if(match($0, /\[([0-9]+)\].*suspended  (.*)/, arr)) { printf "%s,%s\n", arr[1], arr[2] } }')

processes=()
while IFS=";" read line; do
  processes+=("$line")
done <<<$JOBS


if [ -n "$processes" ]; then
  command=$(printf "%s\n" "${processes[@]}" | fzf)

  process_number=$(echo "$command" | cut -d',' -f1)
  echo $(green "Getting process ") $(yellow "$process_number")

  eval "fg %$process_number"
else
  echo $(yellow "There are not suspended processes")
fi
