#!/bin/bash

echo "Checking VPS"
sleep 2

clear
echo -e ""
echo -e "═════════════════════════════════════════" | lolcat
echo -e "             SSH & OpenVPN Menu  " | lolcat
echo -e "═════════════════════════════════════════" | lolcat
echo -e ""
echo -e " 1   Add User SSH Account" | lolcat
echo -e " 2   Cek User SSH Account" | lolcat
echo -e " 3   Del User SSH Account" | lolcat
echo -e " 4   Renew User SSH Account" | lolcat
echo -e ""
echo -e "═════════════════════════════════════════" | lolcat
echo -e " x)   MENU" | lolcat
echo -e "═════════════════════════════════════════" | lolcat
echo -e ""
read -p "     Please Input Number  [ 1 - 5 or x ] :  "  ssh
echo -e ""
case $ssh in
1)
addssh
;;
2)
cek
;;
3)
hapus
;;
4)
renew
;;
x)
exit
;;
*)
echo "Please enter an correct number"
exit
;;
esac
