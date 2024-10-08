#!/bin/bash

RED="\e[31m"
GREEN="\e[32m"
END="\e[0m"

containers=$(docker ps -q)
for c_id in ${containers[@]}; do
	hostname=$(docker exec $c_id hostname)
	if [[ $hostname == "host_lsirigna-1" ]]; then
		docker exec $c_id sh -c "ip addr add 30.1.1.1/24 dev eth1" && echo "${GREEN}OK${END}" || echo "${RED}KO${END}"
	elif [[ $hostname == "host_lsirigna-2" ]]; then
		docker exec $c_id sh -c "ip addr add 30.1.1.2/24 dev eth1" && echo "${GREEN}OK${END}" || echo "${RED}KO${END}"
	elif [[ $hostname == "router_lsirigna-1" ]]; then
		docker exec $c_id sh -c "ip addr add 10.1.1.1/24 dev eth0" && echo "${GREEN}OK${END}" || echo "${RED}KO${END}"
		docker exec $c_id sh -c "ip addr add 30.1.1.3/24 dev eth1" && echo "${GREEN}OK${END}" || echo "${RED}KO${END}"
		docker exec $c_id sh -c "ip link add name vxlan10 type vxlan id 10 dev eth0 group 40.1.1.1 dstport 4789" && echo "${GREEN}OK${END}" || echo "${RED}KO${END}"
		docker exec $c_id sh -c "ip link set dev vxlan10 up" && echo "${GREEN}OK${END}" || echo "${RED}KO${END}"
		docker exec $c_id sh -c "ip link add br0 type bridge" && echo "${GREEN}OK${END}" || echo "${RED}KO${END}"
		docker exec $c_id sh -c "ip link set dev br0 up" && echo "${GREEN}OK${END}" || echo "${RED}KO${END}"
		docker exec $c_id sh -c "brctl addif br0 eth1" && echo "${GREEN}OK${END}" || echo "${RED}KO${END}"
		docker exec $c_id sh -c "brctl addif br0 vxlan10" && echo "${GREEN}OK${END}" || echo "${RED}KO${END}"
	elif [[ $hostname == "router_lsirigna-2" ]]; then
		docker exec $c_id sh -c "ip addr add 10.1.1.2/24 dev eth0" && echo "${GREEN}OK${END}" || echo "${RED}KO${END}"
		docker exec $c_id sh -c "ip addr add 30.1.1.4/24 dev eth1" && echo "${GREEN}OK${END}" || echo "${RED}KO${END}"
		docker exec $c_id sh -c "ip link add name vxlan10 type vxlan id 10 dev eth0 group 40.1.1.1 dstport 4789" && echo "${GREEN}OK${END}" || echo "${RED}KO${END}"
		docker exec $c_id sh -c "ip link set dev vxlan10 up" && echo "${GREEN}OK${END}" || echo "${RED}KO${END}"
		docker exec $c_id sh -c "ip link add br0 type bridge" && echo "${GREEN}OK${END}" || echo "${RED}KO${END}"
		docker exec $c_id sh -c "ip link set dev br0 up" && echo "${GREEN}OK${END}" || echo "${RED}KO${END}"
		docker exec $c_id sh -c "brctl addif br0 eth1" && echo "${GREEN}OK${END}" || echo "${RED}KO${END}"
		docker exec $c_id sh -c "brctl addif br0 vxlan10" && echo "${GREEN}OK${END}" || echo "${RED}KO${END}"
	fi
done


# Bridge creation on router-1
# ip addr add 10.1.1.1/24 dev eth0
# ip addr add 30.1.1.3/24 dev eth1
# ip link add name vxlan10 type vxlan id 10 local 10.1.1.1 remote 10.1.1.2 dstport 4789 dev eth0
# ip link set dev vxlan10 up
# ip link add br0 type bridge
# ip link set dev br0 up
# brctl addif br0 eth1
# brctl addif br0 vxlan10

# # Bridge creation on router-2
# ip addr add 10.1.1.2/24 dev eth0
# ip addr add 30.1.1.4/24 dev eth1
# ip link add name vxlan10 type vxlan id 10 local 10.1.1.2  remote 10.1.1.1 dstport 4789 dev eth0
# ip link set dev vxlan10 up
# ip link add br0 type bridge
# ip link set dev br0 up
# brctl addif br0 eth1
# brctl addif br0 vxlan10

# #configure host-1
# ip addr add 30.1.1.1/24 dev eth1

# #configure host-2
# ip addr add 30.1.1.2/24 dev eth1

#to show configs
# ip -d link show vxlan10
# ip addr show eth0
