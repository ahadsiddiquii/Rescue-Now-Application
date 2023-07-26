import 'dart:convert';

class UserRoles {
  UserRoles._();
  static List<String> userRolesList = const ['Customer', 'Driver', 'Admin'];
}

User userFromJson(String str) =>
    User.fromJson(json.decode(str) as Map<String, dynamic>);

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.id,
    required this.phoneNumberRoleKey,
    required this.phoneNumber,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as String,
        phoneNumber: json['phoneNumber'] as String,
        phoneNumberRoleKey: json['phoneNumberRoleKey'] as String,
        role: json['role'] as String,
      );

  String id;
  String phoneNumber;
  String phoneNumberRoleKey;
  String role;

  Map<String, dynamic> toJson() => {
        'id': id,
        'phoneNumber': phoneNumber,
        'phoneNumberRoleKey': phoneNumberRoleKey,
        'role': role,
      };
}
