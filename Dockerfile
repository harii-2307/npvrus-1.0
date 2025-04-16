# ----------- Stage 1: Build -----------
FROM gradle:7.6.1-jdk11 AS build

COPY --chown=gradle:gradle . /home/gradle/project
WORKDIR /home/gradle/project

RUN gradle build --no-daemon

# ----------- Stage 2: Run -----------
FROM openjdk:11-jre-slim

COPY --from=build /home/gradle/project/app/build/libs/*.jar /app/app.jar

ENTRYPOINT ["java", "-jar", "/app/app.jar"]

