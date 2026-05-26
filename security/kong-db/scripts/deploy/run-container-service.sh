#!/bin/bash
#Levantar el microservicio en un contenedor docker

WORKDIR=$(dirname $0) #Para obtener la ubicacion relativa del script
WORKDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
source ${WORKDIR}/config.sh  # O . config.env

# if docker ps -a --format '{{.Names}}' | grep -q "^${NAME_SERVICE}$"; then 
#   echo "Existe el contenedor" 
# fi

function print_env_config(){
  echo "Nombre del contenedor: $NAME_SERVICE"
  echo "Puerto: $PORT"
  echo "Imagen: localhost:5000/${IMAGE_NAME}:1.0.0"
  echo "Red: ${NETWORK}"  
  echo "Data Dir: ${DATA}"
}


function deploy_container() {
    docker run \
      --name ${NAME_SERVICE} \
      --network ${NETWORK} \
      -p ${PORT} \
      -v ${DATA}:/var/lib/postgresql/data \
      -e PGDATA=/var/lib/postgresql/data \
      -e POSTGRES_USER=${POSTGRES_USER} \
      -e POSTGRES_PASSWORD=${POSTGRES_PASSWORD} \
      -e POSTGRES_DB=${POSTGRES_DB} \
      --rm -d \
      localhost:5000/${IMAGE_NAME}:1.0.0
}

COMMAND=$1
case $COMMAND in
    info) 
        print_env_config
        ;;
    run) 
        deploy_container 
        ;;
    logs) 
        docker logs ${NAME_SERVICE} 
        ;;
    down) 
        docker-compose down 
        ;;
    *)  
        echo "Comando no reconocido"
        ;;
esac

# print_env_config
# sleep 2
# deploy-container