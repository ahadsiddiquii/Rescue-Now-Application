import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'config/screen_config.dart';
import 'ui_config/decoration_constants.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox.expand(
          child: Padding(
            padding: EdgeInsets.all(
              DecorationConstants.kInitScreenHorizontalPadding +
                  ScreenConfig.screenSizeWidth * 0.1,
            ),
            child: Lottie.asset(
              '${DecorationConstants.animationPath}splash_animation.json',
              repeat: false,
            ),
          ),
        ));
  }
}
