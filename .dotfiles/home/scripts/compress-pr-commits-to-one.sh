#!/usr/bin/env bash

ROOT=$(dirname $(readlink -f $(which "$0")))

source $ROOT/print.sh
source $ROOT/check-requirements.sh

! checkRequirements "git" "gh" "jq";


COMMIT_COUNT=$(gh pr view --json commits | jq '.commits | length')
PR_NAME=$(gh pr view --json title | jq '.title' | sed -e 's/^"//' -e 's/"$//')
if [ -z "$COMMIT_COUNT" ] || [ -z "$PR_NAME" ]; then
  echo `error "Could not find PR commits or PR name"`;
  exit 1;
fi
echo `info "Found $COMMIT_COUNT commits in PR: "` `yellow "$PR_NAME"`;
echo `info "Squashing commits..."`
git reset --soft HEAD~"$COMMIT_COUNT"
git add --all
echo `info "Committing changes..."`
git commit -m "$PR_NAME"
echo `success "Done!"`

