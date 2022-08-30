#!/bin/bash
# Welcome Information
# Edition : Stable Edition V1.0
# =========================================

# // Export Color & Information
NC='\033[0m'
IP=$( curl -s https://ipinfo.io/ip/ )

freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
tram=$( free -m | awk 'NR==2 {print $2}' )
swap=$( free -m | awk 'NR==4 {print $2}' )

OS_Name="$( cat /etc/os-release | grep -w ID | head -n1 | sed 's/ID//g' | sed 's/=//g' )"
OS_FName="$( cat /etc/os-release | grep -w PRETTY_NAME | head -n1 | sed 's/PRETTY_NAME//g' | sed 's/=//g' | sed 's/"//g' | sed 's/,//g'  )"
OS_Version="$( cat /etc/os-release | grep -w VERSION | head -n1 | sed 's/VERSION//g' | sed 's/=//g' | sed 's/"//g' )"
OS_Version_ID="$( cat /etc/os-release | grep -w VERSION_ID | head -n1 | sed 's/VERSION_ID//g' | sed 's/=//g' | sed 's/"//g' )"
OS_Arch="$( uname -m )"
OS_Kernel="$( uname -r )"

########################
# GETTING INFORMATION
# =========================================================================================================
# // OpenSSH
openssh=$( systemctl status ssh | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $openssh == "running" ]]; then
    status_openssh="Running${NC} ( No Error )"
else
    status_openssh="No Running${NC} ( Error )"
fi

# // Stunnel5
stunnel5=$( systemctl status stunnel4 | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $stunnel5 == "running" ]]; then
    status_stunnel5="Running${NC} ( No Error )"
else
    status_stunnel5="No Running${NC} ( Error )"
fi

# // Dropbear
dropbear=$( systemctl status dropbear | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $dropbear == "running" ]]; then
    status_dropbear="Running${NC} ( No Error )"
else
    status_dropbear="No Running${NC} ( Error )"
fi

# // Squid
squid=$( systemctl status squid | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $squid == "running" ]]; then
    status_squid="Running${NC} ( No Error )"
else
    status_squid="No Running${NC} ( Error )"
fi

# // SSH Websocket Proxy
ssh_ws=$( systemctl status ws-nontls | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $ssh_ws == "running" ]]; then
    status_ws_epro="Running${NC} ( No Error )"
else
    status_ws_epro="No Running${NC} ( Error )"
fi

# // Trojan Proxy
ss=$( systemctl status xray | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $ss == "running" ]]; then
    status_ss="Running${NC} ( No Error )"
else
    status_ss="No Running${NC} ( Error )"
fi

# // NGINX
nginx=$( systemctl status nginx | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $nginx == "running" ]]; then
    status_nginx="Running${NC} ( No Error )"
else
    status_nginx="No Running${NC} ( Error )"
fi

# =========================================================================================================

# // Running Function Requirement

if [[ $Bot == "1" ]]; then
        bot='Allowed'
else
        bot='Not Allowed'
fi

if [[ $Beta == "1" ]]; then
        beta='Allowed'
else
        beta='Not Allowed'
fi

if [[ $Backup == "1" ]]; then
        backup='Allowed'
else
        backup='Not Allowed'
fi

# // Clear
clear
clear && clear && clear
clear;clear;clear

echo -e "----------------------------------------------------------" | lolcat
echo -e "                ( STATUS SERVICE INFORMATION )            " | lolcat
echo -e "----------------------------------------------------------" | lolcat
echo ""
echo -e "                     Sytem Information                    " | lolcat
echo -e ""
echo -e "Server Uptime       = $( uptime -p  | cut -d " " -f 2-10000 ) " | lolcat
echo -e "Current Time        = $( date -d "0 days" +"%d-%m-%Y | %X" )" | lolcat
echo -e "Script Version      = 3.1" | lolcat
echo -e "Operating System    = ${OS_FName} ( ${OS_Arch} )" | lolcat
echo -e "Total Amount RAM    = $tram MB" | lolcat
echo -e "Current Domain      = $(cat /root/domain)" | lolcat
echo -e "Server IP           = ${IP}" | lolcat
echo ""
echo -e "                     Service Information                  " | lolcat
echo -e ""
echo -e "OpenSSH             = $status_openssh" | lolcat
echo -e "Dropbear            = $status_dropbear" | lolcat
echo -e "Stunnel4            = $status_stunnel5" | lolcat
echo -e "Squid               = $status_squid" | lolcat
echo -e "NGINX               = $status_nginx" | lolcat
echo -e "SSH NonTLS          = $status_ws_epro" | lolcat
echo -e "SSH TLS             = $status_ws_epro" | lolcat
echo -e "Vmess WS/GRPC       = $status_ss" | lolcat
echo -e "Vless WS/GRPC       = $status_ss" | lolcat
echo -e "Trojan WS/GRPC      = $status_ss" | lolcat
echo -e ""
read -n 1 -s -r -p "Press any key to back on menu"
menu

