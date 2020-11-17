####### REQUIREMENTS FOR DEPLOYING THIS STACK ########
#
# 1. elasticsearch deployed 
#
#!/bin/sh

DIRNAME=$(dirname $0)
SCRIPT_PATH=$(cd ${DIRNAME}; pwd)

mkdir -p /mnt/logstash/pipelines
mkdir -p /mnt/logstash/templates

LABEL=logstash_node
LABEL_VALUE=yes
NODE=logstash.reputacion.digital

# Adds logstash node label
docker node inspect ${NODE} --format "{{.Spec.Labels.logstash_node}}" \
    | grep -q "^${LABEL_VALUE}$" || docker node update ${NODE} --label-add "${LABEL}=${LABEL_VALUE}"

# deploy senti stack
docker stack deploy -c ${SCRIPT_PATH}/docker-compose.yml logstash --with-registry-auth
