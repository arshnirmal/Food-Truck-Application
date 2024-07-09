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
@Table(name = "food_trucks")
public class FoodTruck {
    @Id
    @GeneratedValue
    private Integer id;

    private String name;

    private String location;

    private String latitude;

    private String longitude;
}
