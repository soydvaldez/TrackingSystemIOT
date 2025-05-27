# Generar un token
TOKEN_FILE="./token.json"

# set -eou pipefail

if [ -f .env ]; then
  set -a
  source .env
  set +a
else
  echo "Archivo .env no encontrado"
fi

# Asigancion de valores por defecto, variables de entorno:
OAUTH2_SERVER=${OAUTH2_SERVER:-"http://localhost:8080"}
API_GATEWAY_SERVER=${API_GATEWAY_SERVER:-"http://localhost:8000"}
API_GATEWAY_ADMIN_SERVER=${API_GATEWAY_ADMIN_SERVER:-"http://localhost:8001"}
CLIENT_ID=${CLIENT_ID:-"client_id"}
CLIENT_SECRET=${CLIENT_SECRET:-"client_secret"}
SECRET=${SECRET:-"secret_value"}


function print_env(){
  config_env='{
    "OAUTH2_SERVER": "'"${OAUTH2_SERVER}"'",
    "API_GATEWAY_SERVER": "'"${API_GATEWAY_SERVER}"'",
    "API_GATEWAY_ADMIN_SERVER": "'"${API_GATEWAY_ADMIN_SERVER}"'",
    "SERVICES_A_URI": "'"${SERVICES_A_URI}"'",
    "URL":"'"${API_GATEWAY_SERVER}/${SERVICES_A_URI}"'",
    "SECRET":"'"${SECRET}"'"
  }'
 
  echo $config_env | jq
}

function test_serviceA(){
  curl -s -X GET --url ${API_GATEWAY_SERVER}/api/v1/sensors
} 

function print_api_gateway(){  
  echo "${API_GATEWAY_ADMIN_SERVER}/nodes"
  curl -X GET ${API_GATEWAY_ADMIN_SERVER} | jq '.configuration'
}

# KONG ADMINISTRACION:
function list_plugins(){
  curl -H "Content-Type: application/json" \
   -d '{"enabled": true}' \
   -X PATCH ${API_GATEWAY_ADMIN_SERVER}/plugins/a7084d8a-6247-485a-85a0-4afc9a7a767c
}

function jwt_plugin(){
  curl -X GET ${API_GATEWAY_ADMIN_SERVER}/plugins/a7084d8a-6247-485a-85a0-4afc9a7a767c
}

# curl -X PATCH http://localhost:8001/plugins/<plugin_id> \
#   -H "Content-Type: application/json" \
#   -d '{"enabled": false}'