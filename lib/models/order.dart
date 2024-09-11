import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable(createToJson: true, createFactory: true)
class UserOrder {
  final String id;

  const UserOrder({
    required this.id,
  });

  factory UserOrder.fromJson(Map<String, dynamic> json) => _$UserOrderFromJson(json);
  Map<String, dynamic> toJson() => _$UserOrderToJson(this);
}
