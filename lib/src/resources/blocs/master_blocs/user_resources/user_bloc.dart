import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../config/globals.dart';
import '../../../../generic_widgets/custom_snackbar.dart';
import '../../../app_context_manager.dart';
import '../../../custom_exception_handler.dart';
import '../../../firestore_services.dart/user_firestore_service.dart';
import '../../../firestore_services.dart/user_firestore_service_helper.dart';
import '../../../models/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    final userFirestoreService = UserFirestoreService();
    on<CheckIfLoggedIn>((
      CheckIfLoggedIn event,
      Emitter<UserState> emit,
    ) async {
      try {
        await Future.delayed(const Duration(seconds: 5));
        final prefs = await SharedPreferences.getInstance();
        if (!prefs.containsKey('user')) {
          emit(UserInitial());
        } else {
          final String? userId = prefs.getString('user');
          if (userId != null) {
            final User? user = await userFirestoreService.getUserById(
              userId: userId,
            );
            if (user != null) {
              emit(UserLoggedIn(
                user: user,
              ));
            } else {
              emit(UserInitial());
            }
          } else {
            emit(UserInitial());
          }
        }
      } catch (e) {
        CustomSnackBar.snackBarTrigger(
          context: AppContextManager.getAppContext(),
          message: CustomExceptionHandler.getError500(),
        );
        emit(UserInitial());
      }
    });
    on<LoginOrRegister>((
      LoginOrRegister event,
      Emitter<UserState> emit,
    ) async {
      try {
        emit(UserLoading());

        final User? user = await userFirestoreService.addUser(
          phoneNumber: event.phoneNumber,
          userRole: event.userRole,
          userData: event.userData,
        );
        final bool isSaved =
            await UserFirestoreServiceHelper.saveUserIdToPreferences(user!.id);
        print('User Id is Saved:$isSaved');
        CustomSnackBar.snackBarTrigger(
          context: AppContextManager.getAppContext(),
          message: 'Successfully Logged In',
        );

        emit(UserLoggedIn(user: user));
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
      final bool isSaved =
          await UserFirestoreServiceHelper.saveUserIdToPreferences(
              event.user.id);
      print('User Id is Saved:$isSaved');
      emit(UserLoggedIn(
        user: event.user,
      ));
    });

    on<LogoutUser>((
      event,
      emit,
    ) async {
      Globals.logout(
        AppContextManager.getAppContext(),
      );
    });
  }
}
