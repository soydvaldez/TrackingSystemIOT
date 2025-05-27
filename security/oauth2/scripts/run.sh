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

# Asignacion de secretos en variables para el servicio: keycloak-db
: "${PGDATA:=/var/lib/postgresql/data}"
: "${POSTGRES_USER:=postgres}"
: "${POSTGRES_PASSWORD:=postgres}"
: "${POSTGRES_DB:=keycloak}"

export PGDATA
export POSTGRES_USER
export POSTGRES_PASSWORD
export POSTGRES_DB

: "${KEYCLOAK_ADMIN:=admin}"
: "${KEYCLOAK_ADMIN_PASSWORD:=admin}"
: "${KC_DB:=postgres}"
: "${KC_DB_URL:=jdbc:postgresql://keycloak-db:5432/keycloak}"
: "${KC_DB_USERNAME:=postgres}"
: "${KC_DB_PASSWORD:=postgres}"
: "${KC_HOSTNAME:=192.168.1.66}"
: "${KC_HOSTNAME_URL:="http://192.168.1.66/auth"}"
: "${KC_PROXY:=edge}"

export KEYCLOAK_ADMIN
export KEYCLOAK_ADMIN_PASSWORD
export KC_DB
export KC_DB_URL
export KC_DB_USERNAME
export KC_DB_PASSWORD
export KC_HOSTNAME
export KC_HOSTNAME_URL
export KC_PROXY


function print_env(){
  echo "PGDATA: ${PGDATA}"
  echo "POSTGRES_USER: ${POSTGRES_USER}"
  echo "POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}"
  echo "POSTGRES_DB: ${POSTGRES_DB}"
  echo
  echo "KEYCLOAK_ADMIN: ${KEYCLOAK_ADMIN}"
  echo "KEYCLOAK_ADMIN_PASSWORD: ${KEYCLOAK_ADMIN_PASSWORD}"
  echo "KC_DB: ${KC_DB}"
  echo "KC_DB_URL: ${KC_DB_URL}"
  echo "KC_DB_USERNAME: ${KC_DB_USERNAME}"
  echo "KC_DB_PASSWORD: ${KC_DB_PASSWORD}"
  echo "KC_HOSTNAME: ${KC_HOSTNAME}"
  echo "KC_HOSTNAME_URL: ${KC_HOSTNAME_URL}"
  echo "KC_PROXY: ${KC_PROXY}"

}

function up(){
  docker-compose -f docker-compose.oauth.yml up --build -d
}

function down(){
  docker-compose -f docker-compose.oauth.yml down --volumes
}

# print_env
down
up