import 'package:flutter/material.dart';

import '../../generic_widgets/rescue_now_appbar.dart';
import '../../resources/app_context_manager.dart';
import 'enter_phone_number_body.dart';

class EnterPhoneNumberScreen extends StatelessWidget {
  const EnterPhoneNumberScreen({Key? key}) : super(key: key);
  static const String routeName = '/enter_phone_number_screen';

  @override
  Widget build(BuildContext context) {
    AppContextManager.setAppContext(context);
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: const Scaffold(
        backgroundColor: Colors.white,
        appBar: RescueNowAppBar(
          titleText: 'Login / Sign up',
          centerTitle: false,
          showActions: false,
          isHamburger: false,
          leadingWidth: 0,
        ),
        body: EnterPhoneNumberBody(),
      ),
    );
  }
}
