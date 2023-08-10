part of 'customer_bookings_bloc.dart';

@immutable
abstract class CustomerBookingsState {}

class CustomerBookingsInitial extends CustomerBookingsState {}

class RetrievingCustomerBookings extends CustomerBookingsState {}

class RetrievedAllCustomerBookings extends CustomerBookingsState {
  RetrievedAllCustomerBookings({
    required this.searchingOrders,
    required this.currentOrders,
    required this.pastOrders,
  });
  final List<Emergency> searchingOrders;
  final List<Emergency> currentOrders;
  final List<Emergency> pastOrders;
}
