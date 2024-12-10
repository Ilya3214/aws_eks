# Stage 1: Build the application
FROM eclipse-temurin:21-jdk AS builder
WORKDIR /build

# Install Maven
RUN apt-get update && apt-get install -y maven

# Copy project files
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Stage 2: Create a minimal image for running the application
FROM eclipse-temurin:21-jre
WORKDIR /app

# Copy the built JAR from the builder stage
COPY --from=builder /build/target/demo-0.0.1-SNAPSHOT.jar app.jar

# Expose port and set the entry point
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]