# *** *** Plugins *** ***

# Load Antigen plugin manager
source ~/.antigen/antigen.zsh

# Load the oh-my-zsh library
antigen use oh-my-zsh >/dev/null 2>&1

# Bundles from the default repo
antigen bundle brew >/dev/null 2>&1
antigen bundle docker >/dev/null 2>&1
antigen bundle docker-compose >/dev/null 2>&1
antigen bundle dotenv >/dev/null 2>&1
antigen bundle fzf >/dev/null 2>&1
antigen bundle git >/dev/null 2>&1
antigen bundle jira >/dev/null 2>&1
antigen bundle man >/dev/null 2>&1
antigen bundle node >/dev/null 2>&1
antigen bundle z >/dev/null 2>&1
antigen bundle jq >/dev/null 2>&1
antigen bundle gcloud >/dev/null 2>&1
antigen bundle yarn-autocompletions >/dev/null 2>&1
antigen bundle lukechilds/zsh-nvm >/dev/null 2>&1
antigen bundle Aloxaf/fzf-tab >/dev/null 2>&1
antigen bundle zsh-users/zsh-autosuggestions >/dev/null 2>&1
antigen bundle zsh-users/zsh-completions >/dev/null 2>&1
antigen bundle zdharma-continuum/fast-syntax-highlighting >/dev/null 2>&1
antigen bundle hlissner/zsh-autopair >/dev/null 2>&1
antigen bundle buonomo/yarn-completion >/dev/null 2>&1
antigen bundle lukechilds/zsh-better-npm-completion >/dev/null 2>&1
antigen bundle mattberther/zsh-pyenv >/dev/null 2>&1

antigen apply >/dev/null 2>&1
