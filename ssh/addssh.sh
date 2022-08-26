#!/bin/bash
#########################
MYIP=$(curl -sS ipv4.icanhazip.com)

clear

domen=`cat /root/domain`

wsssl=`cat /root/log-install.txt | grep -w "SSH SSL Websocket" | cut -d: -f2 | awk '{print $1}'`

read -p "Username : " Login
read -p "Password : " Pass
read -p "Expired (hari): " masaaktif

IP=$(curl -sS ifconfig.me);
NS=$( cat /etc/xray/ns.txt )
PUB=$( cat /etc/slowdns/server.pub )

ossl=`cat /root/log-install.txt | grep -w "OpenVPN" | cut -f2 -d: | awk '{print $6}'`
opensh=`cat /root/log-install.txt | grep -w "OpenSSH" | cut -f2 -d: | awk '{print $1}'`
db=`cat /root/log-install.txt | grep -w "Dropbear" | cut -f2 -d: | awk '{print $1,$2}'`
ssl="$(cat ~/log-install.txt | grep -w "Stunnel4" | cut -d: -f2)"
sqd="$(cat ~/log-install.txt | grep -w "Squid" | cut -d: -f2)"
ovpn="$(netstat -nlpt | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"
ovpn2="$(netstat -nlpu | grep -i openvpn | grep -i 0.0.0.0 | awk '{print $4}' | cut -d: -f2)"

sleep 1
clear
useradd -e `date -d "$masaaktif days" +"%Y-%m-%d"` -s /bin/false -M $Login
exp="$(chage -l $Login | grep "Account expires" | awk -F": " '{print $2}')"
echo -e "$Pass\n$Pass\n"|passwd $Login &> /dev/null

echo -e " ━━━━━━━━━━━━━━━" | lolcat
echo -e " SSH Account    " | lolcat
echo -e " ━━━━━━━━━━━━━━━" | lolcat
echo -e " Username        : $Login" | lolcat
echo -e " Password        : $Pass" | lolcat
echo -e " Host Slowdns    : ${NS}" | lolcat
echo -e " Pub Key         : ${PUB}" | lolcat
echo -e " ━━━━━━━━━━━━━━━"
echo -e " IP              : $IP" | lolcat
echo -e " Host            : $domen" | lolcat
echo -e " OpenSSH         : $opensh" | lolcat
echo -e " Dropbear        : $db" | lolcat
echo -e " SSH-SLOW-DNS    : 53" | lolcat
echo -e " SSH-SSL-WS      : $wsssl" | lolcat
echo -e " SSL/TLS         :$ssl" | lolcat
echo -e " SSH-WS OVPN     : 2086" | lolcat
echo -e " Port Squid      :$sqd" | lolcat
echo -e " UDPGW           : 7100-7300" | lolcat
echo -e " ━━━━━━━━━━━━━━━━━━" | lolcat
echo -e " OpenVPN Config  : http://$domen:81/" | lolcat
echo -e " ━━━━━━━━━━━━━━━━━━" | lolcat
echo -e " Expired On      : $exp" | lolcat
echo -e " ━━━━━━━━━━━━━━━━━━" | lolcat
echo -e " Payload Websocket HTTP : " | lolcat
echo -e " ━━━━━━━━━━━━━━━━━━" | lolcat
echo -e " GET / HTTP/1.1[crlf]Host: ${domen}[crlf]Upgrade: websocket[crlf][crlf]" | lolcat
echo -e " ━━━━━━━━━━━━━━━━━━" | lolcat
echo -e " Payload Websocket SSL/TLS : " | lolcat
echo -e " ━━━━━━━━━━━━━━━━━━" | lolcat
echo -e " GET wss://bug.com/ HTTP/1.1[crlf]Host: ${domen}[crlf]Upgrade: websocket[crlf][crlf]" | lolcat
echo -e " ━━━━━━━━━━━━━━━━━━" | lolcat
echo -e "" | lolcat
read -n 1 -s -r -p "Press any key to back on menu"
menu
