import 'package:json_annotation/json_annotation.dart';

part 'auth_models.g.dart';

@JsonSerializable(createToJson: true, createFactory: true)
class LoginRequest {
  String email;
  String password;
  String fcmToken;

  LoginRequest({required this.email, required this.password, required this.fcmToken});

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);
}

@JsonSerializable(createToJson: true, createFactory: true)
class LoginResponse {
  String token;
  String errorMessage;

  LoginResponse({required this.token, required this.errorMessage});

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);
}

@JsonSerializable(createToJson: true, createFactory: true)
class RegisterRequest {
  String email;
  String password;
  String name;
  String fcmToken;

  RegisterRequest({required this.email, required this.password, required this.name, required this.fcmToken});

  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
  factory RegisterRequest.fromJson(Map<String, dynamic> json) => _$RegisterRequestFromJson(json);
}

@JsonSerializable(createToJson: true, createFactory: true)
class RegisterResponse {
  String token;
  String errorMessage;

  RegisterResponse({required this.token, required this.errorMessage});

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
  factory RegisterResponse.fromJson(Map<String, dynamic> json) => _$RegisterResponseFromJson(json);
}

@JsonSerializable(createToJson: true, createFactory: true)
class ForgotPasswordRequest {
  String email;

  ForgotPasswordRequest({required this.email});

  Map<String, dynamic> toJson() => _$ForgotPasswordRequestToJson(this);
  factory ForgotPasswordRequest.fromJson(Map<String, dynamic> json) => _$ForgotPasswordRequestFromJson(json);
}

@JsonSerializable(createToJson: true, createFactory: true)
class ForgotPasswordResponse {
  String verificationCode;
  String errorMessage;

  ForgotPasswordResponse({required this.verificationCode, required this.errorMessage});

  Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);
  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) => _$ForgotPasswordResponseFromJson(json);
}
