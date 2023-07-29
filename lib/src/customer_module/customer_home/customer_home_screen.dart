import 'package:flutter/material.dart';

import '../../config/screen_config.dart';
import '../../generic_widgets/add_height.dart';
import '../../generic_widgets/initial_padding.dart';
import '../../generic_widgets/text_widget.dart';
import '../../ui_config/decoration_constants.dart';
import 'customer_home_widgets/customer_home_appbar.dart';
import 'customer_home_widgets/sos_display.dart';

class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomerHomeAppBar(),
      body: InitScreen(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AddHeight(
                DecorationConstants.kWidgetDistanceHeight - 0.01,
              ),
              SizedBox(
                width: ScreenConfig.screenSizeWidth * 0.7,
                child: RescueNowText(
                  'Are you in emergency?',
                  style: Theme.of(context).textTheme.headline3?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              AddHeight(
                DecorationConstants.kWidgetDistanceHeight - 0.01,
              ),
              SizedBox(
                width: ScreenConfig.screenSizeWidth * 0.7,
                child: RescueNowText(
                  'Press the button below help will reach you soon.',
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: DecorationConstants.kGreySecondaryTextColor,
                        fontWeight: FontWeight.w600,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              AddHeight(
                DecorationConstants.kWidgetDistanceHeight - 0.01,
              ),
              SosDisplay(),
            ],
          ),
        ),
      ),
    );
  }
}
