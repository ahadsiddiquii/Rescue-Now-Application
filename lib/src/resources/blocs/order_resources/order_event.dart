part of 'order_bloc.dart';

@immutable
abstract class OrderEvent {}

class InsertEmergencyOrder extends OrderEvent {
  InsertEmergencyOrder({
    required this.customerId,
    required this.emergencyLevel,
    required this.stress,
    required this.ambulanceSize,
    required this.ambulanceEquipment,
  });
  final String emergencyLevel;
  final String stress;
  final String customerId;
  final String ambulanceSize;
  final String ambulanceEquipment;
}

class InsertNormalOrder extends OrderEvent {
  InsertNormalOrder({
    required this.customerId,
    required this.emergencyLevel,
    required this.stress,
    required this.hospital,
    required this.ambulanceSize,
    required this.ambulanceEquipped,
    required this.currentLat,
    required this.currentLong,
  });
  final String emergencyLevel;
  final String stress;
  final String customerId;
  final Hospital hospital;
  final String ambulanceSize;
  final String ambulanceEquipped;
  final double currentLat;
  final double currentLong;
}

class SetOrderBlocToInitial extends OrderEvent {}
