import 'package:flutter/material.dart';

import '../../../customer_module/customer_home/customer_home_screen.dart';
import '../../../customer_module/customer_home/customer_profile_screen.dart';

class ScreensInBottomBar {
  static List<Widget> customerScreensInBottomBar = [
    const CustomerHomeScreen(),
    const CustomerHomeScreen(),
    const CustomerProfileScreen(),
  ];

  static List<Widget> driverScreensInBottomBar = [];
  static List<Widget> adminScreensInBottomBar = [];
}
