#!/bin/bash

echo "Checking VPS"
sleep 2

clear
echo -e ""
echo -e "\e[1;32m═══════════════════════════════════════" | lolcat
echo -e "             All Account V2Ray  " | lolcat
echo -e "\e[1;32m═══════════════════════════════════════" | lolcat
echo -e ""
echo -e " 1 Add Vmess Account" | lolcat
echo -e " 2 Add Vless Account" | lolcat
echo -e " 3 Add Trojan Account" | lolcat
echo -e " 4 Cek User Xray" | lolcat
echo -e " 5 Del User Xray" | lolcat
echo -e " 6 Renew User Xray" | lolcat
echo -e ""
echo -e "\e[1;32m═══════════════════════════════════════" | lolcat
echo -e " x)   MENU" | lolcat
echo -e "\e[1;32m═══════════════════════════════════════" | lolcat
echo -e ""
read -p "     Please Input Number  [ 1 - 6 or x ] :  "  v2ray
echo -e ""
case $v2ray in
1)
addws
;;
2)
addvless
;;
3)
addtr
;;
4)
cekws
;;
5)
delws
;;
6)
renewws
;;
x)
menu
;;
*)
clear
menu
;;
esac
