eval "$(/opt/homebrew/bin/brew shellenv)"

# Enable python-virtualenv
if which pyenv-virtualenv-init >/dev/null; then eval "$(pyenv virtualenv-init -)"; fi

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
