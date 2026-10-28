# Build Stage
FROM maven:3.9-eclipse-temurin-25 AS build

WORKDIR /app

COPY pom.xml .
COPY src ./src

RUN mvn clean package -DskipTests

# Verify generated artifact
RUN ls -lah /app/target/

# Runtime Stage
FROM eclipse-temurin:25-jre

WORKDIR /app

COPY --from=build /app/target/*.war /app/app.war

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.war"]