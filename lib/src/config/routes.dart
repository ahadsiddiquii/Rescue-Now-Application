import 'package:flutter/material.dart';

import '../master_ui_module/otp_screen.dart';
import '../master_ui_module/phone_number_screen/enter_phone_number_screen.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  EnterPhoneNumberScreen.routeName: (BuildContext ctx) =>
      const EnterPhoneNumberScreen(),
  OtpScreen.routeName: (BuildContext ctx) => const OtpScreen(),
};
