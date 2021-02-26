#Build stage
FROM maven:3.6.0-jdk-11-slim AS build
WORKDIR /home/app
COPY pom.xml .
COPY . .
RUN mvn  clean package


#package stage

FROM openjdk:8-jdk-alpine
ENV PORT 8080
EXPOSE 8080
COPY --from=build  /home/app/target/*.jar /opt/app.jar
WORKDIR /opt
CMD ["java", "-jar", "app.jar"]