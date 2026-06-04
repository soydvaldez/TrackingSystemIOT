#!/bin/bash
#Genera un wrapper y un JAR

SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
ROOT_PROJECT=$PWD
echo "ROOT_PROJECT: $ROOT_PROJECT"
echo "SCRIPT_DIR     $SCRIPT_DIR"
echo
clear
if [[ -f ./gradlew ]]; then
    echo "Ejecutando instrucciones... generando Gradle Wrapper y archivo JAR"
    gradle wrapper && ./gradlew clean build
fi