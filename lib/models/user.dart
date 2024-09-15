import 'package:equatable/equatable.dart';
import 'package:food_truck/models/order.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(createToJson: true, createFactory: true)
class User extends Equatable {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'profilePictureUrl', defaultValue: null)
  final String? profilePictureUrl;

  @JsonKey(name: 'phoneNumber', defaultValue: null)
  final String? phoneNumber;

  @JsonKey(name: 'address', defaultValue: null)
  final String? address;

  @JsonKey(name: 'dateOfBirth', defaultValue: null)
  final String? dateOfBirth;

  @JsonKey(name: 'orderHistory', defaultValue: null)
  final List<UserOrder>? orderHistory;

  @JsonKey(name: 'accountCreationDate', defaultValue: null)
  final String? accountCreationDate;

  const User({
    required this.id,
    required this.email,
    required this.name,
    this.profilePictureUrl,
    this.accountCreationDate,
    this.phoneNumber,
    this.address,
    this.dateOfBirth,
    this.orderHistory,
  });

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        accountCreationDate,
        profilePictureUrl,
        phoneNumber,
        address,
        dateOfBirth,
        orderHistory,
      ];

  static const empty = User(id: -1, email: '', name: '');

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
