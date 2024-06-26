package dev.arshnirmal.foodtruckbackend.controllers;

import dev.arshnirmal.foodtruckbackend.models.FoodTruck;
import dev.arshnirmal.foodtruckbackend.services.FoodTruckService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/foodtrucks")
public class FoodTruckController {
    @Autowired
    private FoodTruckService foodTruckService;

    @PostMapping("/add")
    public ResponseEntity<FoodTruck> addFoodTruck(@RequestBody FoodTruck foodTruck) {
        foodTruckService.addFoodTruck(foodTruck);

        return ResponseEntity.ok(foodTruckService.getFoodTruck(foodTruck.getId()));
    }

    @PutMapping("/{id}")
    public ResponseEntity<FoodTruck> updateFoodTruck(@PathVariable int id, @RequestBody FoodTruck foodTruck) {
        foodTruckService.updateFoodTruck(id,foodTruck);

        return ResponseEntity.ok(foodTruckService.getFoodTruck(id));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<String> deleteFoodTruck(@PathVariable int id) {
        foodTruckService.deleteFoodTruck(id);

        return ResponseEntity.ok("Food truck deleted successfully");
    }

    @GetMapping("/{id}")
    public ResponseEntity<FoodTruck> getFoodTruck(@PathVariable int id) {
        return ResponseEntity.ok(foodTruckService.getFoodTruck(id));
    }


    @GetMapping("/")
    public ResponseEntity<List<FoodTruck>> getAllFoodTrucks() {
        return ResponseEntity.ok(foodTruckService.getAllFoodTrucks());
    }

    // TODO: Implement this method
    @PostMapping("/getbylocation")
    public ResponseEntity<List<FoodTruck>> getFoodTrucksByLocation(@RequestParam String latitude, @RequestParam String longitude) {
        return ResponseEntity.ok(foodTruckService.getFoodTrucksByLocation(latitude, longitude));
    }

}
