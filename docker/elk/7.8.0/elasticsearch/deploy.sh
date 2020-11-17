#!/bin/sh

DIRNAME=$(dirname $0)
SCRIPT_PATH=$(cd ${DIRNAME}; pwd)

# create dir in nodes mkdir -p /opt/elasticsearch/data
# create dir in nodes mkdir -p /opt/elasticsearch/backup
# Copy the certificate into /mnt/elasticsearch/elastic-certificates.p12
# set sysctl -p vm.max_map_count=262144
NETWORK_NAME=elknet
docker network ls --format='{{ .Name }}' \
    | grep -q "^${NETWORK_NAME}$" || docker network create --attachable --driver overlay ${NETWORK_NAME}

# LABEL key
LABEL=elastic_node

# set labels for elasticsearch1
ES1_LABEL_VALUE=es1
ES1_NODE=elasticsearch1.reputacion.digital
docker node inspect ${ES1_NODE} --format "{{.Spec.Labels.elastic_node}}" \
    | grep -q "^${ES1_LABEL_VALUE}$" || docker node update ${ES1_NODE} --label-add "${LABEL}=${ES1_LABEL_VALUE}"

# set labels for elasticsearch2
ES2_LABEL_VALUE=es2
ES2_NODE=elasticsearch2.reputacion.digital
docker node inspect ${ES2_NODE} --format "{{.Spec.Labels.elastic_node}}" \
    | grep -q "^${ES2_LABEL_VALUE}$" || docker node update ${ES2_NODE} --label-add "${LABEL}=${ES2_LABEL_VALUE}"

# set labels for elasticsearch3
ES3_LABEL_VALUE=es3
ES3_NODE=elasticsearch3.reputacion.digital
docker node inspect ${ES3_NODE} --format "{{.Spec.Labels.elastic_node}}" \
    | grep -q "^${ES3_LABEL_VALUE}$" || docker node update ${ES3_NODE} --label-add "${LABEL}=${ES3_LABEL_VALUE}"

COMPOSE_PREFIX=${SCRIPT_PATH}/docker-compose
# deploy consul stack
docker stack deploy \
    -c ${COMPOSE_PREFIX}.coordinator.yml \
    -c ${COMPOSE_PREFIX}.es1.yml \
    -c ${COMPOSE_PREFIX}.es2.yml \
    -c ${COMPOSE_PREFIX}.es3.yml es --with-registry-auth
