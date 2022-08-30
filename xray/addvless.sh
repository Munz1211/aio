#!/bin/bash

clear
echo "Checking VPS"
sleep 2

clear

domain=$(cat /root/domain)

echo -e " ━━━━━━━━━━━━━━━━━ " | lolcat
echo -e " Add Vless Account " | lolcat
echo -e " ━━━━━━━━━━━━━━━━━ " | lolcat
read -rp "User: " -e user
egrep -w "^### $user" /etc/xray/config.json >/dev/null
if [ $? -eq 0 ]; then
echo -e "Username Sudah Ada" | lolcat
exit 0
fi
uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "Expired (days): " masaaktif
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`
sed -i '/#vless$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
sed -i '/#vlessgrpc$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /etc/xray/config.json
vlesslink1="vless://${uuid}@${domain}:443?path=/vless&security=tls&encryption=none&type=ws#${user}"
vlesslink2="vless://${uuid}@${domain}:80?path=/vless&encryption=none&type=ws#${user}"
vlesslink3="vless://${uuid}@${domain}:443?mode=gun&security=tls&encryption=none&type=grpc&serviceName=vless-grpc&sni=bug.com#${user}"
systemctl restart xray
clear
echo -e ""
echo -e "━━━-XRAY/VLESS-━━━━" | lolcat
echo -e "Remarks        : ${user}" | lolcat
echo -e "Domain         : ${domain}" | lolcat
echo -e "port TLS       : 443" | lolcat
echo -e "port GRPC      : 443" | lolcat
echo -e "port none TLS  : 80" | lolcat
echo -e "id             : ${uuid}" | lolcat
echo -e "Encryption     : none" | lolcat
echo -e "network        : ws" | lolcat
echo -e "path           : /vless" | lolcat
echo -e "path           : /vless-grpc" | lolcat
echo -e "━━━━━━━━━━━━━━━" | lolcat
echo -e "link TLS       : ${vlesslink1}" | lolcat
echo -e "━━━━━━━━━━━━━━━" | lolcat
echo -e "link none TLS  : ${vlesslink2}" | lolcat
echo -e "━━━━━━━━━━━━━━━" | lolcat
echo -e "link GRPC      : ${vlesslink3}" | lolcat
echo -e "━━━━━━━━━━━━━━━" | lolcat
echo -e "Expired On     : $exp" | lolcat
echo -e ""
echo -e ""
read -n 1 -s -r -p "Press any key to back on menu"
menu

