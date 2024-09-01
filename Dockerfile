# Use the official Maven image to build the app
FROM maven:3.8.6-eclipse-temurin-17 AS build
WORKDIR /app

# Copy the pom.xml and the application source code to the container
COPY pom.xml .
COPY src ./src

# Package the application
RUN mvn clean package -DskipTests

# Use the official OpenJDK image to run the app
FROM openjdk:17-jdk-alpine
WORKDIR /app

# Copy the packaged jar file from the build stage
COPY --from=build /app/target/food-truck-backend-0.0.1-SNAPSHOT.jar app.jar

# Copy Firebase configuration file
COPY src/main/resources/food-truck-f524e-firebase-adminsdk-2szft-579d5d1f9c.json /app/food-truck-f524e-firebase-adminsdk-2szft-579d5d1f9c.json

# Expose the port the app runs on
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
