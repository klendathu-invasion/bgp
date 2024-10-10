#!/bin/bash

END='\033[0m'
RED='\033[1;91m'
GREEN='\033[1;92m'
YELLOW='\033[1;93m'

echo -e 'ETH1'
ip a | grep eth1 -A 1 | grep -e inet -e link | sed -e 's/  */ /g' | cut -d ' ' -f 3 | tr '\012' ' ' | awk '{print "${RED}MAC ADDRESS :\t${END}" $1 "${RED}\tIP ADDRESS :\t${END}" $2}'
