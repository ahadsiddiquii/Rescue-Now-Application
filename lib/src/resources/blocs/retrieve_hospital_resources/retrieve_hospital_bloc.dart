import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../generic_widgets/custom_snackbar.dart';
import '../../app_context_manager.dart';
import '../../custom_exception_handler.dart';
import '../../firestore_services.dart/hospital/hospital_firestore_service.dart';
import '../../models/hospital.dart';

part 'retrieve_hospital_event.dart';
part 'retrieve_hospital_state.dart';

class RetrieveHospitalBloc
    extends Bloc<RetrieveHospitalEvent, RetrieveHospitalState> {
  RetrieveHospitalBloc() : super(RetrieveHospitalInitial()) {
    final HospitalFirestoreService hospitalFirestoreService =
        HospitalFirestoreService();
    on<GetAllHospitals>((event, emit) async {
      try {
        emit(RetrievingHospitals());
        final List<Hospital> allHospitals =
            await hospitalFirestoreService.getAllHospitals();

        CustomSnackBar.snackBarTrigger(
          context: AppContextManager.getAppContext(),
          message: 'Hospitals retrieved successfully',
        );
        emit(RetrievedAllHospitals(allHospitalsList: allHospitals));
      } catch (e) {
        CustomSnackBar.snackBarTrigger(
          context: AppContextManager.getAppContext(),
          message: CustomExceptionHandler.getError500(),
        );
        emit(RetrieveHospitalInitial());
      }
    });
    on<SetRetrieveHospitalsBlocToInitial>((event, emit) async {
      emit(RetrieveHospitalInitial());
    });
  }
}
