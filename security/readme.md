# Módulo de Plataforma de Seguridad

El módulo de seguridad concentra los componentes transversales responsables de:

* Control de acceso a la plataforma.
* Autenticación y autorización.
* Enrutamiento dinámico de APIs.
* Gestión centralizada de identidades.
* Exposición segura de microservicios.
* Aplicación de políticas de seguridad.
* Observabilidad y administración del tráfico.

**Este módulo funciona como la “puerta de entrada” hacia el ecosistema de servicios del sistema Insight Platform IoT.**

## Objetivos del módulo

* Centralizar el acceso a todos los microservicios.
* Evitar que los servicios internos sean expuestos directamente.
* Desacoplar la seguridad de la lógica de negocio.
* Permitir autenticación tanto para usuarios humanos como para servicios técnicos.
* Gestionar autorización mediante OAuth2/OpenID Connect.
* Facilitar el escalamiento y administración de rutas.
* Mantener configuración declarativa e infraestructura reproducible.

## Componentes principales

### 1. Kong API Gateway
Responsable de:
* Enrutamiento dinámico de tráfico.
* Exposición pública de APIs.
* Balanceo de carga.
* Terminación TLS/HTTPS.
* Aplicación de plugins de seguridad.
* *Rate limiting*.
* Validación de autenticación.
* Observabilidad y *logging*.

Kong funciona como el punto único de entrada hacia la plataforma.

### 2. Keycloak Identity Provider
Responsable de:
* Gestión de identidades.
* Autenticación de usuarios.
* OAuth2.
* OpenID Connect.
* Gestión de roles y permisos.
* Tokens JWT.
* Clientes técnicos para microservicios.
* *Single Sign-On* (SSO).

Keycloak será utilizado principalmente para proteger:
* APIs administrativas.
* Consolas internas.
* Accesos privilegiados.

### 3. NGINX (Opcional)
Puede utilizarse para:
* TLS termination externa.
* Proxy reverso.
* Balanceo adicional.
* Protección perimetral.
* Integración con CDN/WAF.


## Arquitectura conceptual

<!-- Agrgar aqui el diagrama de arquitectura -->

# Modelo de Seguridad
## Usuarios Administradores

Los usuarios administrativos utilizan autenticación mediante:

- OAuth2
- OpenID Connect
- JWT

### Flujo general

1. El cliente solicita autenticación.
2. Keycloak valida credenciales.
3. Se emite un JWT.
4. Kong valida el token.
5. La solicitud es redirigida al microservicio correspondiente.

## Comunicación entre Servicios

Los servicios internos pueden autenticarse mediante:

- Client Credentials
- JWT técnicos
- API Keys internas
- mTLS (futuro)

## Kong en modo DB-less

La plataforma utiliza Kong en modo declarativo (DB-less).

Esto permite:

- Eliminar dependencia de base de datos para Kong.
- Versionar rutas mediante Git.
- Infraestructura reproducible.
- Configuración inmutable.
- Despliegues más simples.
- Integración GitOps.

## Ejemplo de configuración

```yaml
_format_version: "3.0"

services:
  - name: users-service
    url: http://users-service:8080
    routes:
      - name: users-route
        paths:
          - /users

plugins:
  - name: rate-limiting
    config:
      minute: 100
      policy: local
```