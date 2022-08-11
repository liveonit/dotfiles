# Liveofit Dotfiles

## Requirements

This automated setup was tested on ubuntu 22.04 with CPU amd64 and on MacOS Monterey Version 12.4 with Apple M1 CPU.
The operating system needs to have installed git to clone this project.

## Run

### Ubuntu

Clone this repo on your home or projects folder and move to the root dir of this project. Once you are there run

```bash
sh ./install.sh   
```

### MacOS

Clone this repo on your home or projects folder and move to the root dir of this project. Once you are there run

```bash
ansible-playbook -vvv ansible/setup_macos.yml --ask-become-pass
```

## Post install

Once the base software and configurations are installed on your operating system, you are in conditions of setup your Vim environment, to do that you have to open NVIM or VIM that is only an alias of NVIM, and in the editor run the command `:PlugInstall`, this command should install all the required plugins to work with NVIM. If you have some problem on the NVIM configuration you can test the dependencies just running :checkhealth

**TIP:** to run a command you should be on `NORMAL` nvim mode if you are on `INSERT` or `VISUAL` mode just press `ESC` and then to introduce a command press `:` followed by the command.
