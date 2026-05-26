# Configuración de variables
NAME_SERVICE="kong-db"
APP_ENV="default"
LOG_LEVEL="debug"
PORT=5432

# Docker Image Properties
IMAGE_NAME="kong-db"

# Images Tags
TAGS=("1.0.0" "latest")

# Docker Network Properties
NETWORK="kong-net"

DATA=data


# DB CONNECTION PROPERTIES
POSTGRES_USER=kong
POSTGRES_PASSWORD=kong
POSTGRES_DB=kong