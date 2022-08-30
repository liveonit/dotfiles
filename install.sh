#!/bin/sh

SOURCE_DIR=$(dirname $(readlink -f $(which "$0")))

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Upgrade all apt packages
    sudo apt update && sudo apt upgrade

    # Install ansible and add community.general module
    sudo apt install ansible
elif [[ "$OSTYPE" == "darwin"* ]]; then
    # === Install Xcode Developer Tools ===
    xcode-select --install

    # === Install TMUX Plugin Manager ===
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

    # === Install brew ===
    if ! command -v brew &>/dev/null; then
        echo "=== Installing brew ==="
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >>$HOME/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
        source $HOME/.zprofile
    fi
    if ! command -v brew &>/dev/null; then
        echo "brew could not be found"
        exit 1
    else
        echo "brew successfully installed"
    fi

    python3 -m pip install --upgrade pip
    python3 -m pip install --user setuptools
    python3 -m pip install --user ansible
    export PATH="/path/to/Library/Python/3.8/bin:$PATH"

    # === Install cargo ===
    # === Install brew ===
    if ! command -v brew &>/dev/null; then
        curl https://sh.rustup.rs -sSf | sh
    fi
    if ! command -v cargo &>/dev/null; then
        echo "brew could not be found"
        exit 1
    else
        echo "cargo successfully installed"
    fi

else
    echo "Unsuported operating system, the OS should be Ubuntu or MacOs."
    exit 1
fi
ansible-galaxy collection install community.general
# Run ansible playbook
ansible-playbook -vvv ansible/setup.yml --ask-become-pass
