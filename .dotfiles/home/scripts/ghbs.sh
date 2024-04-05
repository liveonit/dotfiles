#!/usr/bin/env bash

FILE_DIR=$(dirname $(readlink -f $(which "$0")))
source $FILE_DIR/check-requirements.sh
source $FILE_DIR/utils.sh
! checkRequirements "fzf" "git";


git_branch=$(git branch | fzf)

git checkout $(trim "$git_branch")

