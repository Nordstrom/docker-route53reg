#!/bin/sh

eth0_ip=`ip route | awk '/scope/ { print $9 }'`
target_ip="${IP_ADDRESS:-$eth0_ip}"
domain_name="${DOMAIN_NAME:?"must be set"}"
zone_id="${ROUTE53_ZONE_ID:?"must be set"}"

sed -e "s|\$${DOMAIN_NAME}|${domain_name}|g" \
    -e "s|\$${TARGET_IP}|${target_ip}|g" \
    /templates/route.json.tmpl > /route.json

/usr/local/bin/aws route53 change-resource-record-sets \
    --hosted-zone-id ${zone_id} \
    --change-batch file:///route.json

if [[ -z "$1" ]]; do
    exec "$@"
fi
