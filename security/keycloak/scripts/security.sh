# Generar un token
TOKEN_FILE="./token.json"

# set -eou pipefail

if [ -f "config/.env" ]; then
  set -a
  source config/.env
  set +a
else
  echo "Archivo config/.env no encontrado"
fi

# Asigancion de valores por defecto, variables de entorno:
OAUTH2_SERVER=${OAUTH2_SERVER:-"http://localhost:8080"}
API_GATEWAY_SERVER=${API_GATEWAY_SERVER:-"http://localhost:8000"}
API_GATEWAY_ADMIN_SERVER=${API_GATEWAY_ADMIN_SERVER:-"http://localhost:8001"}
CLIENT_ID=${CLIENT_ID:-"client_id"}
CLIENT_SECRET=${CLIENT_SECRET:-"client_secret"}


cleanup() {
  echo "Limpiando token"
  [[ -f "$TOKEN_FILE" ]] && rm -f "$TOKEN_FILE"
}

trap cleanup EXIT

function generate_token(){
    curl -X POST ${OAUTH2_SERVER}/realms/my-realm/protocol/openid-connect/token \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -d "grant_type=client_credentials" \
    -d "client_id=${CLIENT_ID}" \
    -d "client_secret=${CLIENT_SECRET}"
}

function validate_server_token() {
    curl -X POST ${OAUTH2_SERVER}/realms/my-realm/protocol/openid-connect/token/introspect \
    -d "token=$token" \
    -d "client_id=${CLIENT_ID}" \
    -d "client_secret=${CLIENT_SECRET}"
}


function validate_local_token() {
  local current_time
  current_time=$(date +%s)

  # Si el token existe, verificar expiración
  if [[ -f "$TOKEN_FILE" ]]; then
    local token
    local expires_in
    local created_at
    local expiration_time

    token=$(jq -r '.access_token' "$TOKEN_FILE")

    expires_in=$(jq -r '.expires_in' "$TOKEN_FILE")
    created_at=$(jq -r '.created_at' "$TOKEN_FILE")
    expiration_time=$((created_at + expires_in))

    if (( current_time < expiration_time )); then
        echo "$token"
      return
    fi
  fi

  # Si no hay token válido, obtener uno nuevo
  local response
  response=$(generate_token)

  local token
  token=$(echo "$response" | jq -r '.access_token')
  local expires_in
  expires_in=$(echo "$response" | jq -r '.expires_in')

  # Guardar token junto con el timestamp actual
  echo "$response" | jq --arg created_at "$current_time" \
    '. + {created_at: ($created_at | tonumber)}' > "$TOKEN_FILE"

  # Asegurar permisos del archivo (solo lectura/escritura para el usuario)
  chmod 600 "$TOKEN_FILE"
  echo "$token"
}

function test_service_A() {
    print_env
    validate_local_token
    echo
    local token=$(jq -r '.access_token' < "$TOKEN_FILE")

    # local URI="http://192.168.1.66:8000/api/v1/sensors"
    URL="${API_GATEWAY_SERVER}/api/v1/sensors"
    
    curl -s -H "Authorization: Bearer $token" \
         -X GET --url "$URL" | jq
}


function print_env(){
  config_env='{
    "OAUTH2_SERVER": "'"${OAUTH2_SERVER}"'",
    "API_GATEWAY_SERVER": "'"${API_GATEWAY_SERVER}"'",
    "API_GATEWAY_ADMIN_SERVER": "'"${API_GATEWAY_ADMIN_SERVER}"'",
    "SERVICES_A_URI": "'"${SERVICES_A_URI}"'",
    "URL":"'"${API_GATEWAY_SERVER}/${SERVICES_A_URI}"'"
  }'
 
  echo $config_env | jq
}

function print_api_gateway(){  
  echo "${API_GATEWAY_ADMIN_SERVER}/nodes"
  curl -X GET ${API_GATEWAY_ADMIN_SERVER} | jq '.configuration'
}