#!/usr/bin/env bash

FILE_DIR=$(dirname $(readlink -f $(which "$0")))

source $FILE_DIR/print.sh
source $FILE_DIR/check-requirements.sh
source $FILE_DIR/utils.sh

! checkRequirements "fzf" "git" "gum"

# GIT_BRANCHES=$(git branch)

# if [ -z "$GIT_BRANCHES" ]; then
#   echo `error "Not in a git repository!"`
#   exit 1
# fi

# if [ -n "$(git status -s)" ]; then
#   gum style \
# 	  --foreground 212 --border-foreground 57 --border double \
# 	  --align left --padding "1 2" \
#     'There are changes not committed. Do you want to:'
#   CHANGES_OPTION=$(gum choose "Discard all of them" "Preserve in source project" "Preserve in target project")
#   case $CHANGES_OPTION in
#     "Discard all of them")
#       echo `info "Reverting all uncommitted changes"`
#       git reset --hard
#       git clean -f -d
#     ;;
#     "Preserve in source project")
#       echo `info "Staging all changes"`
#       git add --all
#       git stash
#     ;;
#     "Preserve in target project")
#       echo `info "Staging all changes"`
#       git add --all
#       git stash
#     ;;
#   esac
# fi

# gum style \
# 	--foreground 212 --border-foreground 57 --border double \
# 	--align left --padding "1 2" \
#   'The default name for the worktress folder is ".worktrees" so the path will be "<project_dir>/.worktrees/". Do you want to:'

# DIRECTORY_DECISION=$(gum choose "Use the default directory" "Set a custom worktrees directory name")


# case $DIRECTORY_DECISION in
#   "Use the default directory")
#     WORKTREE_DIR=".worktrees"
#     ;;
#   "Set a custom worktrees directory")
#     WORKTREE_DIR=$(gum input --placeholder "Worktrees directory name")
#   ;;
# esac


# GIT_ROOT_DIR=$(git rev-parse --show-toplevel)
# BRANCH_DECISION_FOR_NEW_TREE=$(gum choose "Use current branch" "Select a local branch" "Create a new branch" "Fetch remote branch")
# case $BRANCH_DECISION_FOR_NEW_TREE in
#   "Use current branch")
#     GIT_BRANCH=$(git rev-parse --abbrev-ref HEAD)

#     ;;
#   "Select a local branch")
#     GIT_BRANCH=$(git branch |  gum filter --placeholder "Select branch")
#     git worktree add "$GIT_BRANCH" "$GIT_ROOT_DIR/$WORKTREE_DIR"
#     ;;
#   "Create a new branch")
#     GIT_BRANCH=$(gum input --placeholder "Branch name")
#     git worktree add -b "$GIT_BRANCH" "$GIT_ROOT_DIR/$WORKTREE_DIR"
#     ;;
#   "Fetch remote branch")
#     GIT_BRANCH=$(gum input --placeholder "Branch name")
#     git fetch origin "$GIT_BRANCH"
#     git worktree add "$GIT_BRANCH" "$GIT_ROOT_DIR/$WORKTREE_DIR"
#     ;;
# esac

if gum confirm "Do you want to copy untracked git files?"; then
  IGNORED_GIT_FILES=()
  while read -d '' -r filename; do
    if [[ ! $filename == @(*node_modules*|*coverage*|*.next*|*build*|*dist*|*__pycache__*|*.pytest_cache*|*site-packages*|*tmp*|*.venv*|*.npm*) ]]; then
      IGNORED_GIT_FILES+=("$filename")
    fi
  done < <(git ls-files . --ignored --exclude-standard --others -z)

  echo `info "Select the files you want to copy (default: copy all)"`

  SELECTED_FILES_TO_COPY=$(gum choose --selected-prefix="✅ " --unselected-prefix="❌ " --no-limit "${IGNORED_GIT_FILES[@]}" --selected="$(join_by , ${IGNORED_GIT_FILES[@]})")

fi


