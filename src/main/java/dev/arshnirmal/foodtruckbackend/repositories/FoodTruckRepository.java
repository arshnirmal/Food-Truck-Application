package dev.arshnirmal.foodtruckbackend.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import dev.arshnirmal.foodtruckbackend.models.food_truck.FoodTruck;

import java.util.List;

@Repository
public interface FoodTruckRepository extends JpaRepository<FoodTruck, Integer> {
    static List<FoodTruck> findByLocation(String latitude, String longitude){
        return null;
    }
}
