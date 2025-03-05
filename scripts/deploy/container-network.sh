
DEFAULT_CONTAINER=kong
CONTAINER=${1:-$DEFAULT_CONTAINER}
docker inspect ${CONTAINER} | jq '{Name: "'"${CONTAINER}"'", Ports:.[].NetworkSettings.Ports}'