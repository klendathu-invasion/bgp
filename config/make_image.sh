#!/bin/bash

docker build -t host_lsirign -f host_image .
docker build -t router_lsirign -f router_image .


docker build -t host_ael-kadh -f host_image .
docker build -t router_ael-kadh -f router_image .

docker build -t host_smarie-c -f host_image .
docker build -t router_smarie-c -f router_image .