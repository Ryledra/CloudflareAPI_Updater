#! /usr/bin/env bash

source api.conf
source getIP.sh

# get account list
#echo "account"
#curl -X GET "https://api.cloudflare.com/client/v4/accounts?page=1&per_page=20&direction=desc&name=${ACCOUNT_NAME}" \
#    -H "X-Auth-Email: ${X_AUTH_EMAIL}" \
#    -H "X-Auth-Key: ${X_AUTH_KEY}" \
#    -H "Content-Type: application/json"

# get user tokens list
#echo "user tokens"
#curl -X GET "https://api.cloudflare.com/client/v4/user/tokens?page=1&per_page=20&direction=desc" \
#    -H "X-Auth-Email: ${X_AUTH_EMAIL}" \
#    -H "X-Auth-Key: ${X_AUTH_KEY}" \
#    -H "Content-Type: application/json"

# get zone list
#echo "zone list"
#curl -X GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active&account.id=${ACCOUNT_ID}&account.name=${ACCOUNT_NAME}&page=1&per_page=20&order=status&direction=desc&match=all" \
#    -H "X-Auth-Email: ${X_AUTH_EMAIL}" \
#    -H "X-Auth-Key: ${X_AUTH_KEY}" \
#    -H "Content-Type: application/json"

# get DNS IP for DNS record ${DNS_ID}
curl -X GET "https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/dns_records/${DNS_ID}" \
    -H "X-Auth-Email: ${X_AUTH_EMAIL}" \
    -H "X-Auth-Key: ${X_AUTH_KEY}" \
    -H "Content-Type: application/json" \
    > result.json

DNS_TYPE=`jq -r ".result.type" result.json`
DNS_NAME=`jq -r ".result.name" result.json`
DNS_CONTENT=`jq -r ".result.content" result.json`
DNS_TTL=`jq -r ".result.ttl" result.json`
DNS_PROXIED=`jq -r ".result.proxied" result.json`

echo "DNS Record IP: ${DNS_CONTENT}"

if [ ${DNS_CONTENT} != ${CURRENT_IP} ]; then
    echo "different"
    curl -X PUT "https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/dns_records/${DNS_ID}" \
        -H "X-Auth-Email: ${X_AUTH_EMAIL}" \
        -H "X-Auth-Key: ${X_AUTH_KEY}" \
        -H "Content-Type: application/json" \
        --data "{\"type\":\"${DNS_TYPE}\",\"name\":\"${DNS_NAME}\",\"content\":\"${CURRENT_IP}\",\"ttl\":${DNS_TTL},\"proxied\":${DNS_PROXIED}}"
fi