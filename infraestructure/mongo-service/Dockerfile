FROM mongo:latest

# Copiar la configuración en la ubicación correcta
COPY ./config/mongod.conf /etc/mongod.conf

# Copiar scripts de inicialización
COPY ./config/init.js /docker-entrypoint-initdb.d/init.js

# Exponer el puerto de MongoDB
EXPOSE 27017

# Comando para iniciar Mongo con el archivo de configuración
CMD ["mongod"]
