#!/bin/bash

# Obtener la ruta absoluta del script
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
echo $SCRIPT_DIR

function search_path_project() {
  # Buscar la raíz del proyecto subiendo niveles hasta encontrar una carpeta específica
  while [ "$SCRIPT_DIR" != "/" ]; do
      # echo "$SCRIPT_DIR"
      if [ -d "$SCRIPT_DIR/data" ] || [ -d "$SCRIPT_DIR/utils" ]; then
          PROJECT_ROOT="$SCRIPT_DIR"
          break
      fi
      SCRIPT_DIR=$(dirname "$SCRIPT_DIR")  # Subir un nivel
  done
}



search_path_project
# Valida que la variable: ${PROJECT_ROOT} no este vacia

# Exporta el valor al resto de servicio
export PROJECT_ROOT=$PROJECT_ROOT
export DATA=$PROJECT_ROOT/data
