import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../../generic_widgets/custom_snackbar.dart';
import '../../app_context_manager.dart';
import '../../custom_exception_handler.dart';
import '../../firestore_services.dart/ambulance/ambulance_firestore_service.dart';

part 'ambulance_event.dart';
part 'ambulance_state.dart';

class AmbulanceBloc extends Bloc<AmbulanceEvent, AmbulanceState> {
  AmbulanceBloc() : super(AmbulanceInitial()) {
    final ambulanceFirestoreService = AmbulanceFirestoreService();
    on<AddAmbulance>((event, emit) async {
      try {
        emit(AmbulanceLoading());
        final bool isAmbulanceAdded =
            await ambulanceFirestoreService.addAmbulance(
          plateNumber: event.plateNumber,
          vehicleImage: event.vehicleImage,
          registrationImage: event.registrationImage,
        );
        if (isAmbulanceAdded) {
          CustomSnackBar.snackBarTrigger(
            context: AppContextManager.getAppContext(),
            message: 'Ambulance added successfully',
          );
          emit(AmbulanceAdded());
        } else {
          CustomSnackBar.snackBarTrigger(
            context: AppContextManager.getAppContext(),
            message: CustomExceptionHandler.getError500(),
          );
          emit(AmbulanceInitial());
        }
      } catch (e) {
        CustomSnackBar.snackBarTrigger(
          context: AppContextManager.getAppContext(),
          message: CustomExceptionHandler.getError500(),
        );
        emit(AmbulanceInitial());
      }
    });
    on<DeleteAmbulance>((event, emit) async {
      try {
        emit(AmbulanceLoading());
        final bool isAmbulanceDeleted =
            await ambulanceFirestoreService.deleteAmbulance(
          event.plateNumber,
        );
        if (isAmbulanceDeleted) {
          CustomSnackBar.snackBarTrigger(
            context: AppContextManager.getAppContext(),
            message: 'Ambulance deleted successfully',
          );
          emit(AmbulanceDeleted());
        } else {
          CustomSnackBar.snackBarTrigger(
            context: AppContextManager.getAppContext(),
            message: CustomExceptionHandler.getError500(),
          );
          emit(AmbulanceInitial());
        }
      } catch (e) {
        CustomSnackBar.snackBarTrigger(
          context: AppContextManager.getAppContext(),
          message: CustomExceptionHandler.getError500(),
        );
        emit(AmbulanceInitial());
      }
    });
    on<SetAmbulanceBlocToInitial>((event, emit) async {
      emit(AmbulanceInitial());
    });
  }
}
