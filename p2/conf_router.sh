# Bridge creation on router-1
ip addr add 10.1.1.1/24 dev eth0
ip addr add 30.1.1.3/24 dev eth1
ip link add name vxlan10 type vxlan id 10 local 10.1.1.1 remote 10.1.1.2 dstport 4789 dev eth0
ip link set dev vxlan10 up
ip link add br0 type bridge
ip link set dev br0 up
brctl addif br0 eth1
brctl addif br0 vxlan10

# Bridge creation on router-2
ip addr add 10.1.1.2/24 dev eth0
ip addr add 30.1.1.4/24 dev eth1
ip link add name vxlan10 type vxlan id 10 local 10.1.1.2  remote 10.1.1.1 dstport 4789 dev eth0
ip link set dev vxlan10 up
ip link add br0 type bridge
ip link set dev br0 up
brctl addif br0 eth1
brctl addif br0 vxlan10

#configure host-1
ip addr add 30.1.1.1/24 dev eth1

#configure host-2
ip addr add 30.1.1.2/24 dev eth1

#to show configs
ip -d link show vxlan10
ip addr show eth0
