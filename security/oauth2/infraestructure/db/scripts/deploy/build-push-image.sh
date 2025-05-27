#!/bin/bash
#Construye una imagen docker y la agrega a un registry para almacenar la imagen generada.

WORKDIR=$(dirname $0)
# export $(grep -v "^#" $WORKDIR/.env | xargs)
source ${WORKDIR}/config.sh  # O . config.env

function print_env_properties() {
  # Usar variables
  echo "Iniciando $NAME_SERVICE en entorno $APP_ENV"
  echo "Nivel de log: $LOG_LEVEL"
#   echo "Escuchando en el puerto: $PORT"

  echo
  echo "Image Name: ${IMAGE_NAME}"
  echo
  echo "TAGS: [${TAGS[@]}]"
}

function build_images() {
   docker build \
    -t localhost:5000/"${IMAGE_NAME}":${TAGS[0]} \
    -t localhost:5000/"${IMAGE_NAME}":${TAGS[1]} .
}

function push_images() {
    for TAG in "${TAGS[@]}"; do
        docker push localhost:5000/"${IMAGE_NAME}":"${TAG}"
    done
}

function list_images() {
    echo "localhost:5000/"${IMAGE_NAME}":${TAGS[0]}"
    echo "localhost:5000/"${IMAGE_NAME}":${TAGS[1]}"
}

# print_env_properties
# build_images && list_images

# Puedes declarar una estructura donde se guarden los pasos ejecutados con exito y 
# compararlo con una referencia para ver si es necesario volver a ejecutarlo