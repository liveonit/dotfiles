#!/usr/bin/env bash

if [ -z "$1" ]; then
  # Get new session
  folder_name=$(folders.sh)
  safe_folder_name=$(printf "%s" "$folder_name" | tr '.' '_')
  if [ -z "$safe_folder_name" ]; then
    exit 0
  fi;
  # Create new session if it doesn't exist
  if ! tmux has-session -t "=$safe_folder_name" 2>/dev/null; then
    tmux new-session -s "$safe_folder_name" -c "$folder_name" -d
  fi

  # Connect to existing session
  if ! tmux attach -t "=$safe_folder_name" 2>/dev/null; then
                tmux switch-client -t "=$safe_folder_name"
  fi
else
  # Create new session if it doesn't exist
  if ! tmux has-session -t "=$1" 2>/dev/null; then
    tmux new-session -s "$1" -d
  fi

  # Connect to existing session
  if ! tmux attach -t "=$1" 2>/dev/null; then
    tmux switch-client -t "=$1"
  fi
fi
