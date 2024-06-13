#!/bin/bash

SOURCE_DIR=$(dirname $(readlink -f $(which "$0")))

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Upgrade all apt packages
  sudo apt update && sudo apt upgrade

  # Install linux brew
  if ! command -v brew &> /dev/null; then
    echo "Installing Linux/brew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.zprofile
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  fi

  # Install ansible and add community.general module
  sudo apt install ansible
  ansible-galaxy collection install community.general
  ansible-playbook -vvv ansible/setup_ubuntu.yml --ask-become-pass
  cp .dotfiles/home/iterm/iterm_background.jpeg /usr/share/iterm_background.jpeg
#   cp .dotfiles/home/iterm/macosItermProfiles.json ~/Library/Application\ Support/iTerm2/DynamicProfiles/macosItermProfiles.json
elif [[ "$OSTYPE" == "darwin"* ]]; then
  # === Install Xcode Developer Tools ===
    if xcode-select --version; then
        echo "xcode-select is already installed"
    else
        xcode-select --install
    fi

  # === Install TMUX Plugin Manager ===
  if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "=== Installing tmux-plugins ==="
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  fi

  # === Install brew ===
  if [ ! -f "/opt/homebrew/bin/brew" ]; then
    echo "=== Installing brew ==="
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>$HOME/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
  if [ ! -f "$HOME/.zprofile" ]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>$HOME/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
  source $HOME/.zprofile
  if ! command -v brew &>/dev/null; then
    echo "brew could not be found"
    exit 1
  else
    echo "brew successfully installed"
  fi

  python3 -m pip install --break-system-packages --upgrade pip
  python3 -m pip install --break-system-packages --user setuptools
  python3 -m pip install --break-system-packages --user ansible
  PY_VERSION=$(python3 --version | sed 's/[[:alpha:]|(|[:space:]]//g' | sed 's/^\([0-9]*\.[0-9]*\).*$/\1/')
  export PATH="~/Library/Python/$PY_VERSION/bin:$PATH"

  # === Install cargo ===
  if [ ! -f "$HOME/.cargo/env" ]; then
    echo "=== Installing cargo ==="
    curl https://sh.rustup.rs -sSf | sh
  fi
  source ~/.zshenv
  if ! command -v cargo &>/dev/null; then
    echo "cargo could not be found"
    exit 1
  else
    echo "cargo successfully installed"
  fi
  ansible-galaxy collection install community.general
  ansible-playbook -vvv ansible/setup_mac.yml --ask-become-pass

  cp .dotfiles/home/iterm/iterm_background.jpeg /Users/Shared/iterm_background.jpeg
  cp .dotfiles/home/iterm/macosItermProfiles.json ~/Library/Application\ Support/iTerm2/DynamicProfiles/macosItermProfiles.json
else
  echo "Unsuported operating system, the OS should be Ubuntu or MacOs."
  exit 1
fi
