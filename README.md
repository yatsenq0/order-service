# Order Service

**Микросервис управления заказами** на базе **Spring Boot 3**, **Java 17** и **PostgreSQL**. Это полноценный, production-ready микросервис, разработанный в рамках изучения современных практик облачной разработки. Проект демонстрирует полный жизненный цикл: от написания кода до контейнеризации, тестирования и подготовки к оркестрации в Kubernetes.

---

## 🏁 Основная информация

| Атрибут | Значение |
|--------|--------|
| **Название** | `order-service` |
| **Тип** | Микросервис (Microservice) |
| **Язык** | Java 17 |
| **Фреймворк** | Spring Boot 3.2.0 |
| **База данных** | PostgreSQL |
| **Сборка** | Apache Maven |
| **Контейнеризация** | Docker |
| **Лицензия** | MIT |

---

## 🚀 Цель проекта

Создать автономный микросервис, который предоставляет REST API для управления заказами в системе электронной коммерции. Проект служит фундаментом для изучения следующих технологий:
*   Микросервисная архитектура
*   Spring Boot и Spring Data JPA
*   Контейнеризация с Docker
*   Автоматизированное тестирование (TDD)
*   Практики DevOps и GitOps
*   Подготовка к оркестрации в Kubernetes и развертыванию в AWS EKS.

---

## 📦 Функциональность

Микросервис предоставляет следующие REST-эндпоинты:

| Метод | Путь | Описание | Тело запроса (пример) |
| :--- | :--- | :--- | :--- |
| `GET` | `/api/orders` | Получить список всех заказов | — |
| `GET` | `/api/orders/{id}` | Получить заказ по ID | — |
| `POST` | `/api/orders` | Создать новый заказ | `{"customerName": "Иван Иванов", "product": "Книга", "quantity": 1, "price": 999.99}` |
| `PUT` | `/api/orders/{id}` | Обновить данные заказа | `{"customerName": "Петр Петров", "product": "Ручка", "quantity": 2, "price": 49.99}` |
| `PUT` | `/api/orders/{id}/status` | Обновить статус заказа (например, `CREATED`, `PAID`, `SHIPPED`) | Параметр запроса: `status=PAID` |
| `DELETE` | `/api/orders/{id}` | Удалить заказ | — |

---

## 🛠️ Технологический стек

*   **Язык:** Java 17 (LTS)
*   **Фреймворк:** Spring Boot 3.2.0
*   **Система сборки:** Apache Maven 3.8+
*   **База данных:** PostgreSQL 15
*   **ORM:** Spring Data JPA / Hibernate
*   **Контейнеризация:** Docker
*   **Валидация:** Jakarta Bean Validation
*   **Автоматизация:** Lombok (для генерации boilerplate-кода)
*   **Тестирование:** JUnit 5, Mockito
*   **Мониторинг:** Spring Boot Actuator
*   **Логирование:** SLF4J / Logback
*   **Интеграция:** REST API (HTTP/HTTPS)

---

## 📂 Структура проекта

```
order-service/
├── src/main/java
│   ├── com/example/orderservice
│   │   ├── controller
│   │   │   └── OrderController.java
│   │   ├── model
│   │   │   └── Order.java
│   │   ├── repository
│   │   │   └── OrderRepository.java
│   │   ├── service
│   │   │   └── OrderService.java
│   │   ├── config
│   │   │   ├── KafkaConfig.java
│   │   │   └── SecurityConfig.java
│   │   └── OrderServiceApplication.java
├── src/main/resources
│   ├── application.yml
│   ├── application-dev.yml
│   ├── application-prod.yml
│   └── logback-spring.xml
├── Dockerfile
├── docker-compose.yml
├── helm-chart/
│   ├── Chart.yaml
│   ├── values.yaml
│   ├── values-dev.yaml
│   ├── values-prod.yaml
│   ├── values-eks.yaml
│   └── templates/
│       ├── deployment.yaml
│       ├── service.yaml
│       ├── configmap.yaml
│       ├── secret.yaml
│       ├── ingress.yaml
│       └── _helpers.tpl
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── providers.tf
│   └── terraform.tfvars
├── .github/workflows/
│   └── ci-cd.yml
└── pom.xml
```

---

## 🛠️ Установка и запуск

### Вариант 1: Запуск через Maven (для разработки)

1.  **Клонируйте репозиторий:**
    ```bash
    git clone https://github.com/ваш-логин/order-service.git
    cd order-service
    ```

2.  **Запустите PostgreSQL в Docker:**
    ```bash
    docker run --name postgres-db -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=orderdb -p 5432:5432 -d postgres:15
    ```

