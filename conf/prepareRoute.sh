#!/bin/sh

eth0_ip=`ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{print $1}'`
target_ip="${IP_ADDRESS:-$eth0_ip}"
domain_name="${DOMAIN_NAME:?"must be set"}"
zone_id="${ROUTE53_ZONE_ID:?"must be set"}"

sed -e "s/;domain_name;/${domain_name}/g" \
    -e "s/;target_ip;/${target_ip}/g" \
    /templates/route.json.tmpl > /templates/route.json

/usr/local/bin/aws route53 change-resource-record-sets \
    --hosted-zone-id ${zone_id} \
    --change-batch file:///templates/route.json
