package dev.arshnirmal.foodtruckbackend.models.food_truck;

import jakarta.persistence.Embeddable;

@Embeddable
public class Location {
    String place;
    String latitude;
    String longitude;
}
