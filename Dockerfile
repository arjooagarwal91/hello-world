#Build stage
FROM maven:3.6.0-jdk-11-slim AS build
WORKDIR /usr/src/iotd
COPY pom.xml .
RUN mvn package


#package stage

FROM openjdk:8-jdk-alpine
ENV PORT 8080
EXPOSE 8080
COPY --from=build  /usr/src/iotd/target/*.jar /opt/app.jar
WORKDIR /opt
CMD ["java", "-jar", "app.jar"]