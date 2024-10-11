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
		docker exec $c_id sh -c "ip link add name br0 type bridge" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
		docker exec $c_id sh -c "ip link set up dev br0" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
		docker exec $c_id sh -c "ip link add name vxlan10 type vxlan id 10 dstport 4789" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
		docker exec $c_id sh -c "ip link set dev vxlan10 master br0" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
		docker exec $c_id sh -c "ip link set up dev vxlan10" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
		docker exec $c_id sh -c "ip link set dev eth1 master br0" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"


		docker cp ./vtysh/router_1.vtysh $c_id:/vtysh.conf && echo -e "COPY VTYSH CONFIGURATION : ${GREEN}OK${END}" || echo -e "COPY VTYSH CONFIGURATION : ${RED}KO${END}"
		docker exec $c_id ash -c "cat vtysh.conf | vtysh" && echo -e "VTYSH CONFIGURATION LOADED : ${GREEN}OK${END}" || echo -e "VTYSH CONFIGURATION LOADED  : ${RED}KO${END}"
	elif [[ $hostname == "router_lsirigna-2" ]]; then
		docker exec $c_id sh -c "ip link add name br0 type bridge" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
		docker exec $c_id sh -c "ip link set up dev br0" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
		docker exec $c_id sh -c "ip link add name vxlan10 type vxlan id 10 dstport 4789" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
		docker exec $c_id sh -c "ip link set dev vxlan10 master br0" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
		docker exec $c_id sh -c "ip link set up dev vxlan10" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
		docker exec $c_id sh -c "ip link set dev eth1 master br0" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"


		docker cp ./vtysh/router_2.vtysh $c_id:/vtysh.conf && echo -e "COPY VTYSH CONFIGURATION : ${GREEN}OK${END}" || echo -e "COPY VTYSH CONFIGURATION : ${RED}KO${END}"
		docker exec $c_id ash -c "cat vtysh.conf | vtysh" && echo -e "VTYSH CONFIGURATION LOADED : ${GREEN}OK${END}" || echo -e "VTYSH CONFIGURATION LOADED  : ${RED}KO${END}"
	elif [[ $hostname == "router_lsirigna-3" ]]; then

		docker exec $c_id sh -c "ip link add name br0 type bridge" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
		docker exec $c_id sh -c "ip link set up dev br0" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
		docker exec $c_id sh -c "ip link add name vxlan10 type vxlan id 10 dstport 4789" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
		docker exec $c_id sh -c "ip link set dev vxlan10 master br0" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
		docker exec $c_id sh -c "ip link set up dev vxlan10" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"
		docker exec $c_id sh -c "ip link set dev eth1 master br0" && echo -e "${GREEN}OK${END}" || echo -e "${RED}KO${END}"

		docker cp ./vtysh/router_3.vtysh $c_id:/vtysh.conf && echo -e "COPY VTYSH CONFIGURATION : ${GREEN}OK${END}" || echo -e "COPY VTYSH CONFIGURATION : ${RED}KO${END}"
		docker exec $c_id ash -c "cat vtysh.conf | vtysh" && echo -e "VTYSH CONFIGURATION LOADED : ${GREEN}OK${END}" || echo -e "VTYSH CONFIGURATION LOADED  : ${RED}KO${END}"
	elif [[ $hostname == "router_lsirigna-4" ]]; then
		docker cp ./vtysh/router_spine.vtysh $c_id:/vtysh.conf && echo -e "COPY VTYSH CONFIGURATION : ${GREEN}OK${END}" || echo -e "COPY VTYSH CONFIGURATION : ${RED}KO${END}"
		docker exec $c_id ash -c "cat vtysh.conf | vtysh" && echo -e "VTYSH CONFIGURATION LOADED : ${GREEN}OK${END}" || echo -e "VTYSH CONFIGURATION LOADED  : ${RED}KO${END}"
	fi
done
