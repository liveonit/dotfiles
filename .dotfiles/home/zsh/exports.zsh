#!/usr/bin/env bash

ROOT=$(dirname $(readlink -f $(which "$0")))

if [ -f "$ROOT/secrets.zsh" ]; then
  source "$ROOT/secrets.zsh"
fi

# Configure default ansible config file
export ANSIBLE_CONFIG=~/.ansible.cfg

# Color man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Use nvim to read Man pages
export MANPAGER='nvim +Man!'
export MANWIDTH=999

# Add cargo binary directory to the path.
export PATH=$PATH:${HOME}/.cargo/bin

# Add a user binary directory to the path.
export PATH=$PATH:${HOME}/.local/bin

# Fix perl locale issue
export LC_CTYPE=UTF-8
export LANG=en_US.UTF-8

# Fix OpenSSL link issue
export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f "${HOME}/.local/google-cloud-sdk/path.zsh.inc" ]; then . "${HOME}/.local/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "${HOME}/.local/google-cloud-sdk/completion.zsh.inc" ]; then . "${HOME}/.local/google-cloud-sdk/completion.zsh.inc"; fi

# Add gcloud to the global path
export PATH=$PATH:"${HOME}/.local/google-cloud-sdk/bin"
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# Add n to the global path and configure N_PREFIX
export PATH=$PATH:"${HOME}/.local/n/bin"
export N_PREFIX="${HOME}/.local/n/versions"

# Configure Perl path
PATH="${HOME}/perl5/bin${PATH:+:${PATH}}"
export PATH
PERL5LIB="${HOME}/perl5/lib/perl5${PERL5LI:+:${PERL5LIB}}"
export PERL5LIB
PERL_LOCAL_LIB_ROOT="${HOME}/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
export PERL_LOCAL_LIB_ROOT
PERL_MB_OPT="--install_base \"${HOME}/perl5\""
export PERL_MB_OPT
PERL_MM_OPT="INSTALL_BASE=${HOME}/perl5"
export PERL_MM_OPT

# Configure `fd` to work nicely with `fzf`.
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git --exclude node_modules'
export FZF_DEFAULT_OPTS="--color=bg+:#292e42,spinner:#bb9af7,hl:#565f89,fg:#c0caf5,header:#565f89,info:#7dcfff,pointer:#bb9af7,marker:#7dcfff,fg+:#c0caf5,prompt:#bb9af7,hl+:#bb9af7"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Configure colors using `vivid`
export LS_COLORS="$(vivid generate tokyonight)"

# Configure nvim as the default editor
export EDITOR=nvim

# Add Go binary folder to the PATH
export PATH=$PATH:"$HOME/go/bin"
export GO111MODULE='on'

# Enable nvm autocompletions
export NVM_COMPLETION=true

## Colours and font styles
## Syntax: echo -e "${FOREGROUND_COLOUR}${BACKGROUND_COLOUR}${STYLE}Hello world!${RESET_ALL}"

# Escape sequence and resets
export ESC_SEQ="\x1b["
export RESET_ALL="${ESC_SEQ}0m"
export RESET_BOLD="${ESC_SEQ}21m"
export RESET_UL="${ESC_SEQ}24m"

# Foreground colours
export FG_BLACK="${ESC_SEQ}30;"
export FG_RED="${ESC_SEQ}31;"
export FG_GREEN="${ESC_SEQ}32;"
export FG_YELLOW="${ESC_SEQ}33;"
export FG_BLUE="${ESC_SEQ}34;"
export FG_MAGENTA="${ESC_SEQ}35;"
export FG_CYAN="${ESC_SEQ}36;"
export FG_WHITE="${ESC_SEQ}37;"
export FG_BR_BLACK="${ESC_SEQ}90;"
export FG_BR_RED="${ESC_SEQ}91;"
export FG_BR_GREEN="${ESC_SEQ}92;"
export FG_BR_YELLOW="${ESC_SEQ}93;"
export FG_BR_BLUE="${ESC_SEQ}94;"
export FG_BR_MAGENTA="${ESC_SEQ}95;"
export FG_BR_CYAN="${ESC_SEQ}96;"
export FG_BR_WHITE="${ESC_SEQ}97;"

# Background colours (optional)
export BG_BLACK="40;"
export BG_RED="41;"
export BG_GREEN="42;"
export BG_YELLOW="43;"
export BG_BLUE="44;"
export BG_MAGENTA="45;"
export BG_CYAN="46;"
export BG_WHITE="47;"

# Font styles
export FS_REG="21;24m"
export FS_BOLD="1m"
export FS_UL="4m"

# Configure TMUX by default

export ZSH_TMUX_AUTOSTART=true
export ZSH_TMUX_CONFIG=$HOME/.tmux.conf

# Configure ZK notes directory
export ZK_NOTEBOOK_DIR=~/dotfiles/.dotfiles/home/Notes

# Set default JAVA runtime version
export JAVA_HOME=/opt/homebrew/Cellar/openjdk@11/11.0.18/libexec/openjdk.jdk/Contents/Home

# Configure aws autocomplete
export PATH=/Users/ignaciobarreto/.pyenv/shims/aws_completer:$PATH
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C '/Users/ignaciobarreto/.pyenv/shims/aws_completer' aws


