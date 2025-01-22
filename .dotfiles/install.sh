#!/usr/bin/env bash

set -e

# Intsall link of home files
rm -rf ~/scripts ~/zsh ~/.tmux ~/.tmux.conf ~/.zprofile ~/.zshrc ~/.DS_Store ~/Notes ~/liveonit.secrets.gpg
stow -t ~ home

# Install config files
rm -rf ~/.config
mkdir ~/.config && stow -t ~/.config .config

