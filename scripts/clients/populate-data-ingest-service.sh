#!/bin/zsh
#Realiza consultas al microservicio de ingesta para simular lecturas de sensores de temperatura
WORKDIR=$(dirname $0)
echo "WORKDIR     $PWD/$WORKDIR"

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
# echo "SCRIPT_DIR     $SCRIPT_DIR/utils.sh"

source /Users/daniel/Documents/portafolio/tracking-system-io/scripts/utils.sh

if [ -f "$WORKDIR/.env" ]; then
  echo "El archivo: \".env\" ha sido cargado"
  export $(grep -v "^#" $WORKDIR/.env | xargs)
else
    echo "El archivo \".env\" no existe."
fi

TAGS=("1.0.0" "latest")


# Simula y genera una temperatura de un sensor, arma una peticion cURL y manda datos al servidor
function producer_sensor_temperature {
  URL=http://${HOST}/api/v1/ingestdata;
  # JSON=''

  function generate_data {
    local RANDOM_NUMBER=$(generate_random_number)

    local data_to_request='{
      "produced_by":"bash_script",
      "sensorId":"sensor_temp1",
      "timestamp":"'"$(date -u -Iseconds)"'",
      "temperature":"'"${RANDOM_NUMBER}"'",
      "degree": "celsius"
    }'
    echo $data_to_request
  }

  function request_to_server() {
    count=9
    while [ $count -lt 10 ]; do
      JSON=$(generate_data)
      # echo $JSON | jq '.'
      # echo "$URL"
      # sleep 1

      if [[ -n $JSON ]];then 
        response=$(curl -s -i \
        -H "Content-Type: application/json" \
        --data "$JSON" \
        -u user:password -X POST ${URL})
        echo
        echo $response
      else
        echo "valor2"
      fi
      

      ((count++))
    done

    location_resource=$(echo $response | grep -i "^Location:" | awk '{print $2}' | tr -d '\r')

    if [[ "$location_resource" ]]; then
      echo "Realizando peticion al server..."
      curl -u user:password "$location_resource"
    fi
  }

    generate_data && request_to_server
}

producer_sensor_temperature
echo
echo "Finalizo el script!"

