#!/bin/bash
#########################

MYIP=$(curl -sS ipv4.icanhazip.com)

clear
echo "Checking VPS"
sleep 2

clear
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/xray/config.json")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | lolcat
                echo -e "       Delete Vmess Account        " | lolcat
                echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | lolcat
		echo ""
		echo -e "   You have no existing clients!   " | lolcat
		echo ""
		echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | lolcat
		read -n 1 -s -r -p "Press any key to back on menu"
		menu
	fi

	clear
		echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | lolcat
                echo -e "       Delete Vmess Account        " | lolcat
                echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | lolcat
		echo -e ""
		echo -e "  	User       	Expired     " | lolcat
		echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | lolcat
		grep -e "^### " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | column -t | sort | uniq
    		echo ""
    		echo -e "tap enter to go back" | lolcat
    		echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | lolcat
	  	read -rp "Input Username : " user
    if [ -z $user ]; then
    menu
    else
    exp=$(grep -wE "^### $user" "/etc/xray/config.json" | cut -d ' ' -f 3 | sort | uniq)
    sed -i "/^### $user $exp/,/^},{/d" /etc/xray/config.json
    systemctl restart xray > /dev/null 2>&1
    clear
    echo -e " ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | lolcat
    echo -e "  V2RAY Account Deleted Successfully" | lolcat
    echo -e " ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | lolcat
    echo -e "  Client Name : $user" | lolcat
    echo -e "  Expired On  : $exp" | lolcat
    echo -e "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" | lolcat
    echo ""
    read -n 1 -s -r -p "Press any key to back on menu"
    
    menu
    fi
