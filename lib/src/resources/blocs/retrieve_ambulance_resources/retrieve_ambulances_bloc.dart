import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../generic_widgets/custom_snackbar.dart';
import '../../app_context_manager.dart';
import '../../custom_exception_handler.dart';
import '../../firestore_services.dart/ambulance/ambulance_firestore_service.dart';
import '../../models/ambulance.dart';

part 'retrieve_ambulances_event.dart';
part 'retrieve_ambulances_state.dart';

class RetrieveAmbulancesBloc
    extends Bloc<RetrieveAmbulancesEvent, RetrieveAmbulancesState> {
  RetrieveAmbulancesBloc() : super(RetrieveAmbulancesInitial()) {
    final AmbulanceFirestoreService ambulanceFirestoreService =
        AmbulanceFirestoreService();
    on<GetAllAmbulances>((event, emit) async {
      try {
        emit(RetrievingAmbulances());
        final List<Ambulance> allAmbulances =
            await ambulanceFirestoreService.getAllAmbulances();

        CustomSnackBar.snackBarTrigger(
          context: AppContextManager.getAppContext(),
          message: 'Ambulance retrieved successfully',
        );
        emit(RetrievedAllAmbulances(allAmbulanceList: allAmbulances));
      } catch (e) {
        CustomSnackBar.snackBarTrigger(
          context: AppContextManager.getAppContext(),
          message: CustomExceptionHandler.getError500(),
        );
        emit(RetrieveAmbulancesInitial());
      }
    });
    on<SetRetrieveAmbulancesBlocToInitial>((event, emit) async {
      emit(RetrieveAmbulancesInitial());
    });
  }
}
