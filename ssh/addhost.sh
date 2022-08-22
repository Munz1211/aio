#!/bin/bash

#########################

MYIP=$(curl -sS ipv4.icanhazip.com)

red='\e[1;31m'
green='\e[0;32m'
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }

clear
#echo -e "\033[0;34m━━━━━━━━━━━━━━\033[0m"
echo ""
read -rp "Domain/Host: " -e host
echo ""
if [ -z $host ]; then
echo "????"
echo -e "\033[0;34m━━━━━━━━━━━━━━━━\033[0m"
read -n 1 -s -r -p "Press any key to back on menu"
setting-menu
else
echo "$host" > /root/domain
echo -e "\033[0;34m━━━━━━━━━━━━━━━━\033[0m"
echo "Wait For Renew Cert"
sleep 5
crt
clear
echo "Done Renew Cert"
echo ""
sleep 3
read -n 1 -s -r -p "Press any key to back on menu"
menu
fi
