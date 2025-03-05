# Tracking System IOT
![Java](https://img.shields.io/badge/Java-ED8B00?style=for-the-badge&logo=java&logoColor=white)
![Spring Boot](https://img.shields.io/badge/Spring_Boot-6DB33F?style=for-the-badge&logo=spring-boot&logoColor=white)
![H2](https://img.shields.io/badge/H2-003545?style=for-the-badge&logo=h2&logoColor=white)
![Maven](https://img.shields.io/badge/Maven-C71A36?style=for-the-badge&logo=apache-maven&logoColor=white)
![Gradle](https://img.shields.io/badge/Gradle-02303A?style=for-the-badge&logo=gradle&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
## Descripción

Este proyecto está diseñado para ingerir y procesar datos masivos de sensores IoT **(Temperatura, GPS, Humedad)**. Cada dato ingerido es procesado y almacenado en un repositorio, facilitando una gestión y análisis eficiente de los datos. 

Este sistema ademas cuenta con soporte para la gestión de sensores (alta, baja, actualización y consulta) a través de una interfaz UI web.

### Architectura
**Orientado a microservicios con enfoque a eventos**

El proyecto está diseñado con una arquitectura orientada a microservicios, con un enfoque basado en eventos. Implementando servicios redundantes para tolerar la carga en la red.

![arquitectura](./assets/architecture.png)

## Tecnologías

## Capa Web 

**Nginx**: utilizado como proxy reverso y como servidor web para archivos estáticos. Encargado de distribuir el trafico en la red entre los servicios redundantes api kong gateway. Y para despachar archivos estáticos.

**Angular**: Como aplicación web para proporcionar interfaces intuitivas para poder gestionar los sensores IoT a través de una UI gráfica.

## Capa Api Gateway 
La capa API Gateway esta conformada por los servicios: kong, kong UI, keycloak y nginx.

**Nginx**: Es utilizado como proxy reverso. Encargado de distribuir el trafico en la red entre los servicios redundantes api kong gateway.

**Kong Api Gateway**: Kong API Gateway funciona como unico punto de acceso a la aplicacion sirviendo como intermediario a los servidores de fondo.

**keycloak**: Es un servidor IAM dedicado para gestionar accesos a través de la validacion de la autenticación y autorización de los clientes que intentan acceder a la aplicación. Esta validación se realiza mediante el alta de usuarios en la aplicacion.

<div style="display:flex; justify-content: center">
  <img src="./assets/api-gateway.png" style="height: 1200px; widht:200px;">
</div>

## Capa de servicios

**Ecosistema Spring**:
  - **Spring Boot** Para crear servicios api REST y gestionar comunicaciones HTTP.
  - **Spring JPA**: Para interactuar con las bases de datos a traves de la abstraccion y mapeo de las tablas y sus atributos en objetos.
  - **Base de datos H2** (para pruebas): Base de datos en memoria para realizar testing y validar tanto entradas como salidas de procesos.

**Mockito & Junit5** (para pruebas): Para generar pruebas, y validar entrada y la salida de procesos a traves del mockeo de dependencias.

**PostgreSQL**: Para almacenar datos relativos a los sensores IoT dados de alta en la aplicación y sus catalogos correspondientes.

**MongoDB**: Para almacenar los datos provenientes de lecturas de los sensores IoT ingeridos de forma masiva por la aplicación.

**Docker y Docker-Compose**: utilizados para probar, construir y desplegar los microservicios en contenedores docker desplegados en la infraestructura de la red docker.

**RabbitMQ**: Utilizado para recibir y enviar mensajes asincronos a traves de la abstracion de un canal de comunicación entre microservicios.

## Para comenzar

### Pre-requisitos

- [Docker Engine](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- [Java 17+ Correto](https://www.oracle.com/java/technologies/javase-downloads.html) (para ejecutar aplicaciones Spring Boot)
- [Servidor PostgreSQL](https://www.postgresql.org/) (para gestionar catálogos de sensores)
- [Servidor MongoDB](https://www.mongodb.com/) (para almacenar datos de los sensores)
- [Servidor RabbitMQ](https://www.rabbitmq.com/) (para el procesamiento de mensajes)

### Instalación
1. **Clona el repositorio:**
```bash
git clone git@192.168.1.174:insighttechio/tracking-system-io.git
```

2. **Navega al proyecto:**
```bash
cd tracking-system-io/
```
3.- **Construye e inicializa los servicios usando Docker-Compose**
```bash
# Levanta los servicios en primer plano
docker-compose up
# Levanta los servicios en segundo plano
docker-compose up -d
```
