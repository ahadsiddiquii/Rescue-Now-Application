import 'package:flutter/material.dart';

import '../master_ui_module/enter_phone_number_screen.dart';

final Map<String, Widget Function(BuildContext)> routes = {
  EnterPhoneNumberScreen.routeName: (BuildContext ctx) =>
      const EnterPhoneNumberScreen(),
};
