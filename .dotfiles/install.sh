#!/usr/bin/env bash

set -e

# Intsall link of home files
rm -rf ~/scripts ~/zsh ~/.tmux.conf ~/.zprofile ~/.zshrc ~/.DS_Store ~/Notes
stow -t ~ home

# Install config files
rm -rf ~/.config
mkdir ~/.config && stow -t ~/.config .config

