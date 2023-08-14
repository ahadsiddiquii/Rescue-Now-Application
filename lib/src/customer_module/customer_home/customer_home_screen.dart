import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/screen_config.dart';
import '../../generic_widgets/add_height.dart';
import '../../generic_widgets/circular_progress_indicator.dart';
import '../../generic_widgets/text_widget.dart';
import '../../resources/app_context_manager.dart';
import '../../resources/blocs/master_blocs/user_resources/user_provider_helper.dart';
import '../../resources/blocs/order_resources/order_bloc.dart';
import '../../ui_config/decoration_constants.dart';
import '../insert_order/insert_order_first_screen.dart';
import 'customer_home_widgets/customer_home_appbar.dart';
import 'customer_home_widgets/navigation_card.dart';
import 'customer_home_widgets/sos_display.dart';

class CustomerHomeScreen extends StatelessWidget {
  const CustomerHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppContextManager.setAppContext(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomerHomeAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AddHeight(
                DecorationConstants.kWidgetDistanceHeight - 0.01,
              ),
              SizedBox(
                width: ScreenConfig.screenSizeWidth * 0.7,
                child: RescueNowText(
                  'Are you in emergency',
                  needsTranslation: true,
                  forceStrutHeight: false,
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
                  'Press the button below help will reach you soon',
                  needsTranslation: true,
                  forceStrutHeight: false,
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
              const _OrderInsertWidgets(),
              AddHeight(
                DecorationConstants.kWidgetDistanceHeight - 0.01,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OrderInsertWidgets extends StatelessWidget {
  const _OrderInsertWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, orderBlocState) {
        if (orderBlocState is OrderLoading) {
          return const RescueNowCircularProgressIndicator();
        }
        return Column(
          children: [
            SosDisplay(
              onTap: () {
                AppContextManager.setAppContext(context);
                final String? userId =
                    UserProviderHelper.getUserIdFromState(context);
                if (userId != null) {
                  BlocProvider.of<OrderBloc>(context).add(
                    InsertEmergencyOrder(
                      customerId: userId,
                      emergencyLevel: 'MAX',
                      stress: 'Unknown',
                      ambulanceSize: 'Big',
                      ambulanceEquipment: 'Equipped',
                    ),
                  );
                }
              },
            ),
            AddHeight(
              DecorationConstants.kWidgetDistanceHeight,
            ),
            NavigationCard(
              title:
                  'If you have time and you want to specify emergency details',
              text: 'Navigate by tapping here',
              onTap: () {
                // CustomSnackBar.snackBarTrigger(
                //   context: context,
                //   message: 'Coming Soon',
                // );
                final String? userId =
                    UserProviderHelper.getUserIdFromState(context);
                if (userId != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InsertOrderFirstScreen(
                        userId: userId,
                      ),
                    ),
                  );
                }
              },
            ),
            AddHeight(
              DecorationConstants.kWidgetDistanceHeight - 0.01,
            ),
          ],
        );
      },
    );
  }
}
