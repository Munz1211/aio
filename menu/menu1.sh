#!/bin/bash

clear
echo "Checking VPS"
sleep 2

clear
echo -e "  \e[1;32m------------------------------------------------------------\e[m" | lolcat
echo -e "                             SYSTEM MENU\e[m" | lolcat 
echo -e "  \e[1;32m------------------------------------------------------------\e[m" | lolcat
echo -e ""
echo -e "   1    Check Usage User" | lolcat
echo -e "   2    Reboot VPS" | lolcat
echo -e "   3    Speedtest VPS" | lolcat
echo -e "   4    Running All Service" | lolcat
echo -e "   5    Add Host Domain" | lolcat
echo -e "   6    Restart Service" | lolcat
echo -e ""
echo -e "   x    Back To Menu" | lolcat
echo -e ""
read -p "   Select From Options [ 1 - 4 or x ] :  " menu
echo -e ""
case $menu in
1)
cekusage
;;
2)
reboot
;;
3)
speedtest
;;
4)
running
;;
5)
addhost
;;
6)
xp
;;
x)
exit
;;
*)
clear
menu
;;
esac
