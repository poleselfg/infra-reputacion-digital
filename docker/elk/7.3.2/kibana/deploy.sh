####### REQUIREMENTS FOR DEPLOYING THIS STACK ########
#
# deploy elasticsearch-coordinator first.
#
#!/bin/sh

DIRNAME=$(dirname $0)
SCRIPT_PATH=$(cd ${DIRNAME}; pwd)

LABEL=kibana_node
LABEL_VALUE=yes
NODE=kibana.reputacion.digital

# Adds kibana node label
docker node inspect ${NODE} --format "{{.Spec.Labels.kibana_node}}" \
    | grep -q "^${LABEL_VALUE}$" || docker node update ${NODE} --label-add "${LABEL}=${LABEL_VALUE}"

# deploy consul stack
docker stack deploy -c ${SCRIPT_PATH}/docker-compose.yml kibana --with-registry-auth
