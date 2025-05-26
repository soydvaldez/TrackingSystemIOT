# ingest-process

Proceso de ingesta de datos masivos provenientes de múltiples productores, principalmente sensores IoT (temperatura, humedad, entre otros). Este sistema está compuesto por microservicios orquestados mediante el patrón **Sagas** y desplegados usando contenedores.

---

## 📦 Arquitectura

- Agrupación lógica de microservicios dentro de un contenedor lógico: `ingest-process`
- Orquestación mediante el patrón **Sagas** para asegurar consistencia distribuida
- Comunicación asincrónica con **Apache Kafka**
- Persistencia mediante **PostgreSQL**
- Manejo de errores y resiliencia usando **estrategias de retry**
- Automatización de tareas y scripts vía **Bash**

---

## 🚀 Tecnologías utilizadas

| Categoría           | Tecnología              |
|---------------------|-------------------------|
| Contenerización     | Docker, Docker Compose  |
| Back-end            | Spring Boot 3.x.x       |
| Build tool          | Gradle                  |
| JDK                 | Java 11                 |
| Base de datos       | PostgreSQL              |
| Mensajería          | Apache Kafka            |
| Scripting           | Bash                    |

---

## 🛠️ Instalación

1. Clona este repositorio:

   ```bash
   git clone https://github.com/tu-usuario/ingest-process.git
   cd ingest-process
   ```
2. Inicializa submódulos si los hay:
    ```bash
    git submodule update --init --recursive
    ```

3. 
    ```bash 
    docker-compose up --build -d
    ```

📂 Estructura del proyecto
```bash 
tracking-system-io/                  # Raiz del proceso
├── docker-compose.yml
├── README.md
├── ingest-process/                  # Contenedor lógico
│   ├── docker-compose.ingest.yml    # docker-compose para orquestar los servicios del proceso
│   ├── IngestionService/            # Microservicio de ingesta
│   ├── TransformationService/       # Microservicio de transformación (ejemplo)
│   └── ...                          # Otros microservicios
├── scripts/                         # Scripts Bash de utilidad
└── .env                             # Variables de entorno
```

📡 Comunicación entre servicios
Los microservicios se comunican de forma asincrónica usando Apache Kafka, lo que permite desacoplamiento, resiliencia y escalabilidad.

🔁 Manejo de fallos
Se aplican reintentos automáticos (retry) para gestionar errores transitorios.

En caso de fallos definitivos, se ejecutan acciones compensatorias definidas por el patrón Sagas, para mantener la coherencia del sistema distribuido.

📈 Escalabilidad
Gracias al uso de contenedores y mensajería basada en eventos, el sistema puede escalar horizontalmente tanto en procesamiento como en volumen de datos.

📌 Estado actual
 - Inicialización del contenedor lógico ingest-process
 - Integración de microservicios base
 - Configuración de PostgreSQL y Kafka
 - Definición de la estrategia de Sagas
 - Implementación de mecanismos de compensación
 - Pruebas de resiliencia con retry/failover


