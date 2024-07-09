package dev.arshnirmal.foodtruckbackend.services;

import dev.arshnirmal.foodtruckbackend.models.FoodTruck;
import dev.arshnirmal.foodtruckbackend.repositories.FoodTruckRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.rest.webmvc.ResourceNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class FoodTruckService {
    @Autowired
    private FoodTruckRepository foodTruckRepository;

    public void addFoodTruck(FoodTruck foodTruck) {
        foodTruckRepository.save(foodTruck);
    }

    public void updateFoodTruck(int id, FoodTruck foodTruck) {
        FoodTruck existingFoodTruck = foodTruckRepository
                .findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Food truck not found for this id :: " + foodTruck.getId()));

        existingFoodTruck.setName(foodTruck.getName());
        existingFoodTruck.setLocation(foodTruck.getLocation());
        existingFoodTruck.setLatitude(foodTruck.getLatitude());
        existingFoodTruck.setLongitude(foodTruck.getLongitude());

        foodTruckRepository.save(existingFoodTruck);
    }

    public void deleteFoodTruck(int id) {
        foodTruckRepository.findById(id).ifPresent(foodTruck -> foodTruckRepository.delete(foodTruck));
    }

    public FoodTruck getFoodTruck(int id) {
        return foodTruckRepository.findById(id).orElse(null);
    }

    public List<FoodTruck> getAllFoodTrucks() {
        return foodTruckRepository.findAll();
    }

    // TODO: Implement this method
    public List<FoodTruck> getFoodTrucksByLocation(String latitude, String longitude) {
        return FoodTruckRepository.findByLocation(latitude, longitude);
    }
}
