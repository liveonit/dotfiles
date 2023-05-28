#!/usr/bin/env bash

# Custom aliases.
alias zconfig="vim ~/.zshrc"
alias zsource="source ~/.zshrc"
alias keys="~/Documents/keys"

# Configure tldr to fork in osx.
alias tldr="tldr -p=osx"

# Colorize grep output
alias grep='grep --color=auto'

# Configmr before overwriting something
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'

# Kitty alias
alias kitty="/Applications/kitty.app/Contents/MacOS/kitty"

# }}}
# {{{ *** *** Aliases *** ***

# ZSH
alias ls="lsd"
alias ll="ls -alh --color=auto"
alias zshconfig="vim $HOME/.zshrc"
alias reload="source $HOME/.zshrc"

# Folders
alias ..='cd ..'
alias la='ls -la'
alias mkdir='mkdir -p'

# Git
alias ga='git add'
alias gb='git branch'
alias gba='git branch -a'
alias gc='git commit -v'
alias gca='git commit -v -a'
alias gcaa='git add --all && git commit -v'
alias gd='git diff -- . ":(exclude)yarn.lock"' # Show differences between index and working tree
alias gdc='git diff --cached'                  # Show changes in next commit (differences between index and last commit)
alias gdh='git diff head'                      # Show difference between files in working tree and last commit
alias gdt='git difftool'
alias gfa='git fetch --all'
alias gg='git log'
alias ghi='git hist'
alias gho='$(git remote -v | grep github | sed -e "s/.*git\:\/\/\([a-z]\.\)*/\1/" -e "s/\.git$//g" -e "s/.*@\(.*\)$/\1/g" | tr ":" "/" | tr -d "\011" | sed -e "s/^/open http:\/\//g")'
alias gl='git pull'
alias glr='git pull --rebase'
alias gliveonit='git config user.name "liveonit" && git config user.email "ibarretorey@gmail.com";'
alias gmb='git merge-base master HEAD'
alias gp='git push'
alias gpf='git push --force-with-lease'
alias gpp='PATCHNAME=`git branch 2> /dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/\1/"`-`date "+%Y-%m-%d-%H%M.patch"`; git diff --full-index master > ../patches/$PATCHNAME'
alias gpu='git push -u origin HEAD'
alias gpv='git push --no-verify'
alias grb='git rebase'
alias grbc='git rebase --continue'
alias grbi='git rebase -i '
alias grbs='git rebase --skip'
alias grm="git status | grep deleted | awk '{print \$3}' | xargs git rm"
alias gru='git remote update'
alias gsb='git show-branch'
alias gsl='git submodule foreach git pull'
alias gsquashall='merge_base_commit=$(git merge-base `git symbolic-ref -q HEAD` master); git rebase -i $merge_base_commit'
alias gst='git status -sb'
alias gsu='git submodule update'
alias gu='git up'
alias gw='git whatchanged'
alias gwp='git whatchanged -p'
alias lg='lazygit'

# Vim
if type nvim >/dev/null 2>&1; then
  alias vim='nvim'
  alias v="vim ."
fi

# Tmux
alias tns=tmux-new-session.sh
alias tls=tmux-list-sessions.sh
alias tnw=tmux-new-window.sh

# Tmuxinator
alias mux="tmuxinator"

# Recursively delete `.DS_Store` files
alias dsclr="find . -type f -name '*.DS_Store' -ls -delete"

# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# Development VMs
alias ubudev="ssh liveofit@triactivesoft.com -p 2712"

# files
alias pcat="bat"
