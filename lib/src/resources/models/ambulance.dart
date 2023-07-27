import 'dart:convert';

Ambulance ambulanceFromJson(String str) =>
    Ambulance.fromJson(json.decode(str) as Map<String, dynamic>);

String userToJson(Ambulance data) => json.encode(data.toJson());

class Ambulance {
  Ambulance({
    required this.plateNumber,
    required this.vehicleFrontImage,
    required this.vehicleRegistrationImage,
  });

  factory Ambulance.fromJson(Map<String, dynamic> json) => Ambulance(
        plateNumber: json['plateNumber'] as String,
        vehicleFrontImage: json['vehicleFrontImage'] as String,
        vehicleRegistrationImage: json['vehicleRegistrationImage'] as String,
      );

  String plateNumber;
  String vehicleFrontImage;
  String vehicleRegistrationImage;

  Map<String, dynamic> toJson() => {
        'plateNumber': plateNumber,
        'vehicleFrontImage': vehicleFrontImage,
        'vehicleRegistrationImage': vehicleRegistrationImage,
      };
}
