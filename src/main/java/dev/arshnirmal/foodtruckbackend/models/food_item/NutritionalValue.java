package dev.arshnirmal.foodtruckbackend.models.food_item;

import jakarta.persistence.Embeddable;

@Embeddable
public class NutritionalValue {
    private Integer calories;
    private Integer protein;
    private Integer carbs;
    private Integer fats;
}
