# 🌐 Proceso de Ingesta de Datos IoT - Arquitectura Basada en Microservicios

## 🧭 Visión General

Este repositorio documenta la arquitectura funcional y técnica de un sistema de **monitoreo IoT distribuido**, orientado a capturar, almacenar y analizar datos provenientes de sensores desplegados en campo. La solución está estructurada alrededor de un **proceso de negocio principal**: la **Ingesta de Datos IoT**, soportado por una arquitectura de **microservicios especializados**.

---

## 🌱 Casos de Uso Reales en el Negocio

La solución puede adaptarse a múltiples dominios y escenarios industriales, entre ellos:

### 🚜 Agricultura de Precisión
Monitoreo de humedad, temperatura y nutrientes en suelos para optimizar el riego y la producción agrícola.

### 🚚 Logística y Transporte
Seguimiento de condiciones de transporte: ubicación, temperatura de carga, vibración, y condiciones del vehículo.

### 🏢 Edificios Inteligentes
Medición de condiciones ambientales en oficinas o instalaciones industriales para eficiencia energética y confort.

### 🏭 Manufactura Industrial
Supervisión de variables críticas en procesos productivos: vibración, presión, temperatura, humedad, etc.

### 🐄 Ganadería Inteligente
Control de salud y bienestar animal a través de sensores de ambiente o directamente en los animales.

---

## 🧭 Proceso Principal: Ingesta de Datos IoT

> Flujo de negocio completo que permite la captura, validación, almacenamiento y seguimiento de lecturas desde sensores desplegados en el campo.

Este proceso depende de varios **subprocesos funcionales** que garantizan la calidad, trazabilidad y disponibilidad de los datos capturados.

---

## 🔄 Subprocesos Involucrados

| Subproceso                             | Descripción                                                                 |
|----------------------------------------|-----------------------------------------------------------------------------|
| **1. Alta de sensores del cliente**    | Registro de sensores físicos en campo asociados a clientes.                |
| **2. Alta de sensores del fabricante** | Registro de tipos, modelos y unidades de sensores en el catálogo.          |
| **3. Registro de ubicaciones**         | Definición de lugares físicos donde operan los sensores.                   |
| **4. Asociación cliente-sensor**       | Enlace entre sensores, ubicaciones, clientes y tipos.                      |
| **5. Captura y persistencia de datos** | Recepción de lecturas, validación y almacenamiento histórico.              |
| **6. Generación de eventos o alertas** | Emisión de eventos para análisis, dashboards o notificaciones automáticas. |

---

## 🔌 Arquitectura de Microservicios

Cada subproceso es soportado por uno o más **microservicios especializados**, que colaboran de forma coordinada, ya sea mediante **llamadas HTTP/gRPC** o mediante **eventos asincrónicos (Kafka, RabbitMQ)**.

### Microservicios Clave

| Microservicio           | Responsabilidad                                                              |
|-------------------------|------------------------------------------------------------------------------|
| `ubicaciones-service`   | Gestión de ubicaciones físicas (parcelas, zonas, granjas, etc.)             |
| `tipos-sensor-service`  | Catálogo de sensores disponibles: tipos, modelos, unidades.                 |
| `sensores-service`      | Registro, actualización y gestión de sensores en campo.                     |
| `lecturas-service`      | Recepción y almacenamiento de datos enviados por sensores.                  |
| `usuarios-service`      | Gestión de clientes y control de acceso.                                    |
| `alertas-service`       | Evaluación de reglas, disparo de notificaciones, integración con dashboards.|

---

## ⚙️ Orquestación y Coreografía

### Orquestación
El **proceso de ingesta de datos** actúa como **orquestador funcional**, ya que su ejecución depende de la disponibilidad y correcto funcionamiento de subprocesos como:

- Registro de sensores.
- Registro de ubicaciones.
- Existencia de tipos válidos en el catálogo.

### Coreografía
Los microservicios colaboran de manera **coreografiada** mediante eventos, permitiendo un diseño desacoplado y escalable:

- `sensores-service` → emite `SensorCreado`
- `lecturas-service` → escucha `SensorCreado` para aceptar lecturas
- `lecturas-service` → emite `LecturaRegistrada`
- `alertas-service` → escucha `LecturaRegistrada` y evalúa reglas

---

## 🧩 Ejemplo de Flujo

```plaintext
Cliente registra un sensor → sensores-service
 ↳ Valida ubicación → ubicaciones-service
 ↳ Valida tipo de sensor → tipos-sensor-service
 ↳ Emite evento "SensorCreado"

Sensor en campo envía datos → lecturas-service
 ↳ Valida que el sensor esté registrado (opcional)
 ↳ Almacena la lectura
 ↳ Emite evento "LecturaRegistrada"

Alertas-service recibe el evento y actúa si corresponde

```

📦 Tecnologías Recomendadas
API Gateway: Traefik, Kong, NGINX

Mensajería: Kafka, RabbitMQ, NATS

Bases de datos:

Catálogos: PostgreSQL, MySQL

Lecturas: TimescaleDB, InfluxDB

Lenguajes sugeridos: Python (FastAPI), Node.js (NestJS), Java (Spring Boot), Go

✅ Beneficios de esta Arquitectura
- Escalabilidad horizontal de servicios independientes.
- Resiliencia ante fallos de componentes individuales.
- Adaptabilidad funcional a distintos dominios de negocio.
- Evolución independiente de cada servicio y subproceso.


