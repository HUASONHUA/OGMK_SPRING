# ====== 第一階段：使用 Maven + Java 21 建置 Spring Boot 應用 ======
FROM maven:3.9.9-eclipse-temurin-21 AS build
WORKDIR /build
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# ====== 第二階段：執行階段，只需 JDK，不需 Maven ======
FROM eclipse-temurin:21-jdk
WORKDIR /app
COPY --from=build /build/target/*.jar app.jar

# 開放 Spring Boot 伺服器的埠號
EXPOSE 8080

# 啟動 Spring Boot 應用
ENTRYPOINT ["java", "-jar", "app.jar"]
