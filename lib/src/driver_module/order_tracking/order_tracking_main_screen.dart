import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_launcher/map_launcher.dart';

import '../../config/screen_config.dart';
import '../../generic_widgets/add_height.dart';
import '../../generic_widgets/buttons/wide_button.dart';
import '../../generic_widgets/circular_progress_indicator.dart';
import '../../generic_widgets/initial_padding.dart';
import '../../generic_widgets/text_widget.dart';
import '../../resources/app_context_manager.dart';
import '../../resources/blocs/driver_current_job_resources/driver_current_job_bloc.dart';
import '../../resources/models/order.dart';
import '../../ui_config/decoration_constants.dart';

class OrderTrackingMainScreen extends StatefulWidget {
  const OrderTrackingMainScreen({
    Key? key,
    required this.currentOrder,
  }) : super(key: key);
  static const String routeName = '/driver_order_tracking_screen';
  final Emergency currentOrder;
  @override
  State<OrderTrackingMainScreen> createState() =>
      _OrderTrackingMainScreenState();
}

class _OrderTrackingMainScreenState extends State<OrderTrackingMainScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<DriverCurrentJobBloc>(context).add(
      GetUpdatedCurrentOrder(
        currentOrder: widget.currentOrder,
        orderId: widget.currentOrder.id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    AppContextManager.setAppContext(context);

    String getCurrentStatus(Emergency currentOrder) {
      if (currentOrder.job!.isDelivered) {
        return 'Delivered';
      }
      if (currentOrder.job!.onDropoffLocation) {
        return 'On Dropoff Location';
      }
      if (currentOrder.job!.onTripToDropoff) {
        return 'On Trip to Dropoff Location';
      }
      if (currentOrder.job!.onPickupLocation) {
        return 'On emergency Location';
      }
      return 'Going to emergency location';
    }

    return Scaffold(
      body: InitScreen(
        child: SizedBox(
          width: ScreenConfig.screenSizeWidth,
          height: ScreenConfig.screenSizeHeight,
          child: BlocBuilder<DriverCurrentJobBloc, DriverCurrentJobState>(
            builder: (context, driverCurrentJobState) {
              if (driverCurrentJobState is DriverCurrentJobAccepted) {
                return Column(
                  children: [
                    AddHeight(DecorationConstants.kWidgetDistanceHeight),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RescueNowText(
                          'Order: ${driverCurrentJobState.currentWorkingOrder.id.substring(0, 13)}',
                          style: ScreenConfig.theme.textTheme.headlineSmall
                              ?.copyWith(
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: RescueNowText(
                            'Emergency: ${driverCurrentJobState.currentWorkingOrder.emergencyLevel}',
                            style: ScreenConfig.theme.textTheme.headlineSmall!
                                .copyWith(fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    AddHeight(
                        DecorationConstants.kWidgetSecondaryDistanceHeight),
                    RescueNowText(
                      'Dropoff Location: ${driverCurrentJobState.currentWorkingOrder.hospitalName}',
                      style: ScreenConfig.theme.textTheme.headlineSmall,
                    ),
                    AddHeight(
                        DecorationConstants.kWidgetSecondaryDistanceHeight),
                    InkWell(
                      onTap: () async {
                        List<AvailableMap> availableMaps =
                            await MapLauncher.installedMaps;
                        if (availableMaps.isNotEmpty) {
                          await availableMaps.first.showDirections(
                            destination: Coords(
                                driverCurrentJobState
                                    .currentWorkingOrder.dropOffLat,
                                driverCurrentJobState
                                    .currentWorkingOrder.dropoffLong),
                            destinationTitle: driverCurrentJobState
                                .currentWorkingOrder.hospitalName,
                            origin: Coords(
                                driverCurrentJobState
                                    .currentWorkingOrder.pickUpLat,
                                driverCurrentJobState
                                    .currentWorkingOrder.pickUpLong),
                            originTitle: 'Emergency Location',
                          );
                        }
                      },
                      child: Align(
                        alignment: AlignmentDirectional.center,
                        child: RescueNowText(
                          'View journey on map',
                          style: ScreenConfig.theme.textTheme.headlineSmall
                              ?.copyWith(
                            color: DecorationConstants.kThemeColor,
                          ),
                        ),
                      ),
                    ),
                    AddHeight(
                        DecorationConstants.kWidgetSecondaryDistanceHeight),
                    RescueNowText(
                      'Condition: ${driverCurrentJobState.currentWorkingOrder.reason}',
                      style: ScreenConfig.theme.textTheme.headlineSmall,
                    ),
                    AddHeight(
                      DecorationConstants.kWidgetDistanceHeight,
                    ),
                    RescueNowText(
                      'Current Status: ${getCurrentStatus(driverCurrentJobState.currentWorkingOrder)}',
                      style: ScreenConfig.theme.textTheme.headlineSmall,
                    ),
                    AddHeight(
                      DecorationConstants.kWidgetDistanceHeight,
                    ),
                    BlocConsumer<DriverCurrentJobBloc, DriverCurrentJobState>(
                      listener: (context, driverJobState) {},
                      builder: (context, driverJobState) {
                        if (driverJobState is DriverCurrentJobLoading) {
                          return const RescueNowCircularProgressIndicator();
                        }
                        if (driverJobState is DriverCurrentJobAccepted) {
                          return WideButton(
                            onPressed: () {
                              if (driverJobState
                                  .currentWorkingOrder.job!.onDropoffLocation) {
                                BlocProvider.of<DriverCurrentJobBloc>(context)
                                    .add(UpdateCurrentOrder(
                                  currentOrder:
                                      driverCurrentJobState.currentWorkingOrder,
                                  orderId: driverCurrentJobState
                                      .currentWorkingOrder.id,
                                  onTripToDropoff: true,
                                  isDelivered: true,
                                  onDropoffLocation: true,
                                  onPickupLocation: true,
                                ));
                                return;
                              }
                              if (driverJobState
                                  .currentWorkingOrder.job!.onTripToDropoff) {
                                BlocProvider.of<DriverCurrentJobBloc>(context)
                                    .add(UpdateCurrentOrder(
                                  currentOrder:
                                      driverCurrentJobState.currentWorkingOrder,
                                  orderId: driverCurrentJobState
                                      .currentWorkingOrder.id,
                                  onTripToDropoff: true,
                                  isDelivered: false,
                                  onDropoffLocation: true,
                                  onPickupLocation: true,
                                ));
                                return;
                              }
                              if (driverJobState
                                  .currentWorkingOrder.job!.onPickupLocation) {
                                BlocProvider.of<DriverCurrentJobBloc>(context)
                                    .add(UpdateCurrentOrder(
                                  currentOrder:
                                      driverCurrentJobState.currentWorkingOrder,
                                  orderId: driverCurrentJobState
                                      .currentWorkingOrder.id,
                                  onTripToDropoff: true,
                                  isDelivered: false,
                                  onDropoffLocation: false,
                                  onPickupLocation: true,
                                ));
                                return;
                              }
                              BlocProvider.of<DriverCurrentJobBloc>(context)
                                  .add(UpdateCurrentOrder(
                                currentOrder:
                                    driverCurrentJobState.currentWorkingOrder,
                                orderId: driverCurrentJobState
                                    .currentWorkingOrder.id,
                                onTripToDropoff: false,
                                isDelivered: false,
                                onDropoffLocation: false,
                                onPickupLocation: true,
                              ));
                            },
                            buttonText: 'Update Status',
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    )
                  ],
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
