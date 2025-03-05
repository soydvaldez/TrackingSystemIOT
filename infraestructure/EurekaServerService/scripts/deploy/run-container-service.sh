#!/bin/bash
#Levantar el microservicio en un contenedor docker

WORKDIR=$(dirname $0)
# export $(grep -v "^#" $WORKDIR/.env | xargs)
source ${WORKDIR}/config.sh  # O . config.env

function print_env_config(){
  # Usar variables
  echo "Iniciando $APP_NAME_SERVICE en entorno $APP_ENV..."
  echo "Nivel de log: $LOG_LEVEL"
  echo "Escuchando en el puerto: $PORT"

  echo
  echo "Image name: ${IMAGE_NAME}"
}


function deploy-container() {
    docker run --rm \
      --name ${APP_NAME_SERVICE} \
      --network ${NETWORK_DOCKER} \
      -p 8761:8761 \
      -e SERVER_PORT=8761 \
      localhost:5000/eureka-server-image:1.0.0
}


echo "Levantando el contenedor: $IMAGE_NAME"
echo
print_env_config
deploy-container
# run-container

