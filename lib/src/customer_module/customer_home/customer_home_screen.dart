import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/screen_config.dart';
import '../../generic_widgets/add_height.dart';
import '../../generic_widgets/initial_padding.dart';
import '../../generic_widgets/text_widget.dart';
import '../../resources/app_context_manager.dart';
import '../../resources/blocs/order_resources/order_bloc.dart';
import '../../ui_config/decoration_constants.dart';
import 'customer_home_widgets/customer_home_appbar.dart';
import 'customer_home_widgets/sos_display.dart';

class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppContextManager.setAppContext(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomerHomeAppBar(),
      body: InitScreen(
        child: Center(
          child: Column(
            children: [
              AddHeight(
                DecorationConstants.kWidgetDistanceHeight - 0.01,
              ),
              SizedBox(
                width: ScreenConfig.screenSizeWidth * 0.7,
                child: RescueNowText(
                  'Are you in emergency?',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
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
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: DecorationConstants.kGreySecondaryTextColor,
                        fontWeight: FontWeight.w600,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              AddHeight(
                DecorationConstants.kWidgetDistanceHeight - 0.01,
              ),
              SosDisplay(
                onTap: () {
                  BlocProvider.of<OrderBloc>(context).add(
                    InsertEmergencyOrder(
                        emergencyLevel: 'MAX', stress: 'Unknown'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
