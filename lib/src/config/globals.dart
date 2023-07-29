import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../customer_module/customer_home/customer_main_screen.dart';
import '../master_ui_module/main_screen/main_screen.dart';
import '../resources/blocs/navigation_bar_resources/navigation_bar_bloc.dart';

class Globals {
  static void mainScreenNavigationWhenNotLoggedIn(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      MainScreen.routeName,
      // ignore: always_specify_types
      (route) => false,
    );
  }

  static void customerMainScreenNavigationWhenNotLoggedIn(
      BuildContext context) {
    BlocProvider.of<NavigationBarBloc>(context).add(ChangeScreenInNavigationBar(
      indexOfItem: 0,
      role: 'Customer',
    ));
    Navigator.pushNamedAndRemoveUntil(
      context,
      CustomerMainScreen.routeName,
      // ignore: always_specify_types
      (route) => false,
    );
  }
}
