# Secured HTTPS communications: -p 8443:8443 
# Health check point: -p 9000:9000 
# Not secured HTTP commmunications: -p 8080:8080 

WORKDIR=$(dirname $0)
# export $(grep -v "^#" $WORKDIR/.env | xargs)
source ${WORKDIR}/config.sh  # O . config.env

echo "TAGS: [${TAGS[@]}]"

function print_env_properties(){
  echo "Valores del ambiente"
  echo "SERVICE_NAME ${SERVICE_NAME}"
  echo
  echo "KC_HOSTNAME_URL: $KC_HOSTNAME_URL"
}


function build_image() {
  echo "Construyendo Imagen"
  docker build \
   -t localhost:5000/"${IMAGE}":${TAGS[0]} \
   -t localhost:5000/"${IMAGE}":${TAGS[1]} .
}


function deploy() {
  docker run --name=keycloak-service \
    --network=kong-net \
    --ip=172.21.0.15 \
    -p 9000:9000 \
    -p 8080:8080 \
    -e KEYCLOAK_ADMIN=admin \
    -e KEYCLOAK_ADMIN_PASSWORD=admin \
    -e KC_DB=postgres \
    -e KC_DB_URL=$KC_DB_URL \
    -e KC_DB_USERNAME=$KC_DB_USERNAME \
    -e KC_DB_PASSWORD=$KC_DB_PASSWORD \
    -e KC_HOSTNAME=$KC_HOSTNAME \
    -e KC_HOSTNAME_URL="http://192.168.1.68/auth" \
    -e KC_PROXY=edge \
    --rm -d \
    localhost:5000/keycloak-img:lastest start-dev
    #--hostname=localhost
    # -e KC_HTTP_RELATIVE_PATH=/auth \
    # -e KC_HOSTNAME_URL=$KC_HOSTNAME_URL \
}

print_env_properties
build_image
sleep 1
#deploy


# http://192.168.1.68/auth/admin/master/console/
