import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../driver_module/order_tracking/order_tracking_main_screen.dart';
import '../../../generic_widgets/custom_snackbar.dart';
import '../../app_context_manager.dart';
import '../../custom_exception_handler.dart';
import '../../firestore_services.dart/order/order_firestore_service.dart';
import '../../models/order.dart';
import '../retrieve_order_resources/retrieve_order_bloc.dart';
import 'driver_current_job_bloc.dart';

class DriverCurrentJobHelper {
  DriverCurrentJobHelper._();

  static Future<void> acceptCurrentJob(
    BuildContext context, {
    required Emergency currentOrder,
    required String driverId,
  }) async {
    final OrderFirestoreService orderFirestoreService = OrderFirestoreService();

    try {
      BlocProvider.of<DriverCurrentJobBloc>(context)
          .add(ChangeJobState(currentJobState: DriverCurrentJobLoading()));
      final Emergency updatedEmergency = await orderFirestoreService.acceptJob(
        acceptedOrder: currentOrder,
        driverId: driverId,
      );

      CustomSnackBar.snackBarTrigger(
        context: context,
        message: 'Job started successfully',
      );
      BlocProvider.of<RetrieveOrderBloc>(AppContextManager.getAppContext())
          .add(GetAllUnAcceptedOrders(
        driverId: driverId,
      ));
      BlocProvider.of<DriverCurrentJobBloc>(context).add(
        ChangeJobState(
          currentJobState: DriverCurrentJobAccepted(
            currentWorkingOrder: updatedEmergency,
          ),
        ),
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OrderTrackingMainScreen(
            currentOrder: updatedEmergency,
            isCustomer: false,
          ),
        ),
      );
    } catch (e) {
      CustomSnackBar.snackBarTrigger(
        context: context,
        message: CustomExceptionHandler.getError500(),
      );
      BlocProvider.of<DriverCurrentJobBloc>(context).add(
        ChangeJobState(
          currentJobState: DriverCurrentJobInitial(),
        ),
      );
    }
  }

  static Future<void> rejectCurrentJob(
    BuildContext context, {
    required Emergency currentOrder,
    required String driverId,
  }) async {
    final OrderFirestoreService orderFirestoreService = OrderFirestoreService();

    try {
      BlocProvider.of<DriverCurrentJobBloc>(context)
          .add(ChangeJobState(currentJobState: DriverCurrentJobLoading()));

      await orderFirestoreService.driverRejectedTheOrder(
        emergencyOrder: currentOrder,
        driverId: driverId,
      );

      CustomSnackBar.snackBarTrigger(
        context: context,
        message: 'You have rejected this emergency.',
      );
      BlocProvider.of<RetrieveOrderBloc>(context).add(GetAllUnAcceptedOrders(
        driverId: driverId,
      ));
    } catch (e) {
      CustomSnackBar.snackBarTrigger(
        context: context,
        message: CustomExceptionHandler.getError500(),
      );
      BlocProvider.of<DriverCurrentJobBloc>(context).add(
        ChangeJobState(
          currentJobState: DriverCurrentJobInitial(),
        ),
      );
    }
  }
}
