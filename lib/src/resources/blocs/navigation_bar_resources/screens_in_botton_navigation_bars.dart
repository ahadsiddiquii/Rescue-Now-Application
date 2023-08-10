import 'package:flutter/material.dart';

import '../../../customer_module/customer_home/customer_bookings_screen.dart';
import '../../../customer_module/customer_home/customer_home_screen.dart';
import '../../../customer_module/customer_home/customer_profile_screen.dart';
import '../../../driver_module/driver_bookings_screen.dart';
import '../../../driver_module/home/driver_home_display.dart';
import '../../../driver_module/home/driver_profile_screen.dart';

class ScreensInBottomBar {
  static List<Widget> customerScreensInBottomBar = [
    const CustomerHomeScreen(),
    const CustomerBookingsScreen(),
    const CustomerProfileScreen(),
  ];

  static List<Widget> driverScreensInBottomBar = [
    const DriverHomeDisplay(),
    const DriverBookingsScreen(),
    const DriverProfileScreen(),
  ];
  static List<Widget> adminScreensInBottomBar = [];
}
