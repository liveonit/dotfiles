#!/usr/bin/env bash

FILE_DIR=$(dirname $(readlink -f $(which "$0")))

source $FILE_DIR/check-requirements.sh

! checkRequirements "fzf";

file=$({
  find ~/Downloads -type f  & \
  find ~/Documents -type f;
} | sort -u | fzf)

if [ -z "$file" ]; then exit 0; fi

open "$file"
