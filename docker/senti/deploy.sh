####### REQUIREMENTS FOR DEPLOYING THIS STACK ########
#
# . node tagged with 'mongodb_node=mongodb01'
# . node tagged with 'senti=yes'
# . traefik network created
# . create directory /opt/mongodb
#
#!/bin/sh

DIRNAME=$(dirname $0)
SCRIPT_PATH=$(cd ${DIRNAME}; pwd)

SENTI_LABEL=senti
SENTI_LABEL_VALUE=yes

MONGO_LABEL=mongodb_node
MONGO_LABEL_VALUE=mongodb01

NODE=senti.reputacion.digital

docker node inspect ${NODE} --format "{{.Spec.Labels.senti}}" \
    | grep -q "^${SENTI_LABEL_VALUE}$" || docker node update ${NODE} --label-add "${SENTI_LABEL}=${SENTI_LABEL_VALUE}"

docker node inspect ${NODE} --format "{{.Spec.Labels.mongodb_node}}" \
    | grep -q "^${MONGO_LABEL_VALUE}$" || docker node update ${NODE} --label-add "${MONGO_LABEL}=${MONGO_LABEL_VALUE}"


# deploy senti stack
docker stack deploy -c ${SCRIPT_PATH}/docker-compose.yml senti --with-registry-auth
