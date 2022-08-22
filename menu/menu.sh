#!/bin/bash
# Menu For Script
# Edition : Stable Edition V1.0
# =========================================

freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
	tram=$( free -m | awk 'NR==2 {print $2}' )
	swap=$( free -m | awk 'NR==4 {print $2}' )

clear
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

clear
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${RED_BG}                 VPS / Sytem Information                  ${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e ""
echo -e "Sever Uptime        = $( uptime -p  | cut -d " " -f 2-10000 ) "
echo -e "Current Time        = $( date -d "0 days" +"%d-%m-%Y | %X" )"
echo -e "Operating System    = $( cat /etc/os-release | grep -w PRETTY_NAME | sed 's/PRETTY_NAME//g' | sed 's/=//g' | sed 's/"//g' ) ( $( uname -m) )"
echo -e "Total Amount RAM    = $tram MB"
echo -e "Current Domain      = $(cat /root/domain)"
echo -e "Server IP           = ${IP}"
echo -e ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e " [ SSH WebSocket${NC} : ${status_ws} ]   [ XRAY${NC} : ${status_xray} ]   [ NGINX${NC} : ${status_nginx} ]"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e ""
echo -e "[${GREEN}01${NC}]${RED} •${NC} Add User SSH$NC         [${GREEN}10${NC}]${RED} • ${NC}Cek Usage"
echo -e "[${GREEN}02${NC}]${RED} •${NC} SSH WS Enable$NC        [${GREEN}11${NC}]${RED} • ${NC}Cek User Xray $NC"
echo -e "[${GREEN}03${NC}]${RED} •${NC} Cek User SSH$NC         [${GREEN}12${NC}]${RED} • ${NC}Del User Xray $NC"
echo -e "[${GREEN}04${NC}]${RED} •${NC} Del User SSH$NC         [${GREEN}13${NC}]${RED} • ${NC}Renew User Xray $NC"
echo -e "[${GREEN}05${NC}]${RED} •${NC} Renew SSH $NC           [${GREEN}14${NC}]${RED} • ${NC}Add-host $NC"
echo -e "[${GREEN}06${NC}]${RED} •${NC} Member SSH $NC          [${GREEN}15${NC}]${RED} • ${NC}Running $NC"
echo -e "[${GREEN}07${NC}]${RED} •${NC} Add Vmess Account $NC"
echo -e "[${GREEN}08${NC}]${RED} •${NC} Add Vless Account $NC"
echo -e "[${GREEN}09${NC}]${RED} •${NC} Addd Trojan Account$NC"
echo -e "${RED}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${RED_BG}                     MUNZ CORE                         ${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e ""

read -p "Input Your Choose ( 1-18 ) : " choosemu


case $choosemu in
    1) # >> CREATE SSH
        addssh
    ;;
    2) # >> ON OFF SSH WS
        sshws
    ;;
    3) # >> CEK SSH
        cek
    ;;
    4) # >> HAPUS AKUN
        hapus
    ;;
    5) # >> ALL Service
        renew
    ;;
    6) # >> Speedtest
        member
    ;;
    7) # >> Ram Usage
        addws
    ;;
    8) # >> Bandiwdth usage
        clear
        addvless
    ;;
    9) # >> Change Timezone
        addtr
    ;;
    10) # // Change License
        cekusage
    ;;
    11) # >> Change domain
        cekws
    ;;
    12) # // Renew SSL Cert
        delws
    ;;
    13) # // Add mail
        renewws
    ;;
    14) # // Backup
        addhost
    ;;
    15) # // STATUS RUNNING
        running
    ;;
    *) # >> Wrong Select
        echo -e "${EROR} SALAH SAYANG !!!"
        sleep 1
        menu
    ;;
esac
