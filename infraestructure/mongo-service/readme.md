# Infraestructura: Mongo-service

Dockerfile: Archivo personalizado que toma como base una imagen basada en la imagen mongo:latest. Usa los archivos: ./config/mongod.conf y ./config/init.js para incializar y configurar la imagen inmutable:

<img src="./assets/code.png" alt="Descripción" width="600">

## Descripcion
Este microservicio es util para encapsular un servidor MongoDB en un contenedor docker. 
- Contiene algunas - configuraciones personalizadas de inicio
- Abre accesos para un rapido despligue

<img src="./assets/structure.png" alt="Descripción" width="300">

- **config/init.js: Script de inicializacion del servidor. Crea dos usuarios en la base de datos:**

- **config/mongod.conf: archivo personalizado para permitir las conexion desde cualquier origen:**

## Inicializacion del servicio

```sh
# Construir la imagen
scripts/deploy/build-push-image.sh
```

```sh
# Desplegar el contenedor
scripts/deploy/run-container-service.sh
```

- Para acceder al contenedor desde **localhost**. Se pueden utilizar un cliente **mongosh**

```bash
mongosh "mongodb://usertest:usertest@localhost:27017/trackingsystem"
```

