import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_launcher/map_launcher.dart';

import '../../config/screen_config.dart';
import '../../generic_widgets/add_height.dart';
import '../../generic_widgets/buttons/wide_button.dart';
import '../../generic_widgets/circular_progress_indicator.dart';
import '../../generic_widgets/initial_padding.dart';
import '../../generic_widgets/rescue_now_appbar.dart';
import '../../generic_widgets/text_widget.dart';
import '../../resources/app_context_manager.dart';
import '../../resources/blocs/driver_bookings_resources/driver_bookings_bloc.dart';
import '../../resources/blocs/driver_current_job_resources/driver_current_job_bloc.dart';
import '../../resources/blocs/master_blocs/user_resources/user_provider_helper.dart';
import '../../resources/models/order.dart';
import '../../ui_config/decoration_constants.dart';

class OrderTrackingMainScreen extends StatefulWidget {
  const OrderTrackingMainScreen({
    Key? key,
    required this.currentOrder,
    required this.isCustomer,
  }) : super(key: key);
  static const String routeName = '/driver_order_tracking_screen';
  final Emergency currentOrder;
  final bool isCustomer;
  @override
  State<OrderTrackingMainScreen> createState() =>
      _OrderTrackingMainScreenState();
}

class _OrderTrackingMainScreenState extends State<OrderTrackingMainScreen> {
  late Timer timer;
  @override
  void initState() {
    super.initState();
    if (widget.isCustomer) {
      BlocProvider.of<DriverCurrentJobBloc>(context).add(
        GetUpdatedCurrentOrder(
          currentOrder: widget.currentOrder,
          orderId: widget.currentOrder.id,
        ),
      );
      timer = Timer.periodic(
          const Duration(
            seconds: 3,
          ), (timer) {
        print('Timer here');
        BlocProvider.of<DriverCurrentJobBloc>(context).add(
          GetUpdatedCurrentOrder(
            currentOrder: widget.currentOrder,
            orderId: widget.currentOrder.id,
          ),
        );
      });
    } else {
      BlocProvider.of<DriverCurrentJobBloc>(context).add(
        GetUpdatedCurrentOrder(
          currentOrder: widget.currentOrder,
          orderId: widget.currentOrder.id,
        ),
      );
    }
  }

