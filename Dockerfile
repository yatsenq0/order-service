# Этап 1: Сборка JAR
FROM maven:3.8-eclipse-temurin-17 AS builder
WORKDIR /app
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn package -DskipTests

# Этап 2: Запуск приложения
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Создаём непривилегированного пользователя
RUN addgroup -g 1001 -S appuser && \
    adduser -u 1001 -S appuser -G appuser

# Копируем JAR из первого этапа
COPY --from=builder /app/target/order-service-*.jar app.jar

# Меняем пользователя
USER appuser

# Открываем порт
EXPOSE 8080

# Запуск приложения
ENTRYPOINT ["java", "-jar", "app.jar"]
