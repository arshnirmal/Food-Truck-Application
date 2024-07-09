package dev.arshnirmal.foodtruckbackend.controllers;

import dev.arshnirmal.foodtruckbackend.models.FoodItem;
import dev.arshnirmal.foodtruckbackend.services.FoodItemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/fooditems")
public class FoodItemController {
    @Autowired
    private FoodItemService foodItemService;

    @PostMapping("/add")
    public ResponseEntity<FoodItem> addFoodItem(@RequestBody FoodItem foodItem) {
        foodItemService.addFoodItem(foodItem);

        return ResponseEntity.ok(foodItemService.getFoodItem(foodItem.getId()));
    }

    @PutMapping("/{id}")
    public ResponseEntity<FoodItem> updateFoodItem(@PathVariable int id ,@RequestBody FoodItem foodItem) {
        foodItemService.updateFoodItem(id, foodItem);

        return ResponseEntity.ok(foodItemService.getFoodItem(id));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteFoodItem(@RequestBody FoodItem foodItem) {
        foodItemService.deleteFoodItem(foodItem);
        return ResponseEntity.ok("Food item deleted successfully");
    }

    @GetMapping("/{id}")
    public ResponseEntity<FoodItem> getFoodItem(@PathVariable int id) {
        return ResponseEntity.ok(foodItemService.getFoodItem(id));
    }

    @GetMapping("/")
    public ResponseEntity<List<FoodItem>> getAllFoodItems() {
        return ResponseEntity.ok(foodItemService.getAllFoodItems());
    }

}
