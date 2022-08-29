#!/bin/bash

clear
echo "Checking VPS"
sleep 2

cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
tram=$( free -m | awk 'NR==2 {print $2}' )
ISP=$(curl -s ipinfo.io/org | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city )
IPVPS=$(curl -s ipinfo.io/ip )
WKT=$(curl -s ipinfo.io/timezone )
DOMAIN=$(cat /root/domain )
VER=$(cat /opt/.ver )

# // SSH Websocket Proxy
ssh_ws=$( systemctl status ws-stunnel | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $ssh_ws == "running" ]]; then
    status_ws="${GREEN}ON${NC}"
else
    status_ws="${RED}OFF${NC}"
fi

# // nginx
nginx=$( systemctl status nginx | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $nginx == "running" ]]; then
    status_nginx="${GREEN}ON${NC}"
else
    status_nginx="${RED}OFF${NC}"
fi

# // SSH Websocket Proxy
xray=$( systemctl status xray | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $xray == "running" ]]; then
    status_xray="${GREEN}ON${NC}"
else
    status_xray="${RED}OFF${NC}"
fi

echo -e "   -------------------------SPEK-VPS-CORE----------------------- " | lolcat
echo -e ""
echo -e "   \e[032;1mCPU CORE  : $cores"  | lolcat
echo -e "   \e[032;1mRAM TOTAL : $tram MB"  | lolcat
echo -e "   \e[032;1mIsp Name  : $ISP"  | lolcat
echo -e "   \e[032;1mCity      : $CITY"  | lolcat
echo -e "   \e[032;1mIP VPS    : $IPVPS"  | lolcat
echo -e "   \e[032;1mREGION    : $WKT"  | lolcat
echo -e "   \e[032;1mDOMAIN    : $DOMAIN"  | lolcat
echo -e ""
echo -e "   \e[032;1mSC Ver.   : $VER"  | lolcat
echo -e ""
echo -e "   -------------------------MENU OPTIONS------------------------" | lolcat
echo -e ""
echo -e "   1  SSH & OpenVPN Menu" | lolcat
echo -e "   2  XRAY CORE Menu" | lolcat
echo -e "   3  Menu All Services" | lolcat
echo -e ""
echo -e "   ------------------------STATUS SERVICE------------------------" | lolcat
echo -e ""
echo -e "   [ SSH WebSocket : ${status_ws} ]  -  [ XRAY : ${status_xray} ]  -  [ NGINX : ${status_nginx} ]" | lolcat
echo -e ""
echo -e "   --------------------------------------------------------------" | lolcat
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
