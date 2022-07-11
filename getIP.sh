#! /usr/bin/env bash

CURRENT_IP=`dig +short myip.opendns.com @resolver1.opendns.com`

echo "Current IP: ${CURRENT_IP}"