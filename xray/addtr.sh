#!/bin/bash
clear

domain=$(cat /root/domain)

echo -e "━━━━━━━━━━━━━━━━━" | lolcat
echo -e " TROJAN ACCOUNT  " | lolcat
echo -e "━━━━━━━━━━━━━━━━━" | lolcat
read -rp "User: " -e user
egrep -w "^### $user" /etc/xray/config.json >/dev/null
if [ $? -eq 0 ]; then
echo -e "Username Sudah Ada" | lolcat
exit 0
fi
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#trojangrpc$/a\### '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#trojanws$/a\### '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
systemctl restart xray
trojanlink="trojan://${uuid}@${domain}:443?mode=gun&security=tls&type=grpc&serviceName=trojan-grpc&sni=bug.com#${user}"
trojanlink1="trojan://${uuid}@${domain}:443?path=%2Ftrojan-ws&security=tls&host=bug.com&type=ws&sni=bug.com#${user}"
clear
echo -e ""
echo -e "━━━━-TROJAN-━━━━━" | lolcat
echo -e "Remarks        : ${user}" | lolcat
echo -e "Host/IP        : ${domain}" | lolcat
echo -e "port           : 443" | lolcat
echo -e "Key            : ${uuid}" | lolcat
echo -e "Path           : trojan-grpc" | lolcat
echo -e "━━━━━━━━━━━━━━━" | lolcat
echo -e "Trojan WS      : ${trojanlink1}" | lolcat
echo -e "━━━━━━━━━━━━━━━" | lolcat
echo -e "Trojan GRPC    : ${trojanlink}" | lolcat
echo -e "━━━━━━━━━━━━━━━" | lolcat
echo -e "Expired On     : $exp" | lolcat
echo -e ""
echo -e ""
read -n 1 -s -r -p "Press any key to back on menu"
menu
