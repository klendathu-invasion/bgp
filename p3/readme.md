
# **P3**

**BGP (Border Gateway Protocol)** est le principal protocole supportant l'Internet et est utilisé pour synchroniser les informations de routage entre les périphériques du réseau.

**L'EVPN** est une extension de **BGP**, qui fournit principalement un acheminement à voies multiples par le biais du modèle de multihébergement. Sa redondance permet à un dispositif de se connecter à deux ou plusieurs dispositifs en amont et d'utiliser tous les liens pour la transmission du trafic.

**MAC address :** identifiant unique d'un periphérique réseau

**réflection de route :** principe de partage des routes entres les routeurs


## configuration

**Nous allons créer un réseau comprenants 3 leafs et 1 spine.**

Les leafs (ou VTEP) sont les sorties de notre réseaux
La spine est notre "tige", qui relies toutes les leafs.

On va utiliser OSPF (protocole de determination du meilleur chemin), même si dans le diagramme présent, il ne sera pas très utile puisqu'il n'y a qu'un seul chemin possible à chaque fois.



1. Nous configurerons les hosts et la vxlan multicast sur les leafs comme dans la P2.
2. Nous allons ajouter une configuration vtysh (shell de frrr)

```
	configure
	no ipv6 forwarding

	# configuration du device eth0
	# appartenant à l'aire 0 du protocole ospf

	interface eth0
	 ip address 10.1.1.2/30
	 ip ospf area 0
	exit


	# configuration du device lo
	# appartenant à l'aire 0 du protocole ospf
	interface lo
	 ip address 1.1.1.2/32
	 ip ospf area 0
	exit

	#configuration du routeur bgp, toutes les leafs ont pour voisin la spine (1.1.1.1)
	router bgp 1
	 neighbor 1.1.1.1 remote-as 1
	 neighbor 1.1.1.1 update-source lo
	 address-family l2vpn evpn
	  neighbor 1.1.1.1 activate
	  advertise-all-vni
	 exit-address-family
	exit

	# lancement du routeur ospf sans configuration
	router ospf
	exit

```

3. Nous allons désormais configurer la spine
```
configure terminal

no ipv6 forwarding


#configuration des 3 ports ethernets

interface eth0
 ip address 10.1.1.1/30
exit

interface eth1
 ip address 10.1.1.5/30
exit

interface eth2
 ip address 10.1.1.9/30
exit

#configuration de la boucle locale

interface lo
 ip address 1.1.1.1/32
exit


# configuration du routeur bgp

# les voisins sont dynamic, et l'update-source se fait sur l'interface lo
# bgp écoute sur la range 1.1.1.0/24 soit de 1.1.1.1 à 1.1.1.254
router bgp 1

 neighbor DYNAMIC peer-group

 neighbor DYNAMIC remote-as 1

 neighbor DYNAMIC update-source lo

 bgp listen range 1.1.1.0/24 peer-group DYNAMIC

 address-family l2vpn evpn
  neighbor DYNAMIC activate
  neighbor DYNAMIC route-reflector-client
 exit-address-family
exit


# configuration du routeur ospf sur l'aire 0
router ospf
 network 0.0.0.0/0 area 0
exit
```

## Verfier les routes et les devices

Le Shell `vtysh` permet également d'obtenir des informations intéressantes sur les routeurs :
```
	do sh ip route
	do sh bgp summary
	do sh bgp l2vpn evpn
```
Pour voir les détails des interfaces réseaux :
	`ip a`

## vérifier le liens entre les hosts

Nous pouvons désormais ping de l'un vers l'autre.

`ping 30.1.1.2`
