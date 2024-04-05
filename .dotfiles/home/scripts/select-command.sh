#!/usr/bin/env bash


FILE_DIR=$(dirname $(readlink -f $(which "$0")))
source $FILE_DIR/check-requirements.sh

! checkRequirements "fzf";

fomand_to_run=$(ls $FILE_DIR | fzf)

eval "$fomand_to_run"
