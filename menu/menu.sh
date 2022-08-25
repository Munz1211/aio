#!/bin/bash

clear 
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
WKT=$(curl -s ipinfo.io/timezone )
IPVPS=$(curl -s ipinfo.io/ip )
DOMAIN=$(cat /var/lib/premium-script/ipvps.conf)
cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
tram=$( free -m | awk 'NR==2 {print $2}' )

echo -e "   -------------------------SPEK-VPS-CORE----------------------- " | lolcat
echo -e ""
echo -e "   \e[032;1mCPU CORE  : $cores"  | lolcat
echo -e "   \e[032;1mRAM TOTAL : $tram MB"  | lolcat
echo -e "   \e[032;1mIsp Name  : $ISP"  | lolcat
echo -e "   \e[032;1mCity      : $CITY"  | lolcat
echo -e "   \e[032;1mIP VPS    : $IPVPS"  | lolcat
echo -e "   \e[032;1mDOMAIN    : $DOMAIN"  | lolcat
echo -e ""
echo -e "   -------------------------MENU OPTIONS------------------------" | lolcat
echo -e ""
echo -e "   1  SSH & OpenVPN Menu" | lolcat
echo -e "   2  XRAY CORE Menu" | lolcat
echo -e "   3  Menu All Services" | lolcat
echo -e ""
read -p "   Select From Options [ 1 - 3 or x ] :  " menu
echo -e ""
case $menu in
1)
ssh
;;
2)
v2ray
;;
3)
menu1
;;
x)
exit
;;
*)
clear
menu
;;
esac
