package dev.arshnirmal.foodtruckbackend;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class FoodTruckBackendApplication {

    public static void main(String[] args) {
        SpringApplication.run(FoodTruckBackendApplication.class, args);
    }
}

// ./mvnw spring-boot:build-image -Dspring-boot.build-image.imageName=arshnirmal/food-truck
// docker build -t arshnirmal/food-truck .
// docker run -p 8080:8080 arshnirmal/food-truck