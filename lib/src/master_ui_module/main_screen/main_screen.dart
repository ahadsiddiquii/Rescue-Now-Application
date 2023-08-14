import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../admin_module/home/admin_home.dart';
import '../../admin_module/home/admin_home_appbar.dart';
import '../../driver_module/home/driver_home_appbar.dart';
import '../../generic_widgets/rescue_now_appbar.dart';
import '../../resources/app_context_manager.dart';
import '../../resources/blocs/master_blocs/user_resources/user_bloc.dart';
import '../../resources/blocs/navigation_bar_resources/navigation_bar_bloc.dart';
import '../../resources/blocs/navigation_bar_resources/screens_in_botton_navigation_bars.dart';
import '../navigation_bar/rescue_now_navigation_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const String routeName = '/main_screen';

  String getAppBarTitle(
    BuildContext context,
  ) {
    final UserState userState = BlocProvider.of<UserBloc>(context).state;
    if (userState is UserLoggedIn) {
      return '${userState.user.role} ${userState.user.phoneNumber}';
    } else {
      return ' ';
    }
  }

  String getUserRole(
    BuildContext context,
  ) {
    final UserState userState = BlocProvider.of<UserBloc>(context).state;
    if (userState is UserLoggedIn) {
      return userState.user.role;
    } else {
      return ' ';
    }
  }

  PreferredSizeWidget? getAppBar(
    String currentUserRole,
    BuildContext context,
  ) {
    if (currentUserRole == 'Admin') {
      return const AdminHomeAppBar();
    } else if (currentUserRole == 'Driver') {
      return const DriverHomeAppBar();
    }
    return RescueNowAppBar(
      titleText: getAppBarTitle(context),
      isHamburger: false,
      leadingWidth: 0,
    );
  }

  Widget getScaffoldBody(
    String currentUserRole,
  ) {
    if (currentUserRole == 'Admin') {
      return const AdminHomeDisplay();
    }
    if (currentUserRole == 'Driver') {
      // return const DriverHomeDisplay();
      return BlocBuilder<NavigationBarBloc, NavigationBarState>(
        builder: (context, state) {
          if (state is NavigationBarLoaded) {
            return ScreensInBottomBar
                .driverScreensInBottomBar[state.indexOfItem];
          } else {
            return const SizedBox();
          }
        },
      );
    }
    return const SizedBox();
  }

  Widget? getBottomNavigationBar(
    String currentUserRole,
  ) {
    if (currentUserRole == 'Driver') {
      return RescueNowNavigationBar(
        role: currentUserRole,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    AppContextManager.setAppContext(context);
    final String currentUserRole = getUserRole(context);

    return Scaffold(
      backgroundColor:
          currentUserRole == 'Driver' ? Colors.grey.shade100 : Colors.white,
      appBar: getAppBar(currentUserRole, context),
      body: getScaffoldBody(currentUserRole),
      bottomNavigationBar: getBottomNavigationBar(currentUserRole),
    );
  }
}
