package dev.arshnirmal.foodtruckbackend.models;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "food_items")
public class FoodItem {
    @Id
    @GeneratedValue
    private Integer id;

    private String name;

    private String description;

    private Double price;

    private String imageUrl;

    private Integer quantity;

    private Boolean isAvailable;

    private Boolean isVeg;
}
