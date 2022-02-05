#!/bin/bash
# reconnect wireguard site2site VPN

INTERFACE=$1
PEER_KEY=$2
PEER_IP=$3
ENDPOINT=$4
PORT=$5

wg show ${INTERFACE}
if /bin/ping -c 1 ${PEER_IP} &> /dev/null
then
        echo "solid connection to ${ENDPOINT}"
else
        echo "endpoint ${ENDPOINT}:${PORT} will be reconnected"
        wg set ${INTERFACE} peer ${PEER_KEY} endpoint ${ENDPOINT}:${PORT}
        wg show ${INTERFACE}
fi
