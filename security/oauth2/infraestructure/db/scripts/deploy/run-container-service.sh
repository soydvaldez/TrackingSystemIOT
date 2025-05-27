#!/bin/bash
#Levantar el microservicio en un contenedor docker

# WORKDIR=$(dirname $0) #Para obtener la ubicacion relativa del script
WORKDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source ${WORKDIR}/config.sh  # O . config.env

# if docker ps -a --format '{{.Names}}' | grep -q "^${NAME_SERVICE}$"; then 
#   echo "Existe el contenedor" 
# fi

function print_env_config(){
  echo "Levantando el contenedor: $NAME_SERVICE"
  echo
  echo "Escuchando en el puerto: $PORT"
  echo "Con la imagen: localhost:5000/${IMAGE_NAME}:1.0.0"
  echo "En la red: ${NETWORK}"
  echo
}


function deploy-container() {
    docker run \
      --name ${NAME_SERVICE} \
      --network ${NETWORK} \
      -p ${PORT} \
      -v ${DATA}:/var/lib/postgresql/data \
      -e PGDATA=/var/lib/postgresql/data \
      -e POSTGRES_USER=postgres \
      -e POSTGRES_PASSWORD=postgres \
      -e POSTGRES_DB=keycloak \
      --rm -d \
      localhost:5000/${IMAGE_NAME}:1.0.0
}


print_env_config
sleep 2
deploy-container