part of 'retrieve_order_bloc.dart';

@immutable
abstract class RetrieveOrderEvent {}

class GetAllUnAcceptedOrders extends RetrieveOrderEvent {}

class SetRetrieveOrderBlocToInitial extends RetrieveOrderEvent {}
