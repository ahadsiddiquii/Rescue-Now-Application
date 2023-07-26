import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../config/screen_config.dart';

import '../resources/blocs/master_blocs/user_resources/user_bloc.dart';
import '../ui_config/decoration_constants.dart';
import 'phone_number_screen/enter_phone_number_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    return BlocListener<UserBloc, UserState>(
      listener: (BuildContext context, UserState state) {
        if (state is UserInitial) {
          Navigator.pushNamed(context, EnterPhoneNumberScreen.routeName);
        }
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SizedBox.expand(
            child: Padding(
              padding: EdgeInsets.all(
                DecorationConstants.kInitScreenHorizontalPadding +
                    ScreenConfig.screenSizeWidth * 0.1,
              ),
              child: LottieBuilder.asset(
                '${DecorationConstants.animationPath}splash_animation.json',
                repeat: false,
              ),
            ),
          )),
    );
  }
}
