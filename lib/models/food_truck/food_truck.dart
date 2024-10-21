import 'package:json_annotation/json_annotation.dart';

part 'food_truck.g.dart';

@JsonSerializable(createFactory: true, createToJson: true)
class Loaction {
  String name;
  String latitude;
  String longitude;

  Loaction({
    required this.name,
    required this.latitude,
    required this.longitude,
  });

  factory Loaction.fromJson(Map<String, dynamic> json) => _$LoactionFromJson(json);
  Map<String, dynamic> toJson() => _$LoactionToJson(this);
}

@JsonSerializable(createFactory: true, createToJson: true)
class FoodTruck {
  String name;
  String imageUrl;
  Loaction location;
  String description;
  double rating;
  double distance;
  double waitingTime;

  FoodTruck({
    required this.name,
    required this.imageUrl,
    required this.location,
    required this.description,
    required this.rating,
    required this.distance,
    required this.waitingTime,
  });

  factory FoodTruck.fromJson(Map<String, dynamic> json) => _$FoodTruckFromJson(json);
  Map<String, dynamic> toJson() => _$FoodTruckToJson(this);
}
