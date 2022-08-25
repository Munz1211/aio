#!/bin/bash

clear 

echo -e "  \e[1;32m------------------------------------------------------------\e[m" | lolcat
echo -e "                             SYSTEM MENU\e[m" | lolcat 
echo -e "  \e[1;32m------------------------------------------------------------\e[m" | lolcat
echo -e "   1    Add Host Sub Domain" | lolcat
echo -e "   2    Check Usage User" | lolcat
echo -e "   3    Reboot VPS" | lolcat
echo -e "   4    Speedtest VPS" | lolcat
echo -e "   5    Running All Service" | lolcat
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
cekusage
;;
3)
reboot
;;
4)
speedtest
;;
5)
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
