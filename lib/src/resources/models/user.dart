import 'dart:convert';

User userFromJson(String str) =>
    User.fromJson(json.decode(str) as Map<String, dynamic>);

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.id,
    required this.phoneNumber,
    required this.isAdmin,
    required this.isCustomer,
    required this.isDriver,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as String,
        phoneNumber: json['phoneNumber'] as String,
        isAdmin: json['isAdmin'] as bool,
        isCustomer: json['isCustomer'] as bool,
        isDriver: json['isDriver'] as bool,
      );

  String id;
  String phoneNumber;
  bool isAdmin;
  bool isCustomer;
  bool isDriver;

  Map<String, dynamic> toJson() => {
        'id': id,
        'phoneNumber': phoneNumber,
        'isAdmin': isAdmin,
        'isCustomer': isCustomer,
        'isDriver': isDriver,
      };
}
