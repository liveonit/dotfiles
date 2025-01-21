#!/usr/bin/env bash

FILE_DIR=$(dirname $(readlink -f $(which "$0")))

source $FILE_DIR/print.sh
source $FILE_DIR/check-requirements.sh

! checkRequirements "gum"

# # ==== Clear node_modules folders ====

FOUND_NODE_MODULES=$(find . -name "node_modules" -type d -prune)

if [ -z "$FOUND_NODE_MODULES" ]; then
  info "No node_modules folders found!"
  exit 0
fi

gum style \
	--foreground 212 --border-foreground 57 --border double \
	--align left --padding "1 2" \
  'We are almost removing the next node_modules folders:' " " "$FOUND_NODE_MODULES"

DELETE_OPTION=$(gum choose "Delete all of them" "Delete a subset of them" "Cancel")

case $DELETE_OPTION in
  "Delete all of them")
    info "Deleting all of them"
    SELECTED_NODE_MODULES=$FOUND_NODE_MODULES
    ;;
  "Delete a subset of them")
    info "Deleting a subset of them"
    SELECTED_NODE_MODULES=`gum choose --no-limit $FOUND_NODE_MODULES`
    ;;
  "Cancel")
    info "Canceling"
    ;;
esac

if [ "$SELECTED_NODE_MODULES" != "" ]; then
  while IFS= read -r line; do
    gum spin --spinner "dot" --title "Removing node_modules folder: $line" -- rm -rf "$line"
    success "$line successfully removed!"
  done <<< "$SELECTED_NODE_MODULES"
fi


# ==== Clear node lock files ====

FOUND_NODE_LOCKS_FILES=`find . -type f \( -name "package-lock.json" -o -name "yarn.lock" \) ! -path '*/node_modules/*'`

if [ -z "$FOUND_NODE_LOCKS_FILES" ]; then
  info "No package-lock.json and/or yarn.lock files found!"
  exit 0
fi

gum style \
	--foreground 212 --border-foreground 57 --border double \
	--align left --padding "1 2" \
  'We are almost removing the next node_modules folders:' " " "$FOUND_NODE_LOCKS_FILES"

DELETE_OPTION=$(gum choose "Delete all of them" "Delete a subset of them" "Cancel")

case $DELETE_OPTION in
  "Delete all of them")
    info "Deleting all of them"
    SELECTED_LOCKS_FILES=$FOUND_NODE_LOCKS_FILES
    ;;
  "Delete a subset of them")
    info "Deleting a subset of them"
    SELECTED_LOCKS_FILES=`gum choose --no-limit $FOUND_NODE_LOCKS_FILES`
    ;;
  "Cancel")
    info "Canceling"
    ;;
esac

if [ "$SELECTED_LOCKS_FILES" != "" ]; then
  while IFS= read -r line; do
    gum spin --spinner "dot" --title "Removing node_modules folder: $line" -- rm -rf "$line"
    success "$line successfully removed!"
  done <<< "$SELECTED_LOCKS_FILES"
fi
