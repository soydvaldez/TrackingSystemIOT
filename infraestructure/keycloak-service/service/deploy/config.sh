SERVICE_NAME=keycloak-service

# Docker properties
IMAGE=keycloak-service

TAGS=(1.0.0 lastest)


# Dependencies
SERVICE_DATABASE=keycloak-db

KC_DB_URL=jdbc:postgresql://${SERVICE_DATABASE}:5432/keycloak
KC_DB_USERNAME=postgres 
KC_DB_PASSWORD=postgres 
KC_HOSTNAME=keycloak-service
#KC_HOSTNAME=172.21.0.15
KC_HOSTNAME=192.168.1.68
KC_HOSTNAME_URL="http://192.168.1.68/auth"
