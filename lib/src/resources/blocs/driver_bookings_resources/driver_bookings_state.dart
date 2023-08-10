part of 'driver_bookings_bloc.dart';

@immutable
abstract class DriverBookingsState {}

class DriverBookingsInitial extends DriverBookingsState {}

class RetrievingDriverBookings extends DriverBookingsState {}

class RetrievedAllDriverBookings extends DriverBookingsState {
  RetrievedAllDriverBookings({
    required this.activeOrders,
    required this.pastOrders,
  });
  final List<Emergency> activeOrders;
  final List<Emergency> pastOrders;
}