3.  **Запустите приложение:**
    ```bash
    mvn spring-boot:run
    ```
    Приложение запустится на порту `8080`.

4.  **Проверьте работу:**
    Откройте в браузере: `http://localhost:8080/actuator/health`. Должно отобразиться `{"status":"UP"}`.

### Вариант 2: Запуск через Docker (для production-симуляции)

1.  **Соберите Docker-образ:**
    ```bash
    docker build -t order-service:latest .
    ```

2.  **Запустите контейнер с PostgreSQL:**
    ```bash
    docker run --name postgres-db -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=orderdb -p 5432:5432 -d postgres:15
    ```

3.  **Запустите контейнер с `Order Service`:**
    ```bash
    docker run --name order-service-container -p 8080:8080 --link postgres-db:postgres -e SPRING_DATASOURCE_URL=jdbc:postgresql://postgres:5432/orderdb order-service:latest
    ```

---

## 🧪 Тестирование

Проект включает юнит-тесты, написанные с использованием JUnit 5 и Mockito.

*   **Запуск всех тестов:**
    ```bash
    mvn test
    ```

*   **Запуск тестов с покрытием:**
    Для генерации отчета о покрытии кода тестами можно использовать плагин `jacoco`.
    ```bash
    mvn test jacoco:report
    ```
    Отчет будет доступен в `target/site/jacoco/index.html`.

---

## 🐳 Контейнеризация

Проект упакован в Docker-образ с использованием многоэтапной сборки для минимизации размера итогового образа.

*   **Базовый образ:** `eclipse-temurin:17-jre-alpine` (легковесный).
*   **Безопасность:** Приложение запускается от непривилегированного пользователя `appuser`.
*   **Порт:** `8080`.

**Чтобы создать образ:**
```bash
docker build -t order-service:latest .
```

---

## 🚀 Подготовка к Kubernetes

Проект включает готовый **Helm-чарт** в папке `helm-chart/`, что позволяет легко управлять его развертыванием в Kubernetes.

*   **`helm-chart/Chart.yaml`**: Метаданные чарта.
*   **`helm-chart/values.yaml`**: Параметры по умолчанию (разработка).
*   **`helm-chart/values-prod.yaml`**: Параметры для production-окружения (интеграция с AWS RDS, ALB и т.д.).
*   **`helm-chart/templates/`**: Шаблоны Kubernetes-манифестов (`Deployment`, `Service`, `ConfigMap`, `Secret`).

**Пример установки чарта:**
```bash
helm install order-service ./helm-chart -f ./helm-chart/values-dev.yaml --namespace order-app --create-namespace
```

---

## 🔐 Безопасность

*   **База данных:** Данные хранятся в изолированной PostgreSQL-базе.
*   **Контейнер:** Запускается от непривилегированного пользователя.
*   **Конфигурация:** Чувствительные данные (пароли) передаются через переменные окружения (`SPRING_DATASOURCE_PASSWORD`).
*   **API:** Эндпоинты не защищены (для упрощения). В production-версии будет интегрирован **OAuth2/JWT** с использованием **Spring Security**.

---

## 📊 Наблюдаемость

*   **Метрики и Health Checks:** Доступны через Spring Boot Actuator (`/actuator/health`, `/actuator/prometheus`).
*   **Логирование:** Структурированное логирование в формате JSON настраивается в `logback-spring.xml`. Логи пишутся в консоль и в файл `logs/order-service.log` с ротацией.
*   **Мониторинг:** Готов к интеграции с **Prometheus** и **Grafana**.
*   **Трассировка:** Готов к интеграции с **OpenTelemetry** и **Jaeger**.

---

## 🔄 CI/CD

Проект подготовлен для интеграции с системой непрерывной доставки.

*   **GitHub Actions:** В репозитории можно создать пайплайн в `.github/workflows/` для автоматической сборки, тестирования и публикации Docker-образа в **Amazon ECR**.
*   **GitOps:** Развертывание в Kubernetes может управляться с помощью **Argo CD**, который будет синхронизировать состояние кластера с этим репозиторием.

---

## 📚 Документация API

Полная документация API будет доступна через **Swagger UI (OpenAPI)** после интеграции зависимости `springdoc-openapi-starter-webmvc-ui`. Это позволит просматривать и тестировать API прямо в браузере.

---

## 🤝 Вклад

Приветствуются исправления багов, улучшения и предложения по расширению функциональности. Пожалуйста, создавайте **Issue** для обсуждения новых функций или отправляйте **Pull Request**.

---

## 📄 Лицензия

Этот проект распространяется по лицензии **MIT**. Подробности см. в файле [LICENSE](LICENSE).
