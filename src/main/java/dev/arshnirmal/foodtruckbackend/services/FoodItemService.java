package dev.arshnirmal.foodtruckbackend.services;

import dev.arshnirmal.foodtruckbackend.models.food_item.FoodItem;
import dev.arshnirmal.foodtruckbackend.repositories.FoodItemRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.data.rest.webmvc.ResourceNotFoundException;
import org.springframework.stereotype.Service;

import com.google.common.base.Optional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class FoodItemService {
    private FoodItemRepository foodItemRepository;

    public void addFoodItem(FoodItem foodItem) {
        foodItemRepository.findById(foodItem.getId())
                .orElseThrow(() -> new ResourceNotFoundException(
                        "Food item already exists with this id :: " + foodItem.getId()));

        foodItemRepository.save(foodItem);
    }

    public void updateFoodItem(int id, FoodItem foodItem) {
        FoodItem existingFoodItem = foodItemRepository
                .findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Food item not found for this id :: " + id));

        existingFoodItem.setName(foodItem.getName());
        existingFoodItem.setDescription(foodItem.getDescription());
        existingFoodItem.setPrice(foodItem.getPrice());
        existingFoodItem.setImageUrl(foodItem.getImageUrl());
        existingFoodItem.setQuantity(foodItem.getQuantity());
        existingFoodItem.setIsAvailable(foodItem.getIsAvailable());
        existingFoodItem.setFoodType(foodItem.getFoodType());
        existingFoodItem.setCategory(foodItem.getCategory());
        existingFoodItem.setPreparationTime(foodItem.getPreparationTime());
        existingFoodItem.setDiscount(foodItem.getDiscount());
        existingFoodItem.setAverageRating(foodItem.getAverageRating());
        existingFoodItem.setNutritionalValue(foodItem.getNutritionalValue());
    }

    public void deleteFoodItem(Integer id) {
        foodItemRepository.deleteById(id);
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
        Optional<List<FoodItem>> foodItems = foodItemRepository.findByName(name);
        if (foodItems.isPresent()) {
            return foodItems.get();
        } else {
            throw new ResourceNotFoundException("Food items not found with name :: " + name);

        }
    }

}
