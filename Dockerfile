FROM openjdk:17-alpine
RUN ./gradlew clean build -x test
ENTRYPOINT ["java","-jar","/app.jar"]