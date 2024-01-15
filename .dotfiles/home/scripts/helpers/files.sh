#!/usr/bin/env bash

file=$({
  find ~/Downloads -type f  & \
  find ~/Documents -type f;
} | sort -u | fzf)

if [ -z "$file" ]; then exit 0; fi

open "$file"
