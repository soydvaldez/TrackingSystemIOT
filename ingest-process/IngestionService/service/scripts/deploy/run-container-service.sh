#!/bin/bash
#Levantar el microservicio en un contenedor docker

WORKDIR=$(dirname $0)
# export $(grep -v "^#" $WORKDIR/.env | xargs)
source ${WORKDIR}/config.sh  # O . config.env

DEFAULT_ZONE=http://eureka-server-service:8761/eureka/

function print_env_config(){
  # Usar variables
  echo "Iniciando $APP_NAME_SERVICE en entorno $APP_ENV..."
  echo "Nivel de log: $LOG_LEVEL"
  echo "Escuchando en el puerto: $PORT"

  echo
  echo "Image name: ${IMAGE_NAME}"
  echo
  echo "Eureka properties"
  echo "Eureka DEFAULT_ZONE ${DEFAULT_ZONE}"
}


function deploy-container() {
    docker run --rm \
      --name ${APP_NAME_SERVICE} \
      --network ${NETWORK_DOCKER} \
      -p 8761:8761 \
      -e SERVER_PORT=8761 \
      localhost:5000/eureka-server-image:1.0.0
}

function deploy-container() {
    docker run --rm \
      --name sensor-ingest-service \
      --network app-net \
      -p 8000:8080 \
      -e SERVER_PORT=8080 \
      -e SPRING_RABBITMQ_HOST=rabbit_service \
      -e SPRING_RABBITMQ_PORT=5672 \
      -e SPRING_RABBITMQ_USERNAME=guest \
      -e SPRING_RABBITMQ_PASSWORD=guest \
      -e EUREKA_CLIENT_SERVICEURL_DEFAULTZONE=${DEFAULT_ZONE} \
      localhost:5000/sensor-ingest-image:1.0.0
}


echo "Levantando el contenedor: $IMAGE_NAME"
echo
print_env_config
deploy-container

