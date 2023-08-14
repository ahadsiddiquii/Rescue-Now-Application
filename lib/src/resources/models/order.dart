// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

import 'job.dart';

Emergency orderFromJson(String str) => Emergency.fromJson(json.decode(str));

String orderToJson(Emergency data) => json.encode(data.toJson());

class Emergency {
  Emergency({
    required this.id,
    required this.customerId,
    required this.isAccepted,
    required this.emergencyLevel,
    required this.reason,
    required this.pickUpLat,
    required this.pickUpLong,
    required this.hospitalName,
    required this.dropOffLat,
    required this.dropoffLong,
    required this.preferredAmbulanceSize,
    required this.preferredAmbulanceEquipment,
    required this.job,
    required this.rejectedByDrivers,
  });

  factory Emergency.fromJson(Map<String, dynamic> json) => Emergency(
        id: json['orderId'],
        customerId: json['customerId'],
        isAccepted: json['isAccepted'],
        emergencyLevel: json['emergencyLevel'],
        reason: json['reason'],
        pickUpLat: json['pickUpLat'].toDouble(),
        pickUpLong: json['pickUpLong'].toDouble(),
        hospitalName: json['hospitalName'],
        dropOffLat: json['dropOffLat'].toDouble(),
        dropoffLong: json['dropoffLong'].toDouble(),
        preferredAmbulanceSize: json['preferredAmbulanceSize'] ?? ' ',
        preferredAmbulanceEquipment: json['preferredAmbulanceEquipment'] ?? ' ',
        job: json['job'] != null ? Job.fromJson(json['job']) : null,
        rejectedByDrivers: json['rejectedByDrivers'] ?? [],
      );
  String id;
  String customerId;
  bool isAccepted;
  String emergencyLevel;
  String reason;
  double pickUpLat;
  double pickUpLong;
  String hospitalName;
  double dropOffLat;
  double dropoffLong;
  String preferredAmbulanceSize;
  String preferredAmbulanceEquipment;
  List<dynamic> rejectedByDrivers;
  Job? job;

  Map<String, dynamic> toJson() => {
        'orderId': id,
        'customerId': customerId,
        'isAccepted': isAccepted,
        'emergencyLevel': emergencyLevel,
        'reason': reason,
        'pickUpLat': pickUpLat,
        'pickUpLong': pickUpLong,
        'hospitalName': hospitalName,
        'dropOffLat': dropOffLat,
        'dropoffLong': dropoffLong,
        'rejectedByDrivers': rejectedByDrivers,
        'preferredAmbulanceEquipment': preferredAmbulanceEquipment,
        'preferredAmbulanceSize': preferredAmbulanceSize,
        'job': job!.toJson(),
      };
}
