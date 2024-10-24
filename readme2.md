P2/

VXLAN est un protocole de tunneling IP standard permettant d'étendre les VLAN dans un réseau. Il relie les VLAN d'un bout à l'autre du réseau sans tunneling, ce qui permet des capacités de multi-tenant et de mise à l'échelle non disponibles dans les réseaux 802.1q/VLAN traditionnels.
	VLAN = réseau local virtuel
	statique
	dynamique multicast | groupe
	
	VXLAN id 10 ???

Bridge

(commande)
	ip a
	brctl showmacs br0


----
P3/
BGP (Border Gateway Protocol) est le principal protocole supportant l'Internet et est utilisé pour synchroniser les informations de routage entre les périphériques du réseau.

L'EVPN est une extension de BGP, qui fournit principalement un acheminement à voies multiples par le biais du modèle de multihébergement. Sa redondance permet à un dispositif de se connecter à deux ou plusieurs dispositifs en amont et d'utiliser tous les liens pour la transmission du trafic.

MAC address identifiant unique d'un periphérique réseau

On va utiliser la réflection de route : principe de partage des routes entres les routeurs

Leafs et spine
VTEP (sortie d'une vxlan)

On va utiliser OSPF (protocole de determination du meilleur chemin)

(commande)
		do sh ip route
		do sh bgp summary
		do sh bgp l2vpn evpn
