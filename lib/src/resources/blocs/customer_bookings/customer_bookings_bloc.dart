import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../generic_widgets/custom_snackbar.dart';
import '../../app_context_manager.dart';
import '../../custom_exception_handler.dart';
import '../../firestore_services.dart/order/order_firestore_service.dart';
import '../../models/order.dart';

part 'customer_bookings_event.dart';
part 'customer_bookings_state.dart';

class CustomerBookingsBloc
    extends Bloc<CustomerBookingsEvent, CustomerBookingsState> {
  CustomerBookingsBloc() : super(CustomerBookingsInitial()) {
    final OrderFirestoreService orderFirestoreService = OrderFirestoreService();
    on<GetAllCustomerOrders>((event, emit) async {
      try {
        emit(RetrievingCustomerBookings());
        final List<Emergency> allOrders =
            await orderFirestoreService.getAllCustomerOrders(
          userId: event.userid,
        );
        List<Emergency> searchingOrders = [];
        List<Emergency> currentOrders = [];
        List<Emergency> pastOrders = [];

        for (final Emergency emergencyItem in allOrders) {
          if (!emergencyItem.isAccepted) {
            searchingOrders.add(emergencyItem);
          } else if (emergencyItem.isAccepted &&
              emergencyItem.job != null &&
              !emergencyItem.job!.isDelivered) {
            currentOrders.add(emergencyItem);
          } else if (emergencyItem.isAccepted &&
              emergencyItem.job != null &&
              emergencyItem.job!.isDelivered) {
            pastOrders.add(emergencyItem);
          } else {
            print('No Satisfying Condition');
          }
        }
        CustomSnackBar.snackBarTrigger(
          context: AppContextManager.getAppContext(),
          message: 'Orders retrieved successfully',
        );
        emit(
          RetrievedAllCustomerBookings(
            searchingOrders: searchingOrders,
            currentOrders: currentOrders,
            pastOrders: pastOrders,
          ),
        );
      } catch (e) {
        CustomSnackBar.snackBarTrigger(
          context: AppContextManager.getAppContext(),
          message: CustomExceptionHandler.getError500(),
        );
        emit(CustomerBookingsInitial());
      }
    });
    on<RefreshAllCustomerOrders>((event, emit) async {
      try {
        final List<Emergency> allOrders =
            await orderFirestoreService.getAllCustomerOrders(
          userId: event.userid,
        );
        List<Emergency> searchingOrders = [];
        List<Emergency> currentOrders = [];
        List<Emergency> pastOrders = [];

        for (final Emergency emergencyItem in allOrders) {
          if (!emergencyItem.isAccepted) {
            searchingOrders.add(emergencyItem);
          } else if (emergencyItem.isAccepted &&
              emergencyItem.job != null &&
              !emergencyItem.job!.isDelivered) {
            currentOrders.add(emergencyItem);
          } else if (emergencyItem.isAccepted &&
              emergencyItem.job != null &&
              emergencyItem.job!.isDelivered) {
            pastOrders.add(emergencyItem);
          } else {
            print('No Satisfying Condition');
          }
        }

        emit(
          RetrievedAllCustomerBookings(
            searchingOrders: searchingOrders,
            currentOrders: currentOrders,
            pastOrders: pastOrders,
          ),
        );
      } catch (e) {
        CustomSnackBar.snackBarTrigger(
          context: AppContextManager.getAppContext(),
          message: CustomExceptionHandler.getError500(),
        );
        emit(CustomerBookingsInitial());
      }
    });
    on<SetCustomerBookingsBlocToInitial>((event, emit) async {
      emit(CustomerBookingsInitial());
    });
  }
}
