FROM gradle:jdk8-alpine AS builder
COPY --chown=gradle:gradle . /home/gradle/src
WORKDIR /home/gradle/src
RUN gradle build --no-daemon -x test


FROM openjdk:8-jdk-alpine
EXPOSE 80
COPY --from=builder /home/gradle/src/build/libs/*.jar /app/app.jar
WORKDIR /app

ENTRYPOINT ["java", "-jar", "app.jar"]