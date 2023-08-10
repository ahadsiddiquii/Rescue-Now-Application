part of 'driver_bookings_bloc.dart';

@immutable
abstract class DriverBookingsEvent {}

class GetAllDriverOrders extends DriverBookingsEvent {
  GetAllDriverOrders({
    required this.userid,
  });
  final String userid;
}

class SetDriverBookingsBlocToInitial extends DriverBookingsEvent {}
