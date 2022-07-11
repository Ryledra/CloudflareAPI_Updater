#! /usr/bin/env bash

source api.conf
source getIP.sh

# get DNS IP for DNS record ${DNS_ID}
curl -X GET "https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/dns_records/${DNS_ID}" \
    -H "X-Auth-Email: ${X_AUTH_EMAIL}" \
    -H "X-Auth-Key: ${X_AUTH_KEY}" \
    -H "Content-Type: application/json" \
    > result.json

DNS_TYPE=`   jq -r ".result.type"    result.json`
DNS_NAME=`   jq -r ".result.name"    result.json`
DNS_CONTENT=`jq -r ".result.content" result.json`
DNS_TTL=`    jq -r ".result.ttl"     result.json`
DNS_PROXIED=`jq -r ".result.proxied" result.json`

echo "DNS Record IP: ${DNS_CONTENT}"

if [ ${DNS_CONTENT} != ${CURRENT_IP} ]; then
    echo "different"
    curl -X PUT "https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/dns_records/${DNS_ID}" \
        -H "X-Auth-Email: ${X_AUTH_EMAIL}" \
        -H "X-Auth-Key: ${X_AUTH_KEY}" \
        -H "Content-Type: application/json" \
        --data "{\"type\":\"${DNS_TYPE}\",\"name\":\"${DNS_NAME}\",\"content\":\"${CURRENT_IP}\",\"ttl\":${DNS_TTL},\"proxied\":${DNS_PROXIED}}"
        echo "\"`date`\" : \"${DNS_CONTENT}\" -> \"${CURRENT_IP}\"" >> update.log
fi

rm result.json