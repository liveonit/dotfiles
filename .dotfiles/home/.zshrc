#install plugins
source "$HOME/zsh/antigen_install.zsh"
source "$HOME/zsh/antigen.sh"

# Add custom script stowed to ~/bin and ~/vntana_bin to path
export PATH="$HOME/scripts:$PATH"
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"

# Configure the folder where all zsh configuration will live.
export ZDOTDIR=$HOME

# Useful zsh options. See man zshoptions
setopt autocd extendedglob nomatch menucomplete
setopt interactive_comments
# Automatically list choices on ambiguous completion.
setopt auto_list
# Automatically use menu completion.
setopt auto_menu
# Move cursor to end if word has one match.
setopt always_to_end

# Remove beep
unsetopt BEEP

# Change bindkey timeout to 1s
export KEYTIMEOUT=100

# Completitions
autoload -Uz compinit
zstyle ':completion:*' menu select
zmodload zsh/complist

# Compinit. Include hidden files.
_comp_options+=(globdots)

autoload -U up-line-or-beggining-search
autoload -U down-line-or-beggining-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
zle -N backward-delete-charbindkey
zle -N menuselect
zle -N up-lne-or-history

# Colors
autoload -Uz colors && colors

# Autosuggest Highlighting
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=7,bg=bold,underline"

export KEYTIMEOUT=100
export RIPGREP_CONFIG_PATH=$HOME/.ripgreprc
export GIT_EDITOR=nvim
export EDITOR=nvim

# fzf-tab recommended configuration.
# Disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# Set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# Set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# Preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# Switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

# Add custom script stowed to ~/bin and ~/vntana_bin to path
export PATH="$HOME/scripts:$PATH"

# FD
FD_OPTIONS="--follow --exclude .git --exclude node_modules"
export FZF_DEFAULT_OPTS='--no-height'

# nvm (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Ruby
export PATH="/usr/local/opt/ruby/bin:$PATH"

# Bat
export BAT_PAGER="less -R"

# Add scripts to path
export PATH="~/.dotfiles/scripts:$PATH"

# Configure aws autocomplete
export PATH=/Users/ignaciobarreto/.pyenv/shims/aws_completer:$PATH
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C '/Users/ignaciobarreto/.pyenv/shims/aws_completer' aws

# Normal files to source
source "$HOME/zsh/exports.zsh"
source "$HOME/zsh/aliases.zsh"
source "$HOME/zsh/prompt.zsh"
source "$HOME/zsh/history.zsh"
source "$HOME/zsh/mappings.zsh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ignaciobarreto/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/ignaciobarreto/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ignaciobarreto/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/ignaciobarreto/google-cloud-sdk/completion.zsh.inc'; fi
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

export PATH="/opt/homebrew/opt/curl/bin:$PATH"

source <(kubectl completion zsh)
alias k=kubectl
complete -o default -F __start_kubectl k
alias kubeclr='sed -i "" -e "s/^current-context:.*$/current-context:/" ~/.kube/config'
export PATH=/Users/ignaciobarreto/.meteor:$PATH
