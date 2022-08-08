#!/usr/bin/env bash

# Get script root folder
ROOT=$(dirname $(readlink -f $(which "$0")))

red() {
  printf "${FG_RED}${FS_REG}$@${RESET_ALL}"
}

tmuxSessions=$(tmux list-sessions 2> /dev/null)

if [ -z "$tmuxSessions" ]
then
  echo $(red "There aren't sessions started")
  exit 1
else
  session=$(echo "$tmuxSessions" | awk '{print $1}' | tr -d ':' |\
  fzf-tmux -p 80%,60% \
    --header 'Press CTRL-X to delete a session.' \
    --bind 'ctrl-x:execute-silent(tmux kill-session -t {+})+reload(tmux list-sessions | awk '"'"'{print $1}'"'"' | tr -d ':')')

  if ! tmux attach -t "=$session" 2> /dev/null; then
    tmux switch-client -t "=$session" 2> /dev/null
  fi
fi
