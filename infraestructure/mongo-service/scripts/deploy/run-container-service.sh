#!/bin/bash
# Levantar el servicio en un contenedor docker
# NOTA: Este tipo de despliegue solo se debe de realizar en entornos de prueba o de desarrollo: las variables de entorno pueden tener datos sensibles.

# Perfilamiento 
# Los perfiles de "desarrollo" y "Produccion" apuntaran a una base de datos ORACLE

# Entorno pruebas o desarrollo: usar "default" levantara una instancia "H2 Database".
# Entorno desarrollo: usar "dev" apuntando a localhost o al servidor de desarrollo.
# Entorno producion: usar "prod" apuntando al servidor de produccion.

WORKDIR=$(dirname $0)
export $(grep -v "^#" $WORKDIR/.env | xargs) \

echo
echo "Datasource URL: \"$\""
echo "Profile active: \"$PROFILES_ACTIVE\""
echo


function mountData() {
  if [[ -d "data" ]]; then
   mkdir data
  fi
}

# Levanta un contenedor: sobreescribe la URI de PostgreSQL y RabbitMQ, variables de entorno.
function run-container() {
  # mountData
  echo "Levantando el contenedor: $IMAGE_NAME"
  echo "params: MONGO_INITDB_ROOT_USERNAME:${MONGO_INITDB_ROOT_USERNAME} MONGO_INITDB_ROOT_PASSWORD=${MONGO_INITDB_ROOT_PASSWORD}"
  echo
  docker run \
    --name "${IMAGE_NAME}" \
    --network app-net \
    -p $PORT:$PORT \
    -e MONGO_INITDB_ROOT_USERNAME=${MONGO_INITDB_ROOT_USERNAME} \
    -e MONGO_INITDB_ROOT_PASSWORD=${MONGO_INITDB_ROOT_PASSWORD} \
    --rm \
    localhost:5000/"${IMAGE_NAME}":1.0.0
}

stop-container() {
  echo "Deteniendo el contenedor: $IMAGE_NAME"
  echo
  container=$(docker container stop ${IMAGE_NAME} && docker rm ${IMAGE_NAME})
  echo "El servicio: ${container} se detuvo"
}

# This ensures the following code only runs when the script is executed directly
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  # echo "This is outside any function."
  # Deploy Container
  run-container
fi

