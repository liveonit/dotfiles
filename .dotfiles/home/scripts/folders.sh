#!/usr/bin/env bash

# This file scours through my most important working folders and pipes
# them through `fzf`. The returning value can be used as input for other
# scripts. For example, to generate new tmux windows or sessions.
{
  find ~ -mindepth 1 -maxdepth 1 -type d & \
  find ~/Documents -mindepth 1 -maxdepth 1 -type d & \
  find ~/Documents/projects -mindepth 1 -maxdepth 4 -type d ! -path '*/.git' ! -path '*/.git/*' ! -path '*/.node_modules' ! -path '*/.node_modules/*' | grep -E ".*/projects/*" & \
} | sort -u | fzf-tmux -p 90%,90%
