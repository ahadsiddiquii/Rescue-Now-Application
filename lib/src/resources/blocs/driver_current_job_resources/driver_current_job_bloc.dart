import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../generic_widgets/custom_snackbar.dart';
import '../../app_context_manager.dart';
import '../../custom_exception_handler.dart';
import '../../firestore_services.dart/order/order_firestore_service.dart';
import '../../models/order.dart';
import '../retrieve_order_resources/retrieve_order_bloc.dart';

part 'driver_current_job_event.dart';
part 'driver_current_job_state.dart';

class DriverCurrentJobBloc
    extends Bloc<DriverCurrentJobEvent, DriverCurrentJobState> {
  DriverCurrentJobBloc() : super(DriverCurrentJobInitial()) {
    final OrderFirestoreService orderFirestoreService = OrderFirestoreService();
    on<AcceptCurrentOrder>((event, emit) async {
      emit(DriverCurrentJobLoading());
      try {
        final Emergency updatedEmergency =
            await orderFirestoreService.acceptJob(
          acceptedOrder: event.currentOrder,
          driverId: event.driverId,
        );

        CustomSnackBar.snackBarTrigger(
          context: AppContextManager.getAppContext(),
          message: 'Job started successfully',
        );
        BlocProvider.of<RetrieveOrderBloc>(AppContextManager.getAppContext())
            .add(GetAllUnAcceptedOrders());
        emit(DriverCurrentJobAccepted(currentWorkingOrder: updatedEmergency));
      } catch (e) {
        CustomSnackBar.snackBarTrigger(
          context: AppContextManager.getAppContext(),
          message: CustomExceptionHandler.getError500(),
        );
        emit(DriverCurrentJobInitial());
      }
    });
    on<UpdateCurrentOrder>((event, emit) async {
      emit(DriverCurrentJobLoading());
      try {
        final Emergency updatedEmergency =
            await orderFirestoreService.updateJob(
          acceptedOrder: event.currentOrder,
          onPickupLocation: event.onPickupLocation,
          onTripToDropoff: event.onTripToDropoff,
          onDropoffLocation: event.onDropoffLocation,
          isDelivered: event.isDelivered,
        );

        CustomSnackBar.snackBarTrigger(
          context: AppContextManager.getAppContext(),
          message: 'Job started successfully',
        );
        BlocProvider.of<RetrieveOrderBloc>(AppContextManager.getAppContext())
            .add(GetAllUnAcceptedOrders());
        emit(DriverCurrentJobAccepted(
          currentWorkingOrder: updatedEmergency,
        ));
      } catch (e) {
        CustomSnackBar.snackBarTrigger(
          context: AppContextManager.getAppContext(),
          message: CustomExceptionHandler.getError500(),
        );
        emit(DriverCurrentJobInitial());
      }
    });
    on<GetUpdatedCurrentOrder>((event, emit) async {
      try {
        final Emergency updatedEmergency =
            await orderFirestoreService.getOrderById(
          orderId: event.orderId,
        );

        emit(DriverCurrentJobAccepted(
          currentWorkingOrder: updatedEmergency,
        ));
      } catch (e) {
        CustomSnackBar.snackBarTrigger(
          context: AppContextManager.getAppContext(),
          message: CustomExceptionHandler.getError500(),
        );
        emit(DriverCurrentJobAccepted(
          currentWorkingOrder: event.currentOrder,
        ));
      }
    });
    on<SetDriverCurrentJobBlocToInitial>((event, emit) async {
      emit(DriverCurrentJobInitial());
    });

    on<ChangeJobState>((event, emit) async {
      emit(event.currentJobState);
    });
  }
}
