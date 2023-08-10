import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'user_bloc.dart';

class UserProviderHelper {
  UserProviderHelper._();
  static String? getUserIdFromState(BuildContext context) {
    try {
      final userState = BlocProvider.of<UserBloc>(context).state;
      if (userState is UserLoggedIn) {
        return userState.user.id;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static String? getRoleFromState(BuildContext context) {
    try {
      final userState = BlocProvider.of<UserBloc>(context).state;
      if (userState is UserLoggedIn) {
        return userState.user.role;
      }
      return null;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
