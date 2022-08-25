#!/bin/bash

clear 

echo -e "  \e[1;32m------------------------------------------------------------\e[m" | lolcat
echo -e "                             SYSTEM MENU\e[m" | lolcat 
echo -e "  \e[1;32m------------------------------------------------------------\e[m" | lolcat
echo -e "   1    Add Host Sub Domain" | lolcat
echo -e "   2    Activated SSH WS" | lolcat
echo -e "   3    Check Usage User" | lolcat
echo -e "   4    Reboot VPS" | lolcat
echo -e "   5    Speedtest VPS" | lolcat
echo -e "   6    Running All Service" | lolcat
echo -e ""
echo -e "   x    Back To Menu" | lolcat
echo -e ""
read -p "   Select From Options [ 1 - 6 or x ] :  " menu
echo -e ""
case $menu in
1)
addhost
;;
2)
sshws
;;
3)
cekusage
;;
4)
reboot
;;
5)
speedtest
;;
6)
running
;;
x)
exit
;;
*)
clear
menu
;;
esac
