package dev.arshnirmal.foodtruckbackend.repositories;

import dev.arshnirmal.foodtruckbackend.models.FoodItem;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface FoodItemRepository extends JpaRepository<FoodItem, Integer> {

    List<FoodItem> findByName(String name);
}
