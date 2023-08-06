part of 'driver_current_job_bloc.dart';

@immutable
abstract class DriverCurrentJobEvent {}

class AcceptCurrentOrder extends DriverCurrentJobEvent {
  AcceptCurrentOrder({
    required this.driverId,
    required this.currentOrder,
  });
  final String driverId;
  final Emergency currentOrder;
}

class UpdateCurrentOrder extends DriverCurrentJobEvent {
  UpdateCurrentOrder({
    required this.orderId,
    required this.currentOrder,
    required this.onPickupLocation,
    required this.onTripToDropoff,
    required this.onDropoffLocation,
    required this.isDelivered,
  });
  final String orderId;
  final Emergency currentOrder;
  final bool onPickupLocation;
  final bool onTripToDropoff;
  final bool onDropoffLocation;
  final bool isDelivered;
}

class GetUpdatedCurrentOrder extends DriverCurrentJobEvent {
  GetUpdatedCurrentOrder({
    required this.orderId,
    required this.currentOrder,
  });
  final String orderId;
  final Emergency currentOrder;
}
