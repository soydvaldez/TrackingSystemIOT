# OAuth2 Services

Este microservicio gestiona la autenticación y autorización centralizadas mediante el protocolo OAuth2, utilizando Keycloak como proveedor principal de identidad.

## Estructura del Proyecto
```bash
oauth2/ 
    ├── keycloak-config/     # Configuraciones de realms, clientes, roles, etc. 
    ├── custom-extensions/   # Extensiones personalizadas de Keycloak (SPIs) 
    ├── scripts/             # Scripts de automatización y despliegue 
    ├── tests/               # Pruebas de autenticación e integración 
    ├── docs/                # Documentación técnica y diagramas 
    ├── docker/              # Dockerfiles y archivos docker-compose 
    ├── config/              # Archivos de configuración (YAML, JSON) 
    ├── migrations/          # Scripts de migración si aplica 
    ├── infrastructure/
    │   ├── db/                     # Configuración y persistencia de base de datos
    │   │   ├── init.sql            # Scripts de inicialización (opcional)
    │   │   ├── docker-compose.yml  # Compose para base de datos si es independiente
    │   │   └── Dockerfile          # Si necesitas una imagen customizada
    │   ├── nginx/
    │   ├── certs/
    │   ├── infra-compose.yml       # Compose unificado para Keycloak + DB + Nginx
    │   └── server-setup.sh         # Script de despliegue remoto
    ├── utils/               # Herramientas de soporte 
    └── README.md
```
## Características

- Implementación de OAuth2 y OpenID Connect con Keycloak
- Soporte multicliente y multirealm
- Extensiones personalizadas (autenticadores, listeners)
- Despliegue automatizado con Docker

## Requisitos

- Docker y Docker Compose
- Java 17+ (para compilar extensiones Keycloak)

## Instalación

```bash
cd oauth2-services/docker
docker-compose up -d
```

## Configuración

Realms y clientes están en keycloak-config/

Para importar configuración:

```bash
docker exec -it keycloak /opt/keycloak/bin/kc.sh import --dir /opt/keycloak/data/import
```

## Scripts útiles
```bash
./scripts/generate-access-token.sh
./scripts/import-realm.sh
```
## Pruebas
```bash
cd tests
pytest
```

## Contribución

1. Crea un branch: git checkout -b feature/nueva-funcionalidad
2. Commit: git commit -am 'Agrega nueva funcionalidad'
3. Push: git push origin feature/nueva-funcionalidad
4. Abre un Pull Request

Licencia
MIT / Apache 2.0