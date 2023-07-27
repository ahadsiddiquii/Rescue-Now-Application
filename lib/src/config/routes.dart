import 'package:flutter/material.dart';

import '../customer_module/register_customer.dart';
import '../driver_module/register_driver.dart';
import '../master_ui_module/main_screen/main_screen.dart';
import '../master_ui_module/otp_screen.dart';
import '../master_ui_module/phone_number_screen/enter_phone_number_screen.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  EnterPhoneNumberScreen.routeName: (BuildContext ctx) =>
      const EnterPhoneNumberScreen(),
  OtpVerificationScreen.routeName: (BuildContext ctx) =>
      const OtpVerificationScreen(),
  RegisterCustomerScreen.routeName: (BuildContext ctx) =>
      const RegisterCustomerScreen(),
  RegisterDriverScreen.routeName: (BuildContext ctx) =>
      const RegisterDriverScreen(),
  MainScreen.routeName: (BuildContext ctx) => const MainScreen(),
};
