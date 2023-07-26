import 'package:flutter_bloc/flutter_bloc.dart';

import '../app_context_manager.dart';
import '../blocs/master_blocs/user_resources/user_bloc.dart';
import '../models/user.dart';
import 'user_firestore_service.dart';

class UserFirestoreServiceHelper {
  static final UserFirestoreService _userFirestoreService =
      UserFirestoreService();

  static Future<bool> checkIfUserExists({
    required String phoneNumber,
    required String userRole,
  }) async {
    bool userFound = false;
    try {
      BlocProvider.of<UserBloc>(AppContextManager.getAppContext()).add(
        MakeUserLoad(),
      );
      final User? user = await _userFirestoreService.loginUser(
        phoneNumber: phoneNumber,
        userRole: userRole,
      );
      if (user != null) {
        userFound = true;
        BlocProvider.of<UserBloc>(AppContextManager.getAppContext()).add(
          MakeUserLoggedIn(
            user: user,
          ),
        );
      } else {
        userFound = false;
        BlocProvider.of<UserBloc>(AppContextManager.getAppContext()).add(
          ResetStateToUserInitial(),
        );
      }
      return userFound;
    } catch (e) {
      print(e.toString());
      return userFound;
    }
  }
}
