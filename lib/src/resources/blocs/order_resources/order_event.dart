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

class SetOrderBlocToInitial extends OrderEvent {}
