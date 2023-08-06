import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../generic_widgets/custom_snackbar.dart';
import '../../app_context_manager.dart';
import '../../custom_exception_handler.dart';
import '../../firestore_services.dart/hospital/hospital_firestore_service.dart';

part 'hospital_event.dart';
part 'hospital_state.dart';

class HospitalBloc extends Bloc<HospitalEvent, HospitalState> {
  HospitalBloc() : super(HospitalInitial()) {
    final HospitalFirestoreService hospitalFirestoreService =
        HospitalFirestoreService();
    on<AddHospital>((event, emit) async {
      try {
        emit(HospitalLoading());
        final bool isHospitalAdded = await hospitalFirestoreService.addHospital(
          placeName: event.placeName,
          placeLatitude: event.placeLatitude,
          placeLongitude: event.placeLongitude,
        );
        if (isHospitalAdded) {
          CustomSnackBar.snackBarTrigger(
            context: AppContextManager.getAppContext(),
            message: 'Hospital added successfully',
          );
          emit(HospitalAdded());
        } else {
          CustomSnackBar.snackBarTrigger(
            context: AppContextManager.getAppContext(),
            message: CustomExceptionHandler.getError500(),
          );
          emit(HospitalInitial());
        }
      } catch (e) {
        CustomSnackBar.snackBarTrigger(
          context: AppContextManager.getAppContext(),
          message: CustomExceptionHandler.getError500(),
        );
        emit(HospitalInitial());
      }
    });
    on<DeleteHospital>((event, emit) async {
      try {
        emit(HospitalLoading());
        final bool isHospitalDeleted =
            await hospitalFirestoreService.deleteHospital(
          event.hospitalId,
        );
        if (isHospitalDeleted) {
          CustomSnackBar.snackBarTrigger(
            context: AppContextManager.getAppContext(),
            message: 'Hospital deleted successfully',
          );
          emit(HospitalDeleted());
        } else {
          CustomSnackBar.snackBarTrigger(
            context: AppContextManager.getAppContext(),
            message: CustomExceptionHandler.getError500(),
          );
          emit(HospitalInitial());
        }
      } catch (e) {
        CustomSnackBar.snackBarTrigger(
          context: AppContextManager.getAppContext(),
          message: CustomExceptionHandler.getError500(),
        );
        emit(HospitalInitial());
      }
    });
  }
}
