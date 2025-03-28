# Stage 1: Build the application using Maven and JDK 21
FROM maven:3.9.4-eclipse-temurin-21 AS build


# Copy all project files into the container
COPY . .

# Build the application, skipping tests for faster build
RUN mvn clean package -DskipTests

# Stage 2: Create a lightweight image for the final application
FROM eclipse-temurin:21-jdk

# Set the working directory inside the container
WORKDIR /app

# Copy the built JAR file from the previous stage
COPY --from=build /app/target/backend-app.jar backend-app.jar

# Expose port 8080
EXPOSE 8080
# Run the application
ENTRYPOINT ["java", "-jar", "backend-app.jar"]
