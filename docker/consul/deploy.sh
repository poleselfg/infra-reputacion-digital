#!/bin/sh

DIRNAME=$(dirname $0)
SCRIPT_PATH=$(cd ${DIRNAME}; pwd)
NETWORK_NAME=consul
docker network ls --format='{{ .Name }}' \
    | grep -q "^${NETWORK_NAME}$" || docker network create --attachable --driver overlay ${NETWORK_NAME}

# we need a shared mount
SHARED_VOLUME=/mnt/consul/data
test -d ${SHARED_VOLUME} || mkdir -p ${SHARED_VOLUME}

# deploy consul stack
docker stack deploy -c ${SCRIPT_PATH}/docker-compose.yml consul