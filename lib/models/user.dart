import 'package:equatable/equatable.dart';
import 'package:food_truck/models/order.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(createToJson: true, createFactory: true)
class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final String password;
  final String? profilePictureUrl;
  final String? phoneNumber;
  final String? address;
  final DateTime? dob;
  final Set<UserOrder>? orderHistory;
  final DateTime? accountCreationDate;

  const User({
    required this.id,
    required this.email,
    required this.name,
    required this.password,
    this.profilePictureUrl,
    this.accountCreationDate,
    this.phoneNumber,
    this.address,
    this.dob,
    this.orderHistory,
  });

  @override
  List<Object?> get props => [id, email, name, accountCreationDate, password, profilePictureUrl, phoneNumber, address, dob, orderHistory];

  static const empty = User(id: '', email: '', name: '', accountCreationDate: null, password: '');

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
