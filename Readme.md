# Ubuntu dotfiles

## Requirements

All this setup was tested on ubuntu 20.04 but it should work on another debian based operating systems.
The operating system needs to have installed ansible.

## Run

Staying on this `ubuntu` directory, run

```bash
ansible-playbook -vvv dotfiles/ansible/setup.yml --ask-become-pass
```
