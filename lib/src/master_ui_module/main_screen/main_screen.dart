import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  Widget build(BuildContext context) {
    AppContextManager.setAppContext(context);
    return Scaffold(
      appBar: RescueNowAppBar(
        titleText: getAppBarTitle(context),
        centerTitle: true,
        showActions: false,
        isHamburger: false,
        leadingWidth: 0,
      ),
      body: InitScreen(child: Container()),
    );
  }
}
