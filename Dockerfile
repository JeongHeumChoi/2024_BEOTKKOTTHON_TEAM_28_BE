FROM openjdk:17-alpine

RUN ./gradlew clean build -x test
# ARG JAR_FILE=build/libs/*.jar
# COPY ${JAR_FILE} app.jar
RUN buildx build --platform linux/amd64 --load --tag jeongheumchoi/startup-valley-server:0.0.1 .
ENTRYPOINT ["java","-jar","/app.jar"]