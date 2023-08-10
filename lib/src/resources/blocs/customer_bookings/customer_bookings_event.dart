part of 'customer_bookings_bloc.dart';

@immutable
abstract class CustomerBookingsEvent {}

class GetAllCustomerOrders extends CustomerBookingsEvent {
  GetAllCustomerOrders({
    required this.userid,
  });
  final String userid;
}

class RefreshAllCustomerOrders extends CustomerBookingsEvent {
  RefreshAllCustomerOrders({
    required this.userid,
  });
  final String userid;
}

class SetCustomerBookingsBlocToInitial extends CustomerBookingsEvent {}
