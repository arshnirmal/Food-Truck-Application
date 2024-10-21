package dev.arshnirmal.foodtruckbackend.models.food_item;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "food_items")
public class FoodItem {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false)
    private String name;

    private String description;

    @Column(nullable = false)
    private BigDecimal price;

    private String imageUrl;

    @Column(nullable = false)
    private int quantity;

    @Column(nullable = false)
    private Boolean isAvailable;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private FoodType foodType;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    private Category category;

    @Column(nullable = false)
    private Integer preparationTime;
    
    private BigDecimal discount;

    private Double averageRating; 
    
    @OneToOne(cascade = CascadeType.ALL)
    private NutritionalValue nutritionalValue;

}
