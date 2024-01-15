#!/usr/bin/env bash

ROOT=$(dirname $(readlink -f $(which "$0")))

source $ROOT/print.sh

# Script to check if a list of requirements are installed
# Usage: check-requirements.sh <requirement1> <requirement2> ...
# Example: check-requirements.sh git curl
# Example to use as conditional:
# ```sh
# source <PATH_TO_SCRIPT_DIRECTORY>/check-requirements.sh
# ! checkRequirements "node";
# ```
checkRequirements() {
  for var in "$@"
  do
    if ! $ROOT/has -q "$var"; then
      echo `error "$var is required and not installed"`;
      exit 1;
    fi
  done
}


[ "$(basename "$0")" = "$(basename "$BASH_SOURCE")" ] && checkRequirements "$@"

