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

COMMAND=$1
case $COMMAND in
    build)
        echo "Construyedo las imagenes..."
        build_images && list_images
        ;;
    push)
        echo "Empujando las imagenes..."
        push_images
        ;;
    list)
        echo "Mostrando las imagenes..."
        list_images
        ;;
    *)
        echo "Comando no reconocido"
        ;;
esac