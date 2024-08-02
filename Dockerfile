

WORKDIR /app

COPY src ./src
COPY gradlew .
COPY gradlew.bat .

RUN chmod +x gradlew

RUN ./gradlew clean build -x test


FROM openjdk:17-alpine


COPY build/libs/*.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]