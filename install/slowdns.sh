#!/bin/bas

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

clear
# ===============================================
cd
wget -q -O /root/ns.sh "https://raw.githubusercontent.com/Munz1211/aio/main/slow/ns.sh" ; chmod +x ns.sh ; ./ns.sh
echo -e "${OKEY} Processing For( ${GREEN}{ Installing }${NC} )"
nameserver=$(cat /etc/xray/ns.txt)
echo -e "${WARNING} Update( ${GREEN}${ Dependencies }${NC} )"
apt update -y
apt install -y python3 python3-dnslib net-tools
apt install ncurses-utils -y
apt install dnsutils -y
apt install golang -y
apt install git -y
apt install curl -y
apt install wget -y
apt install ncurses-utils -y
apt install screen -y
apt install cron -y
apt install iptables -y
apt install -y git screen whois dropbear wget
apt install -y pwgen python php jq curl
apt install -y sudo gnutls-bin
apt install -y mlocate dh-make libaudit-dev build-essential
apt install -y dos2unix debconf-utils
service cron reload
service cron restart
echo -e "${OKEY} Starting( ${GREEN} Istall slowdns ${NC} )"
#// port

cd
mkdir -m 777 /etc/slowdns
wget -q -O /root/plugin.zip "https://raw.githubusercontent.com/Munz1211/aio/main/slow/plugin.zip"
unzip plugin.zip
rm -r -f plugin.zip
cd dnstt-plugin
cd dnstt-client
go build
mv dnstt-client /etc/slowdns/client
cd /root/dnstt-plugin/dnstt-server
go build
./dnstt-server -gen-key -privkey-file server.key -pubkey-file server.pub
mv dnstt-server /etc/slowdns/server
mv server.key /etc/slowdns/
mv server.pub /etc/slowdns/

chmod +x /etc/slowdns/server.key
chmod +x /etc/slowdns/server.pub
chmod +x /etc/slowdns/server
chmod +x /etc/slowdns/client
cd
rm -r -f /root/dnstt-plugin
chmod +x /usr/local/sbin/trialssh
wget -q -O /etc/ssh/sshd_config "https://raw.githubusercontent.com/Munz1211/aio/main/slow/sshd"
chmod +x /etc/ssh/sshd_config

#install client.service
cat > /etc/systemd/system/client.service << END
[Unit]
Description=Client SlowDNS By Munzcore
Documentation=http://munzsc.me
After=network.target nss-lookup.target
[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/etc/slowdns/client -udp 8.8.8.8:53 --pubkey-file /etc/slowdns/server.pub $nameserver 127.0.0.1:3369
Restart=on-failure
[Install]
WantedBy=multi-user.target
END
cd
#install server.service
cat > /etc/systemd/system/server.service << END
[Unit]
Description=Server SlowDNS
Documentation=http://munzsc.me
After=network.target nss-lookup.target
[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/etc/slowdns/server -udp :5300 -privkey-file /etc/slowdns/server.key $nameserver 127.0.0.1:2269
Restart=on-failure
[Install]
WantedBy=multi-user.target
END
cd

# nano /etc/rc.local
cat > /etc/rc.local <<-END
#!/bin/sh -e
# rc.local
# By default this script does nothing.
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
iptables -I INPUT -p udp --dport 5300 -j ACCEPT
iptables -t nat -I PREROUTING -p udp --dport 53 -j REDIRECT --to-ports 5300
exit 0
END

# Ubah izin akses
chmod +x /etc/rc.local

# enable rc local
systemctl enable rc-local
systemctl start rc-local.service

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local
#// finnishing
echo -e "${OKEY} ( ${GREEN}Finnishing${NC} )"
chmod +x /etc/systemd/system/client.service
chmod +x /etc/systemd/system/server.service
sudo apt remove apache2 -y
sudo apt purge apache2 -y
pkill server
pkill client
systemctl daemon-reload
systemctl stop client
systemctl stop server
systemctl enable client
systemctl enable server
systemctl start client
systemctl start server
systemctl restart client
systemctl restart server
systemctl restart ssh
systemctl restart sshd
cd
rm -f /root/slowdns.sh
