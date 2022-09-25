#!/bin/bash
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================

MYIP=$(curl -sS ipinfo.io/ip)

clear

# initialisasi var
export DEBIAN_FRONTEND=noninteractive
OS=`uname -m`;
MYIP=$(curl -sS ifconfig.me);
MYIP2="s/xxxxxxxxx/$MYIP/g";
ANU=$(ip -o $ANU -4 route show to default | awk '{print $5}');

# Install OpenVPN dan Easy-RSA
apt install openvpn easy-rsa unzip -y
apt install openssl iptables iptables-persistent -y
mkdir -p /etc/openvpn/server/easy-rsa/
cd /etc/openvpn/
wget https://raw.githubusercontent.com/Munz1211/aio/main/ssh/vpn.zip
unzip vpn.zip
rm -f vpn.zip
chown -R root:root /etc/openvpn/server/easy-rsa/

cd
mkdir -p /usr/lib/openvpn/
cp /usr/lib/x86_64-linux-gnu/openvpn/plugins/openvpn-plugin-auth-pam.so /usr/lib/openvpn/openvpn-plugin-auth-pam.so

# nano /etc/default/openvpn
sed -i 's/#AUTOSTART="all"/AUTOSTART="all"/g' /etc/default/openvpn

# restart openvpn dan cek status openvpn
systemctl enable --now openvpn-server@server-tcp
systemctl enable --now openvpn-server@server-udp
/etc/init.d/openvpn restart
/etc/init.d/openvpn status

# aktifkan ip4 forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward
sed -i 's/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g' /etc/sysctl.conf

# Buat config client TCP 1194
cat > /etc/openvpn/tcp.ovpn <<-END
client
dev tun
proto tcp
remote xxxxxxxxx 1194
resolv-retry infinite
route-method exe
nobind
persist-key
persist-tun
auth-user-pass
comp-lzo
verb 3
END

sed -i $MYIP2 /etc/openvpn/tcp.ovpn;

# Buat config client UDP 2200
cat > /etc/openvpn/udp.ovpn <<-END
client
dev tun
proto udp
remote xxxxxxxxx 2200
resolv-retry infinite
route-method exe
nobind
persist-key
persist-tun
auth-user-pass
comp-lzo
verb 3
END

sed -i $MYIP2 /etc/openvpn/udp.ovpn;

# Buat config client SSL
cat > /etc/openvpn/ssl.ovpn <<-END
client
dev tun
proto tcp
remote xxxxxxxxx 442
resolv-retry infinite
route-method exe
nobind
persist-key
persist-tun
auth-user-pass
comp-lzo
verb 3
END

sed -i $MYIP2 /etc/openvpn/ssl.ovpn;

cd
# pada tulisan xxx ganti dengan alamat ip address VPS anda 
/etc/init.d/openvpn restart

# masukkan certificatenya ke dalam config client TCP 1194
echo '<ca>' >> /etc/openvpn/tcp.ovpn
cat /etc/openvpn/server/ca.crt >> /etc/openvpn/tcp.ovpn
echo '</ca>' >> /etc/openvpn/tcp.ovpn

# Copy config OpenVPN client ke home directory root agar mudah didownload ( TCP 1194 )
cp /etc/openvpn/tcp.ovpn /home/vps/public_html/tcp.ovpn

# masukkan certificatenya ke dalam config client UDP 2200
echo '<ca>' >> /etc/openvpn/udp.ovpn
cat /etc/openvpn/server/ca.crt >> /etc/openvpn/udp.ovpn
echo '</ca>' >> /etc/openvpn/udp.ovpn

# Copy config OpenVPN client ke home directory root agar mudah didownload ( UDP 2200 )
cp /etc/openvpn/udp.ovpn /home/vps/public_html/udp.ovpn

# masukkan certificatenya ke dalam config client SSL
echo '<ca>' >> /etc/openvpn/ssl.ovpn
cat /etc/openvpn/server/ca.crt >> /etc/openvpn/ssl.ovpn
echo '</ca>' >> /etc/openvpn/ssl.ovpn

