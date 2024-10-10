#!/bin/bash

END='\033[0m'
RED='\033[1;91m'
GREEN='\033[1;92m'
YELLOW='\033[1;93m'

containers=$(docker ps -q)
for c_id in ${containers[@]}; do
	hostname=$(docker exec $c_id hostname)
	if [[ $hostname == "host_lsirigna-1" ]]; then
		echo "${GREEN}$hostname : ${END}"
		docker exec $c_id sh -c "ip a | grep eth1 | grep inet | cut -d ' ' -f 6"
	elif [[ $hostname == "host_lsirigna-2" ]]; then
		echo "${GREEN}$hostname : ${END}"
		docker exec $c_id sh -c "ip a | grep eth1 | grep inet | cut -d ' ' -f 6"
	elif [[ $hostname == "host_lsirigna-3" ]]; then
		echo "${GREEN}$hostname : ${END}"
		docker exec $c_id sh -c "ip a | grep eth1 | grep inet | cut -d ' ' -f 6"
	elif [[ $hostname == "router_lsirigna-1" ]]; then
		echo "${YELLOW}$hostname : ${END}"
		docker exec $c_id sh -c "ip a | grep eth1 | grep inet | cut -d ' ' -f 6"
		docker exec $c_id sh -c "ip a | grep eth0 | grep inet | cut -d ' ' -f 6"
	elif [[ $hostname == "router_lsirigna-2" ]]; then
		echo "${YELLOW}$hostname : ${END}"
		docker exec $c_id sh -c "ip a | grep eth1 | grep inet | cut -d ' ' -f 6"
		docker exec $c_id sh -c "ip a | grep eth0 | grep inet | cut -d ' ' -f 6"
	elif [[ $hostname == "router_lsirigna-3" ]]; then
		echo "${YELLOW}$hostname : ${END}"
		docker exec $c_id sh -c "ip a | grep eth1 | grep inet | cut -d ' ' -f 6"
		docker exec $c_id sh -c "ip a | grep eth0 | grep inet | cut -d ' ' -f 6"
	fi
done
