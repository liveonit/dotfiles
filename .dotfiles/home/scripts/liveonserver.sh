#!/usr/bin/env bash

FILE_DIR=$(dirname $(readlink -f $(which "$0")))

source $FILE_DIR/print.sh


IP_SERVER_LAN=192.168.1.69
IP_SERVER_VPN=100.127.135.65

if ping -c 1 $IP_SERVER_LAN &> /dev/null; then
  echo `info "Stablishing ssh connection to liveonit@$IP_SERVER_LAN"`
  ssh -4 -C -oObscureKeystrokeTiming=no liveonit@$IP_SERVER_LAN
elif ping -c 1 $IP_SERVER_VPN &> /dev/null; then
  echo `info "Stablishing ssh connection to liveonit@$IP_SERVER_VPN"`
  ssh -4 -C -oObscureKeystrokeTiming=no liveonit@$IP_SERVER_VPN
else
  echo `error "No connection to any of the servers: $IP_SERVER_LAN nor $IP_SERVER_VPN"`
fi
