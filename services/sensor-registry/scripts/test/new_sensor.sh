#!/bin/bash
#Script para dar de alta un nuevo sensor
# Cargando Ambiente
WORKDIR=$(dirname $0)
# export $(grep -v "^#" $WORKDIR/.env | xargs)

source scripts/utils.sh

echo "=================================================="
echo "           $(echo parametros | toUpperCase)       "
echo "Tarea: Registra un Nuevo Sensor en la aplicacion  "
echo "WORKDIR: $WORKDIR/"
echo "Script: $WORKDIR/new_sensor.sh"
echo "Target: localhost:8002/api/v1/sensors"
echo "=================================================="

# Registra un nuevo sensor:
function add_new_sensor() {
    curl -s -X POST -H 'Content-Type: application/json' \
    -d '{
        "sensorName": "DHT22",
        "location": "Room 1"
    }' \
    localhost:8002/api/v1/sensors | jq '.'
}

case "$1" in
    "add_new_sensor")
        add_new_sensor
        ;;
    "list_sensors")
        list_sensors
        ;;
    *) # Por defecto estara activo el sensor
       # El online sera el que se tendra que determinar con reglas de negocio
       add_new_sensor
        ;;
esac