package dev.arshnirmal.foodtruckbackend.models.food_truck;


import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "food_trucks")
public class FoodTruck {
    @Id
    @GeneratedValue
    private Integer id;

    private String name;

    @Embedded
    private Location location;
}
