#!/usr/bin/env bash

FILE_DIR=$(dirname $(readlink -f $(which "$0")))

source $FILE_DIR/print.sh
source $FILE_DIR/check-requirements.sh

! checkRequirements "git" "gh" "jq";


COMMIT_COUNT=$(gh pr view --json commits | jq '.commits | length')
PR_NAME=$(gh pr view --json title | jq '.title' | sed -e 's/^"//' -e 's/"$//')
if [ -z "$COMMIT_COUNT" ] || [ -z "$PR_NAME" ]; then
  error "Could not find PR commits or PR name";
  exit 1;
fi
blue "ℹ️ Found $COMMIT_COUNT commits in PR: "; yellow "$PR_NAME\n";
info "Squashing commits..."
git reset --soft HEAD~"$COMMIT_COUNT"
git add --all
info "Committing changes..."
git commit -m "$PR_NAME"
success "Done!"

