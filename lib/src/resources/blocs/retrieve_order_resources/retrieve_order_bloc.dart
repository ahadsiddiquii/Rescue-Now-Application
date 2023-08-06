import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../generic_widgets/custom_snackbar.dart';
import '../../app_context_manager.dart';
import '../../custom_exception_handler.dart';
import '../../firestore_services.dart/order/order_firestore_service.dart';
import '../../models/order.dart';

part 'retrieve_order_event.dart';
part 'retrieve_order_state.dart';

class RetrieveOrderBloc extends Bloc<RetrieveOrderEvent, RetrieveOrderState> {
  RetrieveOrderBloc() : super(RetrieveOrderInitial()) {
    final OrderFirestoreService orderFirestoreService = OrderFirestoreService();
    on<GetAllUnAcceptedOrders>((event, emit) async {
      try {
        emit(RetrievingOrders());
        final List<Emergency> allOrders =
            await orderFirestoreService.getAllUnacceptedOrders();

        CustomSnackBar.snackBarTrigger(
          context: AppContextManager.getAppContext(),
          message: 'Orders retrieved successfully',
        );
        emit(RetrievedAllUnAcceptedOrders(allOrdersList: allOrders));
      } catch (e) {
        CustomSnackBar.snackBarTrigger(
          context: AppContextManager.getAppContext(),
          message: CustomExceptionHandler.getError500(),
        );
        emit(RetrieveOrderInitial());
      }
    });
  }
}
