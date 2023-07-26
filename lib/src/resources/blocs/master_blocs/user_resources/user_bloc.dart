import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../generic_widgets/custom_snackbar.dart';
import '../../../app_context_manager.dart';
import '../../../custom_exception_handler.dart';
import '../../../firestore_services.dart/user_firestore_service.dart';
import '../../../models/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    final _userFirestoreService = UserFirestoreService();
    on<CheckIfLoggedIn>((
      CheckIfLoggedIn event,
      Emitter<UserState> emit,
    ) async {
      await Future.delayed(Duration(seconds: 5));
      emit(UserInitial());
    });
    on<LoginOrRegister>((
      LoginOrRegister event,
      Emitter<UserState> emit,
    ) async {
      try {
        emit(UserLoading());
        final User? user = await _userFirestoreService.addUser(
          phoneNumber: event.phoneNumber,
          userRole: event.userRole,
          userData: event.userData,
        );
        CustomSnackBar.snackBarTrigger(
          context: AppContextManager.getAppContext(),
          message: 'Successfully Logged In',
        );
        emit(UserLoggedIn(user: user!));
      } catch (e) {
        CustomSnackBar.snackBarTrigger(
          context: AppContextManager.getAppContext(),
          message: CustomExceptionHandler.getError500(),
        );
        emit(UserInitial());
      }
    });

    on<ResetStateToUserInitial>((
      ResetStateToUserInitial event,
      Emitter<UserState> emit,
    ) async {
      emit(UserInitial());
    });

    on<MakeUserLoad>((
      MakeUserLoad event,
      Emitter<UserState> emit,
    ) async {
      emit(UserLoading());
    });

    on<MakeUserLoggedIn>((
      MakeUserLoggedIn event,
      Emitter<UserState> emit,
    ) async {
      CustomSnackBar.snackBarTrigger(
        context: AppContextManager.getAppContext(),
        message: 'Successfully Logged In',
      );
      emit(UserLoggedIn(
        user: event.user,
      ));
    });
  }
}
