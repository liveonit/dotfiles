#!/usr/bin/env bash

FILE_DIR=$(dirname $(readlink -f $(which "$0")))

source $FILE_DIR/print.sh

SERVER_USER=$(secman -a get -n DUVIMIOSO_SERVER_USER)
SSH_KEY_PATH=$(secman -a get -n DUVIMIOSO_SERVER_SSH_KEY_PATH)

SERVER_LAN_ADDR=$(secman -a get -n SERVER_LAN_ADDR)
SERVER_LAN_PORT=$(secman -a get -n SERVER_LAN_PORT)
SERVER_WAN_ADDR=$(secman -a get -n SERVER_WAN_ADDR)
SERVER_WAN_PORT=$(secman -a get -n SERVER_WAN_PORT)

if nc -z $SERVER_LAN_ADDR $SERVER_LAN_PORT &> /dev/null; then
  info "Stablishing ssh connection to $SERVER_USER@$SERVER_LAN_ADDR"
  ssh -i $SSH_KEY_PATH -4 -C -oObscureKeystrokeTiming=no -P $SERVER_LAN_PORT liveonit@$SERVER_LAN_ADDR
elif nc -z $SERVER_WAN_ADDR $SERVER_WAN_PORT &> /dev/null; then
  info "Stablishing ssh connection to liveonit@$SERVER_WAN_ADDR"
  ssh -i $SSH_KEY_PATH -4 -C -oObscureKeystrokeTiming=no $SERVER_USER@$SERVER_WAN_ADDR
else
  error "No SSH connection to the servers: $SERVER_LAN_ADDR on  PORT: $SERVER_LAN_PORT and $SERVER_WAN_ADDR on PORT: $SERVER_WAN_PORT"
fi
