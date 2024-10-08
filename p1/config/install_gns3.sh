#!/bin/bash

sudo apt-get update
sudo apt-get install -y python3 python3-pip python3-pyqt5 qemu-kvm qemu-utils libvirt-clients libvirt-daemon-system virtinst bridge-utils
sudo add-apt-repository ppa:gns3/ppa
sudo apt-get update
sudo apt-get install -y gns3-gui gns3-server
sudo usermod -aG ubridge $USER
sudo usermod -aG libvirt $USER
sudo usermod -aG wireshark $USER
newgrp ubridge
newgrp libvirt
newgrp wireshark
sudo apt-get install -y docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
newgrp docker
bash make_image.sh
