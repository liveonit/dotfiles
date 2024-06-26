FROM ubuntu:24.04
WORKDIR /usr/local/bin
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y software-properties-common curl git build-essential sudo
RUN apt-get install -y ansible
RUN ansible-galaxy collection install community.general

RUN apt-get install file git ruby-full locales --no-install-recommends -y && \
    rm -rf /var/lib/apt/lists/*

RUN localedef -i en_US -f UTF-8 en_US.UTF-8

RUN useradd -m -s /bin/bash admin && \
    echo 'admin ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers

USER admin

RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
ENV PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"

RUN brew install java bat coreutils curl  direnv editorconfig  gcc  glow
RUN brew install go automake grex  lua  luarocks stylua neovim python readline rsync ssh-copy-id tmux
RUN brew install tmuxinator urlview  watchman yarn z zsh zsh-syntax-highlighting stow
RUN brew install rich mongocli yamllint terraform ranger pwgen oh-my-posh hashicorp/tap/terraform-ls
RUN brew install efm-langserver lua-language-server helm jo lsd bat fzf jq shellcheck
RUN brew install tldr tree-sitter mysql-client kubectl openssh rust ripgrep fd vivid zk
RUN brew install k9s lazygit gum bash-language-server shfmt shellcheck gnu-sed

WORKDIR /home/admin
COPY ./ansible ./dotfiles/ansible

WORKDIR /home/admin/dotfiles

RUN ansible-playbook -vvv ansible/setup_ubuntu.yml --user=admin --tags "apt"
RUN ansible-playbook -vvv ansible/setup_ubuntu.yml --user=admin --tags "custom"
RUN ansible-playbook -vvv ansible/setup_ubuntu.yml --user=admin --tags "node"
RUN ansible-playbook -vvv ansible/setup_ubuntu.yml --user=admin --tags "python"

COPY . ./
RUN ansible-playbook -vvv ansible/setup_ubuntu.yml --user=admin --tags "zsh"
RUN ansible-playbook -vvv ansible/setup_ubuntu.yml --user=admin --tags "dotfiles"

WORKDIR /home/admin

RUN /bin/zsh -i -c "source ~/.zshrc"

RUN sudo chown -R admin:admin dotfiles/.dotfiles/
RUN mkdir dotfiles/.dotfiles/.config/nvim/plugged
RUN nvim headless +'PlugInstall --sync' +qa; exit 0

CMD [ "zsh" ]
