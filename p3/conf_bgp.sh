#!/bin/bash

END='\033[0m'
RED='\033[1;91m'
GREEN='\033[1;92m'

containers=$(docker ps -q)
for c_id in ${containers[@]}; do
	hostname=$(docker exec $c_id hostname)
	if [[ $hostname == "host_lsirigna-1" ]]; then
		docker exec $c_id sh -c "ip addr add 30.1.1.1/24 dev eth1" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
	elif [[ $hostname == "host_lsirigna-2" ]]; then
		docker exec $c_id sh -c "ip addr add 30.1.1.2/24 dev eth1" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
	elif [[ $hostname == "host_lsirigna-3" ]]; then
		docker exec $c_id sh -c "ip addr add 30.1.1.3/24 dev eth1" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
	elif [[ $hostname == "router_lsirigna-1" ]]; then
		docker exec $c_id sh -c "ip addr add 10.1.1.1/24 dev eth0" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
		docker exec $c_id sh -c "ip link add name vxlan10 type vxlan id 10 dev eth0 group 225.1.1.1 dstport 4789" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
		docker exec $c_id sh -c "ip link set dev vxlan10 up" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
		docker exec $c_id sh -c "ip link add br0 type bridge" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
		docker exec $c_id sh -c "ip link set dev br0 up" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
		docker exec $c_id sh -c "brctl addif br0 eth1" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
		docker exec $c_id sh -c "brctl addif br0 vxlan10" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
	elif [[ $hostname == "router_lsirigna-2" ]]; then
		docker exec $c_id sh -c "ip addr add 10.1.1.2/24 dev eth0" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
		docker exec $c_id sh -c "ip link add name vxlan10 type vxlan id 10 dev eth0 group 225.1.1.1 dstport 4789" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
		docker exec $c_id sh -c "ip link set dev vxlan10 up" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
		docker exec $c_id sh -c "ip link add br0 type bridge" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
		docker exec $c_id sh -c "ip link set dev br0 up" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
		docker exec $c_id sh -c "brctl addif br0 eth1" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
		docker exec $c_id sh -c "brctl addif br0 vxlan10" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
	elif [[ $hostname == "router_lsirigna-3" ]]; then
		docker exec $c_id sh -c "ip addr add 10.1.1.3/24 dev eth0" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
		docker exec $c_id sh -c "ip link add name vxlan10 type vxlan id 10 dev eth0 group 225.1.1.1 dstport 4789" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
		docker exec $c_id sh -c "ip link set dev vxlan10 up" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
		docker exec $c_id sh -c "ip link add br0 type bridge" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
		docker exec $c_id sh -c "ip link set dev br0 up" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
		docker exec $c_id sh -c "brctl addif br0 eth1" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
		docker exec $c_id sh -c "brctl addif br0 vxlan10" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
	fi
done