  @override
  void dispose() {
    try {
      timer.cancel();
    } catch (e) {
      print(e);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppContextManager.setAppContext(context);

    String getCurrentStatus(Emergency currentOrder) {
      if (currentOrder.job != null) {
        if (widget.isCustomer) {
          if (currentOrder.job!.isDelivered) {
            return 'Get Well Soon!';
          }
          if (currentOrder.job!.onDropoffLocation) {
            return 'Reached at hospital';
          }
          if (currentOrder.job!.onTripToDropoff) {
            return 'Taking you to the hospital';
          }
          if (currentOrder.job!.onPickupLocation) {
            return 'Ambulance has arrived';
          }
          return 'Ambulance is enroute to your location';
        } else {
          if (currentOrder.job!.isDelivered) {
            return 'Dropped of the Patient';
          }
          if (currentOrder.job!.onDropoffLocation) {
            return "On Hospital's Location";
          }
          if (currentOrder.job!.onTripToDropoff) {
            return 'On Trip to Hospital';
          }
          if (currentOrder.job!.onPickupLocation) {
            return 'On emergency Location';
          }
          return 'Going to emergency location';
        }
      } else {
        if (widget.isCustomer) {
          return 'Please wait ambulance will be connected to you as soon as possible';
        } else {
          return 'Please wait';
        }
      }
    }

    String getButtonText(Emergency currentOrder) {
      if (currentOrder.job!.isDelivered) {
        return 'Close';
      }
      if (currentOrder.job!.onDropoffLocation) {
        return 'Patient Is Satisfied';
      }
      if (currentOrder.job!.onTripToDropoff) {
        return 'Reached At Hospital';
      }
      if (currentOrder.job!.onPickupLocation) {
        return 'Start Trip';
      }
      return 'Reached At Emergency Location';
    }

    return Scaffold(
      appBar: RescueNowAppBar(
        isHamburger: false,
        showBackButton: true,
        titleText: 'Order Tracking',
        onBackTap: () {
          Navigator.pop(context);
        },
      ),
      body: InitScreen(
        child: SizedBox(
          width: ScreenConfig.screenSizeWidth,
          height: ScreenConfig.screenSizeHeight,
          child: BlocBuilder<DriverCurrentJobBloc, DriverCurrentJobState>(
            builder: (context, driverCurrentJobState) {
              if (driverCurrentJobState is DriverCurrentJobAccepted) {
                return Column(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RescueNowText(
                                'Order: ${driverCurrentJobState.currentWorkingOrder.id.substring(0, 13)}',
                                style: ScreenConfig
                                    .theme.textTheme.headlineSmall
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
                                  style: ScreenConfig
                                      .theme.textTheme.headlineSmall!
                                      .copyWith(fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                          AddHeight(DecorationConstants
                              .kWidgetSecondaryDistanceHeight),
                          RescueNowText(
                            'Dropoff Location: ${driverCurrentJobState.currentWorkingOrder.hospitalName}',
                            style: ScreenConfig.theme.textTheme.headlineSmall,
                          ),
                          AddHeight(DecorationConstants
                              .kWidgetSecondaryDistanceHeight),
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
                                style: ScreenConfig
                                    .theme.textTheme.headlineSmall
                                    ?.copyWith(
                                  color: DecorationConstants.kThemeColor,
                                ),
                              ),
                            ),
                          ),
                          AddHeight(DecorationConstants
                              .kWidgetSecondaryDistanceHeight),
                          RescueNowText(
                            'Condition: ${driverCurrentJobState.currentWorkingOrder.reason}',
                            style: ScreenConfig.theme.textTheme.headlineSmall,
                          ),
                          AddHeight(
                            DecorationConstants.kWidgetDistanceHeight,
                          ),
                          RescueNowText(
                            'Current Status: ${getCurrentStatus(driverCurrentJobState.currentWorkingOrder)}',
                            style: ScreenConfig.theme.textTheme.headlineMedium
                                ?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            forceStrutHeight: false,
                            textAlign: TextAlign.center,
                          ),
                          AddHeight(
                            DecorationConstants.kWidgetDistanceHeight,
                          ),
                        ],
                      ),
                    ),
                    if (!widget.isCustomer) ...[
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
                                    .currentWorkingOrder.job!.isDelivered) {
                                  final String? userId =
                                      UserProviderHelper.getUserIdFromState(
                                          context);
                                  if (userId != null) {
                                    BlocProvider.of<DriverBookingsBloc>(context)
                                        .add(
                                      GetAllDriverOrders(
                                        userid: userId,
                                      ),
                                    );
                                  }
                                  Navigator.pop(context);
                                }
                                if (driverJobState.currentWorkingOrder.job!
                                    .onDropoffLocation) {
                                  BlocProvider.of<DriverCurrentJobBloc>(context)
                                      .add(UpdateCurrentOrder(
                                    currentOrder: driverCurrentJobState
                                        .currentWorkingOrder,
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
                                    currentOrder: driverCurrentJobState
                                        .currentWorkingOrder,
                                    orderId: driverCurrentJobState
                                        .currentWorkingOrder.id,
                                    onTripToDropoff: true,
                                    isDelivered: false,
                                    onDropoffLocation: true,
                                    onPickupLocation: true,
                                  ));
                                  return;
                                }
                                if (driverJobState.currentWorkingOrder.job!
                                    .onPickupLocation) {
                                  BlocProvider.of<DriverCurrentJobBloc>(context)
                                      .add(UpdateCurrentOrder(
                                    currentOrder: driverCurrentJobState
                                        .currentWorkingOrder,
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
                              buttonText: getButtonText(
                                  driverCurrentJobState.currentWorkingOrder),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      )
                    ]
                  ],
                );
              } else {
                return const RescueNowCircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
