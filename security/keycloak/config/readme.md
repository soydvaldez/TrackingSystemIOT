# Configuración del Ambiente

Esta carpeta contiene archivos necesarios para configurar variables de entorno utilizadas por la aplicación y sus servicios asociados.

---

## Archivo: `.env`

Contiene los *secrets* y URLs de los servicios necesarios para ejecutar scripts y autenticar servicios externos.

- `OAUTH2_SERVER`: Contiene los datos sensibles como el HOST del servidor OAuth2.
- `KEYCLOAK_REALM`: *Realm* usado en Keycloak para aislar permisos y dominios de autenticación.
- `CLIENT_ID`: Identificador del cliente que solicita la generación de tokens en Keycloak.
- `CLIENT_SECRET`: Clave secreta utilizada junto con el `CLIENT_ID` para autenticación y obtención de tokens de acceso.

---

## Archivo: `.docker-compose.env`

Contiene las variables de entorno necesarias para configurar el contexto de ejecución de Docker Compose. Las variables se agrupan por servicio.

### Servicio: `keycloak-db`

Credenciales del servidor de base de datos requerido por el servicio `keycloak-service`.

- `PGDATA`: Ruta donde se almacenarán los datos persistentes de PostgreSQL.
- `POSTGRES_USER`: Usuario administrador de la base de datos PostgreSQL.
- `POSTGRES_PASSWORD`: Contraseña del usuario administrador.
- `POSTGRES_DB`: Nombre de la base de datos que se usará para el servicio de Keycloak.

### Servicio: `keycloak-service`

Servidor de identidades (AIM) que gestiona autenticación y autorización.

- `KEYCLOAK_ADMIN`: Usuario administrador del servidor de identidades Keycloak.
- `KEYCLOAK_ADMIN_PASSWORD`: Contraseña del usuario administrador.
- `KC_DB`: Tipo de base de datos utilizada por Keycloak (por ejemplo: `postgres`).
- `KC_DB_URL`: URL de conexión a la base de datos utilizada por Keycloak.
- `KC_DB_USERNAME`: Usuario de la base de datos que será usado por Keycloak.
- `KC_DB_PASSWORD`: Contraseña del usuario de la base de datos.
- `KC_HOSTNAME`: Nombre del host público para acceder al servidor Keycloak.
- `KC_HOSTNAME_URL`: URL pública completa (incluyendo protocolo) del servidor Keycloak.
- `KC_PROXY`: Modo de operación detrás de un proxy reverso (por ejemplo: `edge`, `reencrypt`, etc.).

---

> ⚠️ **Importante**: Estos archivos no deben ser versionados en entornos públicos, ya que contienen credenciales y secretos sensibles. Asegúrate de agregarlos al `.gitignore` correspondiente.
