#!/bin/sh

IP=`ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{print $1}'`
INT_IP="${IP_ADDRESS:-$IP}"
INT_STACK="${STACK_NAME:?"must be set"}"
INT_ZONEID="${ROUTE53_ZONE_ID:?"must be set"}"

sed -r -e "s/;stack_name;/$INT_STACK/g" \
		-e "s/;private_ipv4;/$INT_IP/g" \
		 /templates/route.json.tmpl > /templates/route.json

/usr/local/bin/aws route53 change-resource-record-sets \
    --hosted-zone-id ${INT_ZONEID} \
    --change-batch file:///templates/route.json
