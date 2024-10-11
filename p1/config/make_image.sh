#!/bin/bash

docker build -t host_lsirigna -f host_image .
docker build -t router_lsirigna -f router_image .

