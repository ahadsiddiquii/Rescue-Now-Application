import 'package:flutter/material.dart';

import '../master_ui_module/main_screen/main_screen.dart';

class Globals {
  static void mainScreenNavigationWhenNotLoggedIn(BuildContext context) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      MainScreen.routeName,
      // ignore: always_specify_types
      (route) => false,
    );
  }
}