# Copy config OpenVPN client ke home directory root agar mudah didownload ( SSL )
cp /etc/openvpn/ssl.ovpn /home/vps/public_html/ssl.ovpn

#firewall untuk memperbolehkan akses UDP dan akses jalur TCP

iptables -t nat -I POSTROUTING -s 10.6.0.0/24 -o $ANU -j MASQUERADE
iptables -t nat -I POSTROUTING -s 10.7.0.0/24 -o $ANU -j MASQUERADE
iptables-save > /etc/iptables.up.rules
chmod +x /etc/iptables.up.rules

iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload

# Restart service openvpn
systemctl enable openvpn
systemctl start openvpn
/etc/init.d/openvpn restart

# Delete script
 
cd /home/vps/public_html/
zip tcp.ovpn udp.ovpn ssl.ovpn
cd
cat <<'mySiteOvpn' > /home/vps/public_html/index.html
<!DOCTYPE html>
<html lang="en">
   <!-- Simple OVPN Download site by Munz-Core -->
   <head>
      <center>
         <center>
            <meta charset="utf-8" />
            <title>File Config OVPN</title>
            <meta name="viewport" content="width=device-width" />
            <div class="container padded" id="dl-clients">
   <body>
      <meta name="description" content="MyScriptName Server" />
      <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport">
      <meta name="theme-color" content="#000000" />
      <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
      <link href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">
      <link href="https://cdnjs.cloudflare.com/ajax/libs/mdbootstrap/4.8.3/css/mdb.min.css" rel="stylesheet">
      <div class="container justify-content-center" style="margin-top:1em; margin-bottom:1em;">
         <div class="col-md">
            <div class="view">
               <img src="https://openvpn.net/wp-content/uploads/openvpn.jpg" style="width:500px; height:378px; float:left;" class="card-img-top">
               <div class="card">
                  <h4 class="card-title"></h4>
                  <span class="badge light-blue darken-4">CONFIG OVPN LIST</span>
                  </img>
                  <div class="mask rgba-white-slight"></div>
               </div>
               <br />
               <ul class="list-group" style="width:500px; height:100px;">
                  <li class="list-group-item justify-content-between align-items-center" style="margin-bottom:1em;">
                     <p>
                        <span class="badge light-blue darken-4">Android/iOS/PC/Modem</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp <span class="badge light-blue darken-4">Android/iOS/PC/Modem</span>
                        <br />
                        <br />
                        <small>&nbsp;&nbsp;Config OVPN Protocol TCP-1194</small>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <small>Config OVPN Protocol UDP-2200</small>
                     <p>
                        <a class="btn btn-outline-success waves-effect btn-sm" href="http://IP-ADDRESSS:81/tcp.ovpn" style="float:center;">
                           <i class="fa fa-download"></i> Download </a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a class="btn btn-outline-success waves-effect btn-sm" href="http://IP-ADDRESSS:81/udp.ovpn" style="float:center;">
                           <i class="fa fa-download"></i> Download </a>
                  </li>
                  <li class="list-group-item justify-content-between align-items-center" style="margin-bottom:1em;">
                     <p>
                        <span class="badge light-blue darken-4">Android/iOS/PC/Modem</span>
                        <br />
                        <br />
                        <small>Config OVPN Protocol Ssl-442</small>
                     </p>
                     <a class="btn btn-outline-success waves-effect btn-sm" href="http://IP-ADDRESSS:81/ssl.ovpn" style="float:center;">
                        <i class="fa fa-download"></i> Download </a>
                  </li>
                  <style type="text/css">
                     body {
                        font-family: Verdana, Arial, Helvetica, sans-serif;
                        font-size: 14px;
                        background-color: black;
                     }
                  </style>
               </ul>
            </div>
         </div>
      </div>
      </div>
   </body>
</html>
mySiteOvpn

sed -i "s|IP-ADDRESSS|$(cat /root/domain)|g" /home/vps/public_html/index.html

history -c
rm -f /root/vpn.sh
