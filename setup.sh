#! /usr/bin/env bash

CONF_FILE="api.conf.2"

# request domain, account_name, auth_email, and auth_key from user
read -p "Enter your domain name: " domain

read -p "Enter your user's account name: " account_name

read -p "Enter your user's authorised email address: " auth_email

read -p "Enter your authorisation key: " auth_key

#echo "ACCOUNT_NAME=\"${account_name}\"" >> ${CONF_FILE}
echo "X_AUTH_EMAIL=\"${auth_email}\""   > ${CONF_FILE}
echo "X_AUTH_KEY=\"${auth_key}\""       >> ${CONF_FILE}

# get account list to retrieve account_id
curl -X GET "https://api.cloudflare.com/client/v4/accounts?page=1&per_page=20&direction=desc&name=${account_name}" \
    -H "X-Auth-Email: ${auth_email}" \
    -H "X-Auth-Key: ${auth_key}" \
    -H "Content-Type: application/json" \
    > result.json

account_id=`jq -r ".result[0].id" result.json`
#echo "ACCOUNT_ID=\"${account_id}\"" >> ${CONF_FILE}

# get user tokens list
#echo "user tokens"
#curl -X GET "https://api.cloudflare.com/client/v4/user/tokens?page=1&per_page=20&direction=desc" \
#    -H "X-Auth-Email: ${auth_email}" \
#    -H "X-Auth-Key: ${auth_key}" \
#    -H "Content-Type: application/json" \
#    > result.json

# get zone id
curl -X GET "https://api.cloudflare.com/client/v4/zones?name=${domain}&status=active&account.id=${account_id}&account.name=${account_name}&page=1&per_page=20&order=status&direction=desc&match=all" \
    -H "X-Auth-Email: ${auth_email}" \
    -H "X-Auth-Key: ${auth_key}" \
    -H "Content-Type: application/json" \
    > result.json

zone_id=`jq -r ".result[0].id" result.json`
echo "ZONE_ID=\"${zone_id}\"" >> ${CONF_FILE}

# get dns id
curl -X GET "https://api.cloudflare.com/client/v4/zones/${zone_id}/dns_records" \
    -H "X-Auth-Email: ${auth_email}" \
    -H "X-Auth-Key: ${auth_key}" \
    -H "Content-Type: application/json" \
    > result.json

dns_count=`jq -r ".result | length" result.json`

for (( i=0 ; i<${dns_count}; i++ ))
do
    echo "${i} : `jq -r ".result[${i}].name" result.json`"
done

read -p "Select desired DNS: " dns_id_pos
dns_id=`jq -r ".result[${dns_id_pos}].id" result.json`
echo "DNS_ID=\"${dns_id}\"" >> ${CONF_FILE}