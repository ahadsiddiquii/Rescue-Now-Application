part of 'retrieve_order_bloc.dart';

@immutable
abstract class RetrieveOrderEvent {}

class GetAllUnAcceptedOrders extends RetrieveOrderEvent {
  GetAllUnAcceptedOrders({required this.driverId});
  final String driverId;
}

class RefreshAllUnAcceptedOrders extends RetrieveOrderEvent {
  RefreshAllUnAcceptedOrders({required this.driverId});
  final String driverId;
}

class SetRetrieveOrderBlocToInitial extends RetrieveOrderEvent {}
