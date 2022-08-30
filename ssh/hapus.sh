#!/bin/bash

clear
echo "Checking VPS"
sleep 2

clear

echo "---------------------------------------------------" | lolcat
echo "USERNAME          EXP DATE          STATUS" | lolcat
echo "---------------------------------------------------" | lolcat
while read expired
do

AKUN="$(echo $expired | cut -d: -f1)"
ID="$(echo $expired | grep -v nobody | cut -d: -f3)"
exp="$(chage -l $AKUN | grep "Account expires" | awk -F": " '{print $2}')"
status="$(passwd -S $AKUN | awk '{print $2}' )"

if [[ $ID -ge 1000 ]]; then
if [[ "$status" = "L" ]]; then
printf "%-17s %2s %-17s %2s \n" "$AKUN" "$exp     " "LOCKED" | lolcat
else
printf "%-17s %2s %-17s %2s \n" "$AKUN" "$exp     " "UNLOCKED" | lolcat
fi
fi
done < /etc/passwd
JUMLAH="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
echo "---------------------------------------------------" | lolcat
echo "Account number: $JUMLAH user" | lolcat
echo "---------------------------------------------------" | lolcat
read -p "Username SSH to Delete : " Pengguna

if getent passwd $Pengguna > /dev/null 2>&1; then
        userdel $Pengguna
        echo -e ""
        echo -e "[ OK ] User ( $Pengguna ) Has Been Removed !"  | lolcat
        echo -e ""
        read -p "$( echo -e "Press [ Enter ] To Menu")" | lolcat
        menu
else
        echo -e ""
        echo -e "[ ERROR ] User ( $Pengguna ) Not Exists !" | lolcat
        echo -e ""
        read -p "$( echo -e "Press [ Enter ] To Menu")"
        menu
fi
