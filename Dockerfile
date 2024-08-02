FROM gradle:7.3.3-jdk17 AS builder

WORKDIR /app

COPY gradlew .
COPY build.gradle.kts settings.gradle.kts ./
COPY gradle ./gradle

COPY src ./src

RUN chmod +x gradlew

RUN ./gradlew clean build -x test


FROM openjdk:17-alpine

COPY --from=builder /app/build/libs/*.jar /app/app.jar

#COPY build/libs/*.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]