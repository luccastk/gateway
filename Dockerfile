# Etapa de build (builder)
FROM maven:3.8.3-openjdk-17 AS builder

LABEL authors="Japa2k"

WORKDIR /app

COPY . .

RUN mvn clean install -f pom.xml

# Etapa de execução (runtime)
FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

EXPOSE 8080

# Copiando o JAR gerado na etapa de build
COPY --from=builder /app/target/gateway-0.0.1-SNAPSHOT.jar /app.jar

# Copiando o script wait-for-it.sh e garantindo permissão de execução
COPY wait-for-it.sh /app/wait-for-it.sh
RUN chmod +x /app/wait-for-it.sh

# Definição do ponto de entrada
ENTRYPOINT ["java", "-jar", "/app.jar"]
