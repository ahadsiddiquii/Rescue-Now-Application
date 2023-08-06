import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:map_launcher/map_launcher.dart';

import '../../config/screen_config.dart';
import '../../generic_widgets/add_height.dart';
import '../../generic_widgets/buttons/wide_button.dart';
import '../../generic_widgets/circular_progress_indicator.dart';
import '../../generic_widgets/rescue_divider.dart';
import '../../generic_widgets/text_widget.dart';
import '../../resources/app_context_manager.dart';
import '../../resources/blocs/driver_current_job_resources/driver_current_job_bloc.dart';
import '../../resources/blocs/master_blocs/user_resources/user_bloc.dart';
import '../../resources/blocs/retrieve_order_resources/retrieve_order_bloc.dart';
import '../../ui_config/decoration_constants.dart';
import '../order_tracking/order_tracking_main_screen.dart';

class DriverHomeDisplay extends StatelessWidget {
  const DriverHomeDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppContextManager.setAppContext(context);
    BlocProvider.of<RetrieveOrderBloc>(context).add(
      GetAllUnAcceptedOrders(),
    );
    return Column(
      children: [
        AddHeight(DecorationConstants.kWidgetSecondaryDistanceHeight),
        BlocBuilder<RetrieveOrderBloc, RetrieveOrderState>(
          builder: (context, state) {
            if (state is RetrievedAllUnAcceptedOrders) {
              return SizedBox(
                height: ScreenConfig.screenSizeHeight * 0.7,
                width: ScreenConfig.screenSizeWidth,
                child: ListView.separated(
                  primary: false,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, i) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: DecorationConstants.kDropShadowColor
                                  .withOpacity(0.5),
                              blurRadius: 3,
                              offset: const Offset(0, 2),
                            ),
                          ]),
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RescueNowText(
                                'Order: ${state.allOrdersList[i].id.substring(0, 13)}',
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
                                  'Emergency: ${state.allOrdersList[i].emergencyLevel}',
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
                            'Dropoff Location: ${state.allOrdersList[i].hospitalName}',
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
                                      state.allOrdersList[i].dropOffLat,
                                      state.allOrdersList[i].dropoffLong),
                                  destinationTitle:
                                      state.allOrdersList[i].hospitalName,
                                  origin: Coords(
                                      state.allOrdersList[i].pickUpLat,
                                      state.allOrdersList[i].pickUpLong),
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
                            'Condition: ${state.allOrdersList[i].reason}',
                            style: ScreenConfig.theme.textTheme.headlineSmall,
                          ),
                          AddHeight(
                            DecorationConstants.kWidgetDistanceHeight,
                          ),
                          BlocConsumer<DriverCurrentJobBloc,
                              DriverCurrentJobState>(
                            listener: (context, driverJobState) {
                              if (driverJobState is DriverCurrentJobAccepted) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        OrderTrackingMainScreen(
                                      currentOrder: state.allOrdersList[i],
                                    ),
                                  ),
                                );
                              }
                            },
                            builder: (context, driverJobState) {
                              if (driverJobState is DriverCurrentJobLoading) {
                                return const RescueNowCircularProgressIndicator();
                              }
                              return WideButton(
                                onPressed: () {
                                  final userState =
                                      BlocProvider.of<UserBloc>(context).state;
                                  if (userState is UserLoggedIn) {
                                    BlocProvider.of<DriverCurrentJobBloc>(
                                            context)
                                        .add(AcceptCurrentOrder(
                                            driverId: userState.user.id,
                                            currentOrder:
                                                state.allOrdersList[i]));
                                  }
                                },
                                buttonText: 'Accept',
                              );
                            },
                          )
                        ],
                      ),
                    );

                    // return OrderTile(
                    //   jobs[i],
                    //   newJobsList.contains(jobs[i]) ? true : false,
                    // );
                  },
                  separatorBuilder: (context, i) {
                    return const RescueDivider();
                  },
                  itemCount: state.allOrdersList.length,
                ),
              );
            } else if (state is RetrievingOrders) {
              return const Center(
                child: RescueNowCircularProgressIndicator(),
              );
            } else {
              return Center(
                  child: RescueNowText(
                'No Emergencies Found',
                style: ScreenConfig.theme.textTheme.headlineSmall,
              ));
            }
          },
        )
      ],
    );
  }
}
