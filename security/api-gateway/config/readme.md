# Configuración del Ambiente

Esta carpeta contiene los archivos necesarios para definir variables de entorno utilizadas por la aplicación y sus servicios asociados, tales como el API Gateway (Kong), Keycloak y la infraestructura de base de datos.

---

## Archivo: `.env`

Contiene secretos y configuraciones sensibles utilizadas en la autenticación y comunicación con servicios externos.

- `OAUTH2_SERVER`: URL del servidor OAuth2 (por ejemplo, Keycloak) utilizado para autenticación y emisión de tokens.
- `KEYCLOAK_REALM`: Nombre del *realm* configurado en Keycloak, utilizado para gestionar dominios de autenticación y autorización de manera aislada.
- `CLIENT_ID`: Identificador único del cliente registrado en Keycloak que solicita tokens de acceso.
- `CLIENT_SECRET`: Clave secreta asociada al `CLIENT_ID`, utilizada para autenticar el cliente y obtener tokens de acceso mediante el flujo OAuth2.

---

## Archivo: `.docker-compose.env`

Contiene las variables de entorno requeridas para definir el comportamiento de los servicios durante la ejecución de Docker Compose. Las variables están agrupadas por servicio para facilitar su mantenimiento.

### Servicio: `kong-db` (Infraestructura de base de datos)

Define las credenciales del servidor de base de datos PostgreSQL que Kong utilizará para almacenar su configuración (modo con base de datos activada).

- `POSTGRES_USER`: Usuario administrador de la base de datos.
- `POSTGRES_PASSWORD`: Contraseña asociada al usuario administrador.

---

### Servicio: `kong` (API Gateway)

Define las variables necesarias para que Kong se conecte a la base de datos y funcione como pasarela de servicios.

- `KONG_DATABASE`: Tipo de almacenamiento utilizado por Kong. Puede ser `postgres` o `off` (modo sin base de datos).
- `KONG_PG_HOST`: Host donde se encuentra el servidor de base de datos de Kong (normalmente el servicio `kong-db`).
- `KONG_PG_USER`: Usuario con permisos para acceder a la base de datos de Kong.
- `KONG_PG_PASSWORD`: Contraseña del usuario de base de datos.

---

### Servicio: `kong-migration` (Utilidad para inicializar la base de datos)

Define las credenciales utilizadas por el contenedor de migración para inicializar y preparar el esquema de la base de datos de Kong.

- `KONG_DATABASE`: Tipo de base de datos usada (`postgres`).
- `KONG_PG_HOST`: Host de la base de datos donde se aplicarán las migraciones.
- `KONG_PG_DATABASE`: Nombre de la base de datos donde se ejecutarán los scripts de migración.
- `KONG_PG_USER`: Usuario autorizado para realizar migraciones.
- `KONG_PG_PASSWORD`: Contraseña del usuario de migración.

---

> ⚠️ **Importante**: Estos archivos contienen credenciales sensibles y no deben ser versionados ni compartidos públicamente. Asegúrate de agregarlos al archivo `.gitignore` para evitar filtraciones accidentales.
