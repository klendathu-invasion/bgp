
# **P2**


**Pour cet exercice, nous devons créer une VXLAN qui englobera les routeurs 1 et 2**

VXLAN est un protocole de tunneling IP standard permettant d'étendre les VLAN dans un réseau. Il relie les VLAN d'un bout à l'autre du réseau sans tunneling, ce qui permet des capacités de multi-tenant et de mise à l'échelle non disponibles dans les réseaux 802.1q/VLAN traditionnels.

## unicast

Dans un premier temps, nous créerons un VXLAN unicast, donc du routeur 1 au routeur 2 et inversement (mais qu'entre 1 et 2)

Pour ce faire, nous utilisons la commande

`ip link add name vxlan10 type vxlan id 10 local 10.1.1.1 remote 10.1.1.2 dstport 4789 dev eth0`
(ici le vxlan est monté sur eth0)

sur le routeur 1, en inversant les ip local et remote pour le routeur 2.

Nous ajoutons ensuite un bridge, qui nous permet de lier les autres ports de chaque routeur avec la vxlan.

Création du bridge
`ip link add br0 type bridge`

up le bridge
`ip link set dev br0 up`

ajouter l'interface eth1 à br0
`brctl addif br0 eth1`

ajouter l'interface vxlan10 à br0
`brctl addif br0 vxlan10`



en fixant une ip à nos deux hosts :
`ip addr add 30.1.1.1/24 dev eth1`

Nous pouvons désormais ping de l'un vers l'autre.

`ping 30.1.1.2`



## multicast
**Nous allons recommencer pour créer un VXLAN en dynamic multicast (donc acceptant plusieurs routeurs au lieu de 2)**

Nous modifions la commande de création d'une vxlan par :

`ip link add name vxlan10 type vxlan id 10 dev eth0 group 225.1.1.1 dstport 4789`

Au lieu de fixer une ip locale et une remote, nous ajoutons un group, sur chacun des routeurs qui appartiendront à ce groupe. (attention la plage réservée pour les groupes est : 224.0.0.0 à 239.255.255.255)


Pour voir les détails des interfaces réseaux :
	`ip a`
