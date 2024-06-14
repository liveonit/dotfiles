# Liveonit Dotfiles
## Requirements

This automated setup was tested on ubuntu 22.04 with CPU amd64 and on MacOS Monterey Version 12.4 with Apple M1 CPU.
The operating system needs to have installed git to clone this project.


## Run

Clone this repo on your home or projects folder and move to the root dir of this project. Once you are there, you should change the `remote_user` on `ansible/setup_mac.yml` or `ansible/setup_ubuntu.yml` depending on your `OS`.
```yaml
- hosts: localhost
  become: yes
  remote_user: liveofit # <<<==== You should set the name of your user
```

And then just run

```bash
./install.sh
```
