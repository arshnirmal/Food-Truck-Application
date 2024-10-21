import 'package:json_annotation/json_annotation.dart';

part 'coupon.g.dart';

@JsonSerializable(createFactory: true, createToJson: true)
class Coupon {
  String code;
  String description;

  Coupon({
    required this.code,
    required this.description,
  });

  factory Coupon.fromJson(Map<String, dynamic> json) => _$CouponFromJson(json);
  Map<String, dynamic> toJson() => _$CouponToJson(this);
}
