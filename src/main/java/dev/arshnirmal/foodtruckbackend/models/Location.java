package dev.arshnirmal.foodtruckbackend.models;

import jakarta.persistence.Embeddable;

@Embeddable
public class Location {
    String place;
    String latitude;
    String longitude;
}
