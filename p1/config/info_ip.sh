#!/bin/bash

END='\033[0m'
RED='\033[1;91m'
GREEN='\033[1;92m'
YELLOW='\033[1;93m'





containers=$(docker ps -q)
for c_id in ${containers[@]}; do
	hostname=$(docker exec $c_id hostname)
	if [[ $hostname == $1 ]]; then
		echo -e "${GREEN}${1}${GREEN}"
		echo -e "${YELLOW}MAC ADDRESS : ${END}"
		docker exec $c_id sh -c "ip -o -f link addr show | cut -d ' ' -f 2,14"
		echo -e "${YELLOW}IPV4 ADDRESS${END}"
		docker exec $c_id sh -c "ip -o addr show | grep -v inet6 | cut -d ' ' -f 2,7"
	fi
done