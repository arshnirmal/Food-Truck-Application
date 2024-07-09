import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? profilePic;

  const User({
    required this.id,
    required this.email,
    required this.name,
    this.profilePic,
  });

  @override
  List<Object?> get props => [id, email, name, profilePic];

  static const empty = User(id: '', email: '', name: '');

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      profilePic: json['profilePic'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'profilePic': profilePic,
    };
  }
}
