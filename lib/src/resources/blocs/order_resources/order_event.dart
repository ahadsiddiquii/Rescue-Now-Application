part of 'order_bloc.dart';

@immutable
abstract class OrderEvent {}

class InsertEmergencyOrder extends OrderEvent {
  InsertEmergencyOrder({
    required this.customerId,
    required this.emergencyLevel,
    required this.stress,
  });
  final String emergencyLevel;
  final String stress;
  final String customerId;
}

class InsertNormalOrder extends OrderEvent {
  InsertNormalOrder({
    required this.customerId,
    required this.emergencyLevel,
    required this.stress,
    required this.hospital,
    required this.currentLat,
    required this.currentLong,
  });
  final String emergencyLevel;
  final String stress;
  final String customerId;
  final Hospital hospital;
  final double currentLat;
  final double currentLong;
}

class SetOrderBlocToInitial extends OrderEvent {}
