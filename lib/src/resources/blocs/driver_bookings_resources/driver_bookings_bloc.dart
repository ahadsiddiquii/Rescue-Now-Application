import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../generic_widgets/custom_snackbar.dart';
import '../../app_context_manager.dart';
import '../../custom_exception_handler.dart';
import '../../firestore_services.dart/order/order_firestore_service.dart';
import '../../models/order.dart';

part 'driver_bookings_event.dart';
part 'driver_bookings_state.dart';

class DriverBookingsBloc
    extends Bloc<DriverBookingsEvent, DriverBookingsState> {
  DriverBookingsBloc() : super(DriverBookingsInitial()) {
    final OrderFirestoreService orderFirestoreService = OrderFirestoreService();
    on<GetAllDriverOrders>((event, emit) async {
      try {
        emit(RetrievingDriverBookings());
        final List<Emergency> allOrders =
            await orderFirestoreService.getAllDriverOrders(
          userId: event.userid,
        );

        List<Emergency> activeOrders = [];
        List<Emergency> pastOrders = [];

        for (final Emergency emergencyItem in allOrders) {
          if (emergencyItem.job != null && !emergencyItem.job!.isDelivered) {
            activeOrders.add(emergencyItem);
          } else if (emergencyItem.job != null &&
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
          RetrievedAllDriverBookings(
            activeOrders: activeOrders,
            pastOrders: pastOrders,
          ),
        );
      } catch (e) {
        CustomSnackBar.snackBarTrigger(
          context: AppContextManager.getAppContext(),
          message: CustomExceptionHandler.getError500(),
        );
        emit(DriverBookingsInitial());
      }
    });
    on<SetDriverBookingsBlocToInitial>((event, emit) async {
      emit(DriverBookingsInitial());
    });
  }
}
