FROM openjdk:20-jdk-slim
#
WORKDIR /app
#
COPY target/OSUMKI-0.0.1-SNAPSHOT.jar app.jar
#
EXPOSE 1222
#
CMD ["java", "-jar", "app.jar"]
