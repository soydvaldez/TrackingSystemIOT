#!/bin/bash
# scripts de pruebas para asegurar que los servicios esten en linea

if [ -f "config/.env" ]; then
  set -a
  source config/.env
  set +a
else
  echo "Archivo config/.env no encontrado"
fi

TOKEN_FILE="./token.json"

function generate_token(){
    curl -X POST ${OAUTH2_SERVER}/realms/${KEYCLOAK_REALM}/protocol/openid-connect/token \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -d "grant_type=client_credentials" \
    -d "client_id=${CLIENT_ID}" \
    -d "client_secret=${CLIENT_SECRET}"
}

function validate_token_server() {
    curl -X POST ${OAUTH2_SERVER}/realms/${KEYCLOAK_REALM}/protocol/openid-connect/token/introspect \
    -d "token=$TOKEN" \
    -d "client_id=${CLIENT_ID}" \
    -d "client_secret=${CLIENT_SECRET}"
}

function validate_token() {
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
        # echo "$token"
        echo "token generado"
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
#   echo "$token"
}

function get_token(){
    validate_token && cat $TOKEN_FILE | jq
}

# Entrypoint
case "$1" in
  get_token)
    shift
    get_token "$@"
    ;;
  validate)
    shift
    validate_token "$@"
    ;;
  *)
    show_help
    ;;
esac