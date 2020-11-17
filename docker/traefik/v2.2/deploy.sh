#!/bin/sh

DIRNAME=$(dirname $0)
SCRIPT_PATH=$(cd ${DIRNAME}; pwd)

NETWORK_NAME=traefik
docker network ls --format='{{ .Name }}' \
    | grep -q "^${NETWORK_NAME}$" || docker network create --attachable --driver overlay ${NETWORK_NAME}

# deploy consul stack
docker stack deploy -c ${SCRIPT_PATH}/docker-compose.yml traefik