FROM openjdk:17-jdk-slim

WORKDIR /app
COPY ./target/EurekaServerService-0.0.1-SNAPSHOT.jar ./app.jar

# Define un perfil por defecto:
# ENV SPRING_PROFILES_ACTIVE=test

EXPOSE 8761
    
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
