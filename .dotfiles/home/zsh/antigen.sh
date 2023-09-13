# *** *** Plugins *** ***

# Load the oh-my-zsh library
antigen use oh-my-zsh

# Bundles from the default repo
antigen bundle brew
antigen bundle dotenv
antigen bundle fzf
antigen bundle git
antigen bundle jira
antigen bundle man
antigen bundle node
antigen bundle z
antigen bundle jq
antigen bundle gcloud
antigen bundle yarn-autocompletions
antigen bundle lukechilds/zsh-nvm
antigen bundle Aloxaf/fzf-tab
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle zdharma-continuum/fast-syntax-highlighting
antigen bundle hlissner/zsh-autopair
antigen bundle chrisands/zsh-yarn-completions
antigen bundle lukechilds/zsh-better-npm-completion
antigen bundle mattberther/zsh-pyenv

antigen apply
