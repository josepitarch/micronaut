# ====== Etapa 1: Build ======
FROM maven:3.9.9-eclipse-temurin-21 AS builder
WORKDIR /app

# Copiamos el descriptor de dependencias primero (para cachear)
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copiamos el resto del código fuente
COPY src ./src

# Compilamos y empaquetamos el jar (el -all.jar contiene dependencias)
RUN mvn package -DskipTests

# ====== Etapa 2: Runtime ======
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app

# Copiamos solo el jar ejecutable desde la etapa anterior
COPY --from=builder /app/target/test-0.1.jar app.jar

# Puerto por defecto de Micronaut
EXPOSE 8080

# Ejecutar la aplicación
ENTRYPOINT ["java", "-jar", "app.jar"]