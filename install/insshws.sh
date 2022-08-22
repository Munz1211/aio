#!/bin/bash
#installer Websocker tunneling 

cd

#Install Script Websocket-SSH Python
wget -O /usr/local/bin/ws-dropbear https://raw.githubusercontent.com/Munz1211/aio/main/py/dropbear-ws.py && chmod +x /usr/local/bin/ws-dropbear
wget -O /etc/systemd/system/ws-dropbear.service https://raw.githubusercontent.com/Munz1211/aio/main/py/service-wsdropbear && chmod +x /etc/systemd/system/ws-dropbear.service

wget -O /usr/local/bin/ws-stunnel https://raw.githubusercontent.com/Munz1211/aio/main/py/ws-stunnel && chmod +x /usr/local/bin/ws-stunnel
wget -O /etc/systemd/system/ws-stunnel.service https://raw.githubusercontent.com/Munz1211/aio/main/py/ws-stunnel.service && chmod +x /etc/systemd/system/ws-stunnel.service

systemctl daemon-reload

systemctl enable ws-dropbear.service
systemctl start ws-dropbear.service
systemctl restart ws-dropbear.service

systemctl enable ws-stunnel.service
systemctl start ws-stunnel.service
systemctl restart ws-stunnel.service
