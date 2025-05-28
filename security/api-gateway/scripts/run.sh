#!/bin/bash
# Espacio de preparación: asignación de secrets y variables de entorno para docker-compose

# Cargar variables del archivo .env si existe
if [ -f "config/.docker-compose.env" ]; then
  set -a
  source config/.docker-compose.env
  set +a
  echo "Archivo "'"config/.docker-compose.env"'" ha sido leído."
else
  echo "Archivo "'"config/.docker-compose.env"'" no encontrado"
fi


# kong-db service
: "${POSTGRES_USER:=kong}"
: "${POSTGRES_PASSWORD:=kong}"

export POSTGRES_USER
export POSTGRES_PASSWORD

# Asigna secretos en variables para el servicio: kong-migration
: "${KONG_DATABASE:=postgres}"
: "${KONG_PG_HOST:=kong-db}"
: "${KONG_PG_DATABASE:=kong}"
: "${KONG_PG_USER:=kong}"
: "${KONG_PG_PASSWORD:=kong}"

# exporta los secretos en variables de entorno para el servicio: kong-migration
export KONG_DATABASE
export KONG_PG_HOST
export KONG_PG_DATABASE
export KONG_PG_USER
export KONG_PG_PASSWORD


# kong service
: "${KONG_DATABASE:=postgres}"
: "${KONG_PG_HOST:=kong-db}"
: "${KONG_PG_USER:=kong}"
: "${KONG_PG_PASSWORD:=kong}"

export KONG_DATABASE
export KONG_PG_HOST
export KONG_PG_USER
export KONG_PG_PASSWORD

function print_env(){
    echo "'"kong-db service"'"
    echo $POSTGRES_USER
    echo 
    echo "'"kong-gateway service"'"
    echo $KONG_DATABASE
    echo $KONG_PG_HOST
}

function up(){
  docker-compose -f docker-compose.api-gateway.yml up --build -d
}

function down(){
  docker-compose -f docker-compose.api-gateway.yml down --volumes
}

# print_env
down
up