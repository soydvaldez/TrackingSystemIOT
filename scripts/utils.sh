#!/bin/bash
#Funciones utilitarias: fechas con hora

# Obtiene la ruta absoluta del directorio donde se encuentra el script
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
# echo "SCRIPT_DIR     $SCRIPT_DIR/utils.sh"

echo
echo "Utilerias cargadas"
echo

function getCurrentDatetimeInSeconds() {
  date -j -f "%Y-%m-%dT%H:%M:%S" "$(get_current_datetime)" +%s
}

# Convertir fechas y horas a segundos desde la época Unix en macOS
function getCurrentDatetime() {
  date +"%Y-%m-%dT%H:%M:%S"
}

function toLowerCase() {
    tr [:upper:] [:lower:]
}

function toUpperCase() {
    tr [:lower:] [:upper:]
}


function generate_random_number() {
  # Rango de valores aleatorios a generar
  MIN=1; MAX=70
  echo $((MIN + RANDOM % (MAX - MIN + 1)))
}

# Utileria para imprimir mensajes en la consola
