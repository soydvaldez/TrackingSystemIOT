# Configuración de variables
NAME_SERVICE="keycloak-db"
APP_ENV="default"
LOG_LEVEL="debug"
PORT=5432

# Docker Image Properties
IMAGE_NAME="keycloak-db"

# Images Tags
TAGS=("1.0.0" "latest")

# Docker Network Properties
NETWORK="kong-net"

DATA=/Users/daniel/Documents/portafolio/tracking-system-io/infraestructure/keycloak-service/infra/data