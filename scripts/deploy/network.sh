#!/bin/bash
# Script para inspeccionar la red Docker especificada a través de docker-compose.
# Extrae el nombre de la red y los contenedores asociados, mostrando los resultados en formato JSON.
# Dependencias: jq

#docker network ls

DEFAULT_NETWORK=kong-net
NETWORK=${1:-$DEFAULT_NETWORK}
docker network inspect ${NETWORK} | jq '{"Network": .[].Name ,"Containers": .[].Containers}'
