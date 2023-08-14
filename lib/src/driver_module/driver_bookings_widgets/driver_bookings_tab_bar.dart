import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/screen_config.dart';
import '../../generic_widgets/circular_progress_indicator.dart';
import '../../generic_widgets/order_widgets/order_tile.dart';
import '../../generic_widgets/text_widget.dart';
import '../../resources/blocs/driver_bookings_resources/driver_bookings_bloc.dart';
import '../../resources/models/order.dart';

class DriverBookingsTabBarView extends StatelessWidget {
  const DriverBookingsTabBarView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverBookingsBloc, DriverBookingsState>(
      builder: (context, driverBookingsBlocState) {
        if (driverBookingsBlocState is RetrievedAllDriverBookings) {
          return SizedBox(
            height: ScreenConfig.screenSizeHeight * 0.65,
            child: TabBarView(
              children: [
                _SingleTabBarViewCustomerBookings(
                  showOrders: driverBookingsBlocState.activeOrders,
                ),
                _SingleTabBarViewCustomerBookings(
                  showOrders: driverBookingsBlocState.pastOrders,
                ),
              ],
            ),
          );
        } else if (driverBookingsBlocState is RetrievingDriverBookings) {
          return SizedBox(
            height: ScreenConfig.screenSizeHeight * 0.65,
            child: const TabBarView(
              children: [
                Center(
                  child: RescueNowCircularProgressIndicator(),
                ),
                Center(
                  child: RescueNowCircularProgressIndicator(),
                ),
              ],
            ),
          );
        } else {
          return SizedBox(
            height: ScreenConfig.screenSizeHeight * 0.65,
            child: TabBarView(
              children: [
                Center(
                  child: RescueNowText(
                    'You have no emergencies',
                    needsTranslation: true,
                    style: ScreenConfig.theme.textTheme.headlineSmall!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                Center(
                  child: RescueNowText(
                    'You have no emergencies',
                    needsTranslation: true,
                    style: ScreenConfig.theme.textTheme.headlineSmall!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}

class _SingleTabBarViewCustomerBookings extends StatelessWidget {
  const _SingleTabBarViewCustomerBookings({
    Key? key,
    required this.showOrders,
  }) : super(key: key);
  final List<Emergency> showOrders;

  @override
  Widget build(BuildContext context) {
    if (showOrders.isNotEmpty) {
      return SizedBox(
        height: ScreenConfig.screenSizeHeight * 0.65,
        width: ScreenConfig.screenSizeWidth,
        child: ListView.builder(
          itemCount: showOrders.length,
          itemBuilder: (context, index) {
            return OrderTile(
              currentWorkingOrder: showOrders[index],
            );
          },
        ),
      );
    }
    return SizedBox(
      height: ScreenConfig.screenSizeHeight * 0.65,
      width: ScreenConfig.screenSizeWidth,
      child: Center(
        child: RescueNowText(
          'You have no emergencies',
          needsTranslation: true,
          style: ScreenConfig.theme.textTheme.headlineSmall!
              .copyWith(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
