#!/bin/bash
# Construye una imagen docker y la agrega a un registry para almacenar la imagen generada.

WORKDIR=$(dirname $0)
# export $(grep -v "^#" $WORKDIR/.env | xargs)

# Cargar Configuración
source ${WORKDIR}/config.sh  # O . config.env

TAGS=("1.0.0" "latest")

function print_env_config(){
  # Usar variables
  echo "Iniciando $APP_NAME en entorno $APP_ENV..."
  echo "Nivel de log: $LOG_LEVEL"
  echo "Escuchando en el puerto: $PORT"

  echo
  echo "Image name: ${IMAGE_NAME}"
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

echo
print_env_config
echo
./mvnw clean package && build_images && push_images && list_images
# Puedes declarar una estructura donde se guarden los pasos ejecutados 
# con exito y compararlo con una referencia para ver si es necesario volver a ejecutarlo