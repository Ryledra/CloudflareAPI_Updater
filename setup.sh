#! /usr/bin/env bash

touch 2.api.conf

# request account_name, auth_email, and auth_key from user

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