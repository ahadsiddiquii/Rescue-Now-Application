part of 'retrieve_order_bloc.dart';

@immutable
abstract class RetrieveOrderState {}

class RetrieveOrderInitial extends RetrieveOrderState {}

class RetrievingOrders extends RetrieveOrderState {}

class RetrievedAllUnAcceptedOrders extends RetrieveOrderState {
  RetrievedAllUnAcceptedOrders({required this.allOrdersList});
  final List<Emergency> allOrdersList;
}
