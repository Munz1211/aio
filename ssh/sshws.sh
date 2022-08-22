#!/bin/bash

#########################

MYIP=$(curl -sS ipv4.icanhazip.com)

red='\e[1;31m'
green='\e[1;32m'
yl='\033[1;33m'
NC='\e[0m'
green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }

portdb=`cat ~/log-install.txt | grep -w "Dropbear" | cut -d: -f2|sed 's/ //g' | cut -f2 -d","`
portsshws=`cat ~/log-install.txt | grep -w "SSH Websocket" | cut -d: -f2 | awk '{print $1}'`
status="$(systemctl show sshws.service --no-page)"                                      
status_text=$(echo "${status}" | grep 'ActiveState=' | cut -f2 -d=)

if [ -f "/etc/systemd/system/sshws.service" ]; then
clear
else
wget -q -O /usr/bin/proxy3.js "https://raw.githubusercontent.com/Munz1211/aio/main/tambahan/proxy3.js"
cat <<EOF> /etc/systemd/system/sshws.service
[Unit]
Description=WSenabler
Documentation=munz

[Service]
Type=simple
ExecStart=/usr/bin/ssh-wsenabler
KillMode=process
Restart=on-failure
RestartSec=1s

[Install]
WantedBy=multi-user.target
EOF
fi

Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[ON]${Font_color_suffix}"
Error="${Red_font_prefix}[OFF]${Font_color_suffix}"

function start() {
PID=`ps -ef |grep -v grep | grep sshws |awk '{print $2}'`
if [[ ! -z "${PID}" ]]; then
echo "Already ON !"
else
wget -q -O /usr/bin/ssh-wsenabler "https://raw.githubusercontent.com/Munz1211/aio/main/tambahan/sshws-true.sh" && chmod +x /usr/bin/ssh-wsenabler && /usr/bin/ssh-wsenabler
systemctl daemon-reload >/dev/null 2>&1
systemctl enable sshws.service >/dev/null 2>&1
systemctl start sshws.service >/dev/null 2>&1
sed -i "/SSH Websocket/c\   - SSH Websocket           : $portsshws [ON]" /root/log-install.txt
echo -e "${green}SSH Websocket Started${NC}"
fi
}

function stop() {
PID=`ps -ef |grep -v grep | grep sshws |awk '{print $2}'`
if [[ ! -z "${PID}" ]]; then
systemctl stop sshws.service
tmux kill-session -t sshws
sed -i "/SSH Websocket/c\   - SSH Websocket           : $portsshws [OFF]" /root/log-install.txt
echo -e "${red}SSH Websocket Stopped${NC}"
fi
}

clear
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | lolcat
echo -e "             SSH WEBSOCKET           " | lolcat
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | lolcat
echo ""
if [ "${status_text}" == "active" ]                                                     
then                                                                                    
echo -e " ssh ws status : "RUNNING""  | lolcat
else                                                                                    
echo -e " ssh ws status : "NOT RUNNING" " | lolcat
echo -e ""
echo -e " 1. Enable SSH Websocket" | lolcat
echo -e " 2. Disable SSh Websocket" | lolcat
echo ""
echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | lolcat
echo ""
read -rp "Input Number : " -e num

if [[ "$num" = "1" ]]; then
start
elif [[ "$num" = "2" ]]; then
stop

else

clear
menu

fi
read -n 1 -s -r -p "Press any key to back on menu"
menu
