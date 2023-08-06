part of 'order_bloc.dart';

@immutable
abstract class OrderEvent {}

class InsertEmergencyOrder extends OrderEvent {
  InsertEmergencyOrder({
    required this.emergencyLevel,
    required this.stress,
  });
  final String emergencyLevel;
  final String stress;
}
