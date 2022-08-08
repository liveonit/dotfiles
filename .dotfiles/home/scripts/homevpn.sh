PUBLIC_IP=$(nslookup triactivesoft.com | grep Address | tail -n 1 |  grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}')
cat $HOME/bin/homeVpnTemplate.ovpn | sed "s/PUBLIC_IP/$PUBLIC_IP/g" > openVpn.ovpn
sudo openVpn openVpn.ovpn