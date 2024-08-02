FROM gradle/7.3.3-jdk17 AS builder

WORKDIR /app

COPY src ./src


RUN ./gradlew clean build -x test


FROM openjdk:17-alpine


COPY build/libs/*.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]