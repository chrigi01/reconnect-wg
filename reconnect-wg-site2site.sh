#!/bin/bash
# reconnect wireguard site2site VPN

INTERFACE=$1
PEER_KEY=$2
PEER_IP=$3
ENDPOINT=$4
PORT=$5
LOG_FILE=/var/log/reconnect-wg-site2site.log

date > ${LOG_FILE}
wg show ${INTERFACE} >> ${LOG_FILE}
if /bin/ping -c 1 ${PEER_IP} &> /dev/null
then
        echo "solid connection to ${ENDPOINT}" >> ${LOG_FILE}
else
        echo "endpoint ${ENDPOINT}:${PORT} will be reconnected" >> ${LOG_FILE}
        wg set ${INTERFACE} peer ${PEER_KEY} endpoint ${ENDPOINT}:${PORT}
        wg show ${INTERFACE} >> ${LOG_FILE}
fi
