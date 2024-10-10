VXLAN est un protocole de tunneling IP standard permettant d'étendre les VLAN dans un réseau. Il relie les VLAN d'un bout à l'autre du réseau sans tunneling, ce qui permet des capacités de multi-tenant et de mise à l'échelle non disponibles dans les réseaux 802.1q/VLAN traditionnels.

BGP (Border Gateway Protocol) est le principal protocole supportant l'Internet et est utilisé pour synchroniser les informations de routage entre les périphériques du réseau.

L'EVPN est une extension de BGP, qui fournit principalement un acheminement à voies multiples par le biais du modèle de multihébergement. Sa redondance permet à un dispositif de se connecter à deux ou plusieurs dispositifs en amont et d'utiliser tous les liens pour la transmission du trafic.

BRIDGE

RR (route reflection)
leafs (VTEP)

eth = ethernet
lo = loopback (boucle locale / localhost)

VTYSH is a shell for FRR daemons.

ICMP = ?

OSPF = Dans OSPF, chaque routeur établit des relations d'adjacence avec ses voisins immédiats en envoyant des messages hello à intervalle régulier. Chaque routeur communique ensuite la liste des réseaux auxquels il est connecté par des messages Link-state advertisements (LSA) propagés de proche en proche à tous les routeurs du réseau.

UNICAST = communication 1 vers 1
MULTICAST = communication 1 vers groupe
BROADCAST = communication 1 vers tous (si ils sont configuré pour répondre)

GROUPE MULTICAST réservé
	224.0.0.0 à 239.255.255.255

Broadcast réservé
	Si 30.1.1.0/24 alors le 30.1.1.255
	MAC FF-FF-FF-FF-FF-FF

découpage MAC :
	1/ 1 bit : si le bit = 0 alors c’est une adresse unicast, sinon (bit=1) c’est un adresse multicast ou broadcast
	2/ 1 bit : si le bit=0 alors c’est le constructeur qui a défini l’adresse. C’est la fameuse notion de BIA – Burned-in Address. Si le bit=1 alors c’est l’administrateur de votre société qui a défini l’adresse
	3/ 22 bits : OUI : Organization Unit Identifier -> identifiant constructeur
	4/ 24 bits : identifiant unique constructeur
	Total 48 bits, 6 octet, donc 6 hex

découpage des classes
  a/ 0 -> 128
  b/ 128 -> 128+64
  c/ 128+64 -> 128+64+32
  d/ 128+64+32 -> 128+64+32+16
  e/ 128+64+32+16 -> 256

soit
  a/ 0 -> 128
  b/ 128 -> 192
  c/ 192 -> 224
  d/ 224 -> 240
  e/ 240 -> 256


commandes show
	arp -a (mac et ip local)
	ip a (show toutes les interfaces réseaux)


