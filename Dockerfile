FROM gradle:8.2.1-jdk17 AS builder

WORKDIR /usr/src

COPY src /usr/src
RUN gradle wrapper --gradle-version 8.2.1
RUN chmod +x gradlew
RUN ./gradlew clean build -x test

FROM openjdk:17-jdk-alpine
COPY --from=builder /usr/src/build/libs/startup-valley-0.0.1-SNAPSHOT.jar /usr/app/app.jar
ENTRYPOINT ["java","-jar","/usr/app/app.jar"]