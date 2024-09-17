package dev.arshnirmal.foodtruckbackend.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.google.common.base.Optional;

import dev.arshnirmal.foodtruckbackend.models.food_item.FoodItem;
import java.util.List;

@Repository
public interface FoodItemRepository extends JpaRepository<FoodItem, Integer> {
    Optional<List<FoodItem>> findByName(String name);
}
