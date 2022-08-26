#!/bin/bash
# ==========================================
# Getting
IP=$(wget -qO- ipinfo.io/ip);

clear

DOMAIN=munsc.me
domen=$( cat /root/domain )

sub=$(</dev/urandom tr -dc a-z0-9 | head -c2)
NS_DOMAIN=ns.${sub}

hasil=${NS_DOMAIN}.${domen}
CF_ID=mbahkoclok22@gmail.com
CF_KEY=bacbaf2dd9f9808ce5b1fcf562d137175e7d2

set -euo pipefail

echo "Updating DNS NS for ${NS_DOMAIN}..."

ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${NS_DOMAIN}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" | jq -r .result[0].id)

if [[ "${#RECORD}" -le 10 ]]; then
     RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"NS","name":"'${NS_DOMAIN}'","content":"'${domen}'","ttl":120,"proxied":false}' | jq -r .result.id)
fi

RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
     -H "X-Auth-Email: ${CF_ID}" \
     -H "X-Auth-Key: ${CF_KEY}" \
     -H "Content-Type: application/json" \
     --data '{"type":"NS","name":"'${NS_DOMAIN}'","content":"'${domen}'","ttl":120,"proxied":false}')

echo "Host : $hasil"
echo $hasil > /etc/xray/ns.txt

rm -f /root/ns.sh

