#!/bin/bash
#Funciones utilitarias: fechas con hora
# echo
# echo "Utilerias cargadas"
# echo

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

function test() {
    echo "Utilerias cargadas"
    echo
}

COMMAND=$1

case $COMMAND in
    test)
        echo "Ejecutando tests..."
        test
        ;;
    build)
        echo "Compilando proyecto..."
        ;;
    deploy)
        echo "Desplegando..."
        ;;
    *)
        echo "Comando no reconocido"
        ;;
esac

# Utileria para imprimir mensajes en la consola