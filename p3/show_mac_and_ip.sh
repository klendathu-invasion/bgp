#!/bin/bash

END='\033[0m'
RED='\033[1;91m'
GREEN='\033[1;92m'
YELLOW='\033[1;93m'

containers=$(docker ps -q)
for c_id in ${containers[@]}; do
	hostname=$(docker exec $c_id hostname)
	if [[ $hostname == "host_lsirigna-1" ]]; then
		echo -e "${GREEN}$hostname : ${END}"
		docker exec $c_id sh -c " ip a | grep eth1 -A 1 | grep -e inet -e link | sed -e's/  */ /g' | cut -d ' ' -f 3 | tr '\012' ' ' | awk '{print \"${RED}MAC ADDRESS :\t${END}\" $1 \"${RED}\tIP ADDRESS :\t${END}\" $2}'"
	elif [[ $hostname == "host_lsirigna-2" ]]; then
		echo -e "${GREEN}$hostname : ${END}"
		docker exec $c_id sh -c " ip a | grep eth1 -A 1 | grep -e inet -e link | sed -e's/  */ /g' | cut -d ' ' -f 3 | tr '\012' ' ' | awk '{print \"${RED}MAC ADDRESS :\t${END}\" $1 \"${RED}\tIP ADDRESS :\t${END}\" $2}'"
	elif [[ $hostname == "host_lsirigna-3" ]]; then
		echo -e "${GREEN}$hostname : ${END}"
		docker exec $c_id sh -c " ip a | grep eth1 -A 1 | grep -e inet -e link | sed -e's/  */ /g' | cut -d ' ' -f 3 | tr '\012' ' ' | awk '{print \"${RED}MAC ADDRESS :\t${END}\" $1 \"${RED}\tIP ADDRESS :\t${END}\" $2}'"
	elif [[ $hostname == "router_lsirigna-1" ]]; then
		echo -e "${YELLOW}$hostname : ${END}"
		docker exec $c_id sh -c " ip a | grep eth0 -A 1 | grep -e inet -e link | sed -e's/  */ /g' | cut -d ' ' -f 3 | tr '\012' ' ' | awk '{print \"${RED}MAC ADDRESS :\t${END}\" $1 \"${RED}\tIP ADDRESS :\t${END}\" $2}'"
		docker exec $c_id sh -c " ip a | grep eth1 -A 1 | grep -e inet -e link | sed -e's/  */ /g' | cut -d ' ' -f 3 | tr '\012' ' ' | awk '{print \"${RED}MAC ADDRESS :\t${END}\" $1 \"${RED}\tIP ADDRESS :\t${END}\" $2}'"
	elif [[ $hostname == "router_lsirigna-2" ]]; then
		echo -e "${YELLOW}$hostname : ${END}"
		docker exec $c_id sh -c " ip a | grep eth0 -A 1 | grep -e inet -e link | sed -e's/  */ /g' | cut -d ' ' -f 3 | tr '\012' ' ' | awk '{print \"${RED}MAC ADDRESS :\t${END}\" $1 \"${RED}\tIP ADDRESS :\t${END}\" $2}'"
		docker exec $c_id sh -c " ip a | grep eth1 -A 1 | grep -e inet -e link | sed -e's/  */ /g' | cut -d ' ' -f 3 | tr '\012' ' ' | awk '{print \"${RED}MAC ADDRESS :\t${END}\" $1 \"${RED}\tIP ADDRESS :\t${END}\" $2}'"
	elif [[ $hostname == "router_lsirigna-3" ]]; then
		echo -e "${YELLOW}$hostname : ${END}"
		docker exec $c_id sh -c " ip a | grep eth0 -A 1 | grep -e inet -e link | sed -e's/  */ /g' | cut -d ' ' -f 3 | tr '\012' ' ' | awk '{print \"${RED}MAC ADDRESS :\t${END}\" $1 \"${RED}\tIP ADDRESS :\t${END}\" $2}'"
		docker exec $c_id sh -c " ip a | grep eth1 -A 1 | grep -e inet -e link | sed -e's/  */ /g' | cut -d ' ' -f 3 | tr '\012' ' ' | awk '{print \"${RED}MAC ADDRESS :\t${END}\" $1 \"${RED}\tIP ADDRESS :\t${END}\" $2}'"
	fi
done
