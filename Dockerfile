FROM gradle:7.3.3-jdk17 AS builder

WORKDIR /app

COPY build.gradle.kts settings.gradle.kts ./
COPY gradle ./gradle

RUN gradle build -x test --no-daemon

COPY src ./src
COPY gradlew .
COPY gradlew.bat .

RUN chmod +x gradlew

RUN ./gradlew clean build -x test


FROM openjdk:17-alpine

COPY --from=builder /app/build/libs/*.jar /app/app.jar

#COPY build/libs/*.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]