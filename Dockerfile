FROM maven:3.8.4-openjdk-11-slim AS build
WORKDIR /
COPY src src
COPY pom.xml pom.xml
RUN mvn clean install -Dmaven.test.skip=true

FROM openjdk:11.0
LABEL "com.citi.demo"="demo-api"
LABEL version=1.0-SNAPSHOT
COPY --from=build target/demo-0.0.1-SNAPSHOT.jar demo-0.0.1-SNAPSHOT.jar
EXPOSE 6064
ENTRYPOINT ["java","-jar","demo-0.0.1-SNAPSHOT.jar"]