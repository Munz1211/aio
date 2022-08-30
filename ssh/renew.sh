#!/bin/bash

clear
echo "Checking VPS"
sleep 2

clear

read -p "         Username       :  " User
egrep "^$User" /etc/passwd >/dev/null
if [ $? -eq 0 ]; then
read -p "         Day Extend     :  " Days

Today=`date +%s`
Days_Detailed=$(( $Days * 86400 ))
Expire_On=$(($Today + $Days_Detailed))
Expiration=$(date -u --date="1970-01-01 $Expire_On sec GMT" +%Y/%m/%d)
Expiration_Display=$(date -u --date="1970-01-01 $Expire_On sec GMT" '+%d %b %Y')
passwd -u $User
usermod -e  $Expiration $User

egrep "^$User" /etc/passwd >/dev/null
echo -e "$Pass\n$Pass\n"|passwd $User &> /dev/null
clear
echo -e ""
echo -e "========================================" | lolcat
echo -e ""
echo -e "    Username        :  $User" | lolcat
echo -e "    Days Added      :  $Days Days" | lolcat
echo -e "    Expires on      :  $Expiration_Display" | lolcat
echo -e ""
echo -e "========================================" | lolcat
echo -e ""
read -p "$( echo -e "Press [ Enter ] To Menu")"
menu
else
clear
echo -e ""
echo -e "======================================" | lolcat
echo -e ""
echo -e "        Username Doesnt Exist        " | lolcat
echo -e ""
echo -e "======================================" | lolcat
echo -e ""
read -p "$( echo -e "Press [ Enter ] To Menu")"
menu
fi
