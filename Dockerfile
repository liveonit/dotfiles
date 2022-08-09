FROM ubuntu:20.04 AS base
WORKDIR /usr/local/bin
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
  apt-get upgrade -y && \
  apt-get install -y software-properties-common curl git build-essential sudo
RUN apt-get install -y ansible

FROM base
RUN  useradd admin && echo "admin:admin" | chpasswd && adduser admin sudo
USER admin
WORKDIR /home/admin
COPY . ./dotfiles
# CMD ["ansible-playbook ./dotfiles/ansible/setup.yml"]
