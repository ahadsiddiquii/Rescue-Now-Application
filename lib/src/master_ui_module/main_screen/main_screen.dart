import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../admin_module/home/admin_home.dart';
import '../../admin_module/home/admin_home_appbar.dart';
import '../../driver_module/home/driver_home_appbar.dart';
import '../../driver_module/home/driver_home_display.dart';
import '../../generic_widgets/initial_padding.dart';
import '../../generic_widgets/rescue_now_appbar.dart';
import '../../resources/app_context_manager.dart';
import '../../resources/blocs/master_blocs/user_resources/user_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const String routeName = '/main_screen';

  String getAppBarTitle(BuildContext context) {
    final UserState userState = BlocProvider.of<UserBloc>(context).state;
    if (userState is UserLoggedIn) {
      return '${userState.user.role} ${userState.user.phoneNumber}';
    } else {
      return ' ';
    }
  }

  String getUserRole(BuildContext context) {
    final UserState userState = BlocProvider.of<UserBloc>(context).state;
    if (userState is UserLoggedIn) {
      return userState.user.role;
    } else {
      return ' ';
    }
  }

  PreferredSizeWidget? getAppBar(BuildContext context) {
    if (getUserRole(context) == 'Admin') {
      return const AdminHomeAppBar();
    } else if (getUserRole(context) == 'Driver') {
      return const DriverHomeAppBar();
    }
    return RescueNowAppBar(
      titleText: getAppBarTitle(context),
      isHamburger: false,
      leadingWidth: 0,
    );
  }

  Widget getScaffoldBody(BuildContext context) {
    final String currentUserRole = getUserRole(context);
    if (currentUserRole == 'Admin') {
      return const AdminHomeDisplay();
    }
    if (currentUserRole == 'Driver') {
      return const DriverHomeDisplay();
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    AppContextManager.setAppContext(context);
    return Scaffold(
      appBar: getAppBar(context),
      body: InitScreen(
        child: getScaffoldBody(context),
      ),
    );
  }
}
