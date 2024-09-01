package dev.arshnirmal.foodtruckbackend.services;

import dev.arshnirmal.foodtruckbackend.models.FoodItem;
import dev.arshnirmal.foodtruckbackend.repositories.FoodItemRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.rest.webmvc.ResourceNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class FoodItemService {
    private FoodItemRepository foodItemRepository;

    public void addFoodItem(FoodItem foodItem) {
        foodItemRepository.save(foodItem);
    }

    public void updateFoodItem(int id, FoodItem foodItem) {
        FoodItem existingFoodItem = foodItemRepository
                .findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Food item not found for this id :: " + id));
    }

    public void deleteFoodItem(FoodItem foodItem) {
        foodItemRepository.delete(foodItem);
    }

    public FoodItem getFoodItem(int id) {
        return foodItemRepository
                .findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Food item not found for this id :: " + id));
    }

    public List<FoodItem> getAllFoodItems() {
        return foodItemRepository.findAll();
    }

    public List<FoodItem> getFoodItemsByName(String name) {
        return foodItemRepository.findByName(name);
    }

}
