import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';

import '../../config/screen_config.dart';
import '../../driver_module/order_tracking/order_tracking_main_screen.dart';
import '../../resources/blocs/master_blocs/user_resources/user_provider_helper.dart';
import '../../resources/models/order.dart';
import '../../ui_config/decoration_constants.dart';
import '../add_height.dart';
import '../text_widget.dart';

class OrderTile extends StatelessWidget {
  const OrderTile({
    Key? key,
    required this.currentWorkingOrder,
    this.addWidgetBottom,
  }) : super(key: key);
  final Emergency currentWorkingOrder;
  final Widget? addWidgetBottom;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final String? role = UserProviderHelper.getRoleFromState(context);
        if (role != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderTrackingMainScreen(
                currentOrder: currentWorkingOrder,
                isCustomer: role == 'Customer' ? true : false,
              ),
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: DecorationConstants.kDropShadowColor.withOpacity(0.5),
                blurRadius: 3,
                offset: const Offset(0, 2),
              ),
            ]),
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 15),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RescueNowText(
                'Order: ${currentWorkingOrder.id.substring(0, 13)}',
                style: ScreenConfig.theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: Colors.red,
                      width: 2,
                    )),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: RescueNowText(
                  'Emergency: ${currentWorkingOrder.emergencyLevel}',
                  style: ScreenConfig.theme.textTheme.headlineSmall!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          AddHeight(DecorationConstants.kWidgetSecondaryDistanceHeight),
          RescueNowText(
            'Dropoff Location: ${currentWorkingOrder.hospitalName}',
            style: ScreenConfig.theme.textTheme.headlineSmall,
          ),
          AddHeight(DecorationConstants.kWidgetSecondaryDistanceHeight),
          InkWell(
            onTap: () async {
              List<AvailableMap> availableMaps =
                  await MapLauncher.installedMaps;
              if (availableMaps.isNotEmpty) {
                await availableMaps.first.showDirections(
                  destination: Coords(currentWorkingOrder.dropOffLat,
                      currentWorkingOrder.dropoffLong),
                  destinationTitle: currentWorkingOrder.hospitalName,
                  origin: Coords(currentWorkingOrder.pickUpLat,
                      currentWorkingOrder.pickUpLong),
                  originTitle: 'Emergency Location',
                );
              }
            },
            child: Align(
              alignment: AlignmentDirectional.center,
              child: RescueNowText(
                'View journey on map',
                style: ScreenConfig.theme.textTheme.headlineSmall?.copyWith(
                  color: DecorationConstants.kThemeColor,
                ),
              ),
            ),
          ),
          AddHeight(DecorationConstants.kWidgetSecondaryDistanceHeight),
          RescueNowText(
            'Condition: ${currentWorkingOrder.reason}',
            style: ScreenConfig.theme.textTheme.headlineSmall,
          ),
          if (addWidgetBottom != null) ...[
            AddHeight(DecorationConstants.kWidgetSecondaryDistanceHeight),
            addWidgetBottom!,
          ] else
            AddHeight(
              DecorationConstants.kWidgetDistanceHeight,
            ),
        ]),
      ),
    );
  }
}
