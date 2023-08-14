import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/screen_config.dart';
import '../../generic_widgets/add_height.dart';
import '../../generic_widgets/buttons/wide_button.dart';
import '../../generic_widgets/circular_progress_indicator.dart';
import '../../generic_widgets/order_widgets/order_tile.dart';
import '../../generic_widgets/rescue_divider.dart';
import '../../generic_widgets/text_widget.dart';
import '../../resources/app_context_manager.dart';
import '../../resources/blocs/driver_current_job_resources/driver_current_job_bloc.dart';
import '../../resources/blocs/driver_current_job_resources/driver_current_job_helper.dart';
import '../../resources/blocs/master_blocs/user_resources/user_bloc.dart';
import '../../resources/blocs/master_blocs/user_resources/user_provider_helper.dart';
import '../../resources/blocs/retrieve_order_resources/retrieve_order_bloc.dart';
import '../../ui_config/decoration_constants.dart';

class DriverHomeDisplay extends StatefulWidget {
  const DriverHomeDisplay({Key? key}) : super(key: key);

  @override
  State<DriverHomeDisplay> createState() => _DriverHomeDisplayState();
}

class _DriverHomeDisplayState extends State<DriverHomeDisplay> {
  late Timer timer;
  @override
  void initState() {
    super.initState();
    AppContextManager.setAppContext(context);
    final String? driverId = UserProviderHelper.getUserIdFromState(context);
    if (driverId != null) {
      BlocProvider.of<RetrieveOrderBloc>(context).add(
        GetAllUnAcceptedOrders(
          driverId: driverId,
        ),
      );

      timer = Timer.periodic(
          const Duration(
            seconds: 3,
          ), (timer) {
        print('Timer Home here');
        BlocProvider.of<RetrieveOrderBloc>(context).add(
          RefreshAllUnAcceptedOrders(
            driverId: driverId,
          ),
        );
      });
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
    return Column(
      children: [
        AddHeight(DecorationConstants.kWidgetSecondaryDistanceHeight),
        BlocBuilder<RetrieveOrderBloc, RetrieveOrderState>(
          builder: (context, state) {
            if (state is RetrievedAllUnAcceptedOrders) {
              if (state.allOrdersList.isEmpty) {
                return SizedBox(
                  height: ScreenConfig.screenSizeHeight * 0.7,
                  child: Center(
                    child: RescueNowText(
                      'No Emergencies Found',
                      style: ScreenConfig.theme.textTheme.headlineSmall,
                    ),
                  ),
                );
              }
              return SizedBox(
                height: ScreenConfig.screenSizeHeight * 0.7,
                width: ScreenConfig.screenSizeWidth,
                child: ListView.separated(
                  primary: false,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, i) {
                    return OrderTile(
                      currentWorkingOrder: state.allOrdersList[i],
                      addWidgetBottom: BlocBuilder<DriverCurrentJobBloc,
                          DriverCurrentJobState>(
                        builder: (context, driverJobState) {
                          if (driverJobState is DriverCurrentJobLoading) {
                            // return const RescueNowCircularProgressIndicator();
                          }
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              WideButton(
                                buttonWidth:
                                    ScreenConfig.screenSizeWidth * 0.42,
                                isTransparent: true,
                                onPressed: () async {
                                  final userState =
                                      BlocProvider.of<UserBloc>(context).state;
                                  if (userState is UserLoggedIn) {
                                    await DriverCurrentJobHelper
                                        .rejectCurrentJob(
                                      context,
                                      currentOrder: state.allOrdersList[i],
                                      driverId: userState.user.id,
                                    );
                                  }
                                },
                                buttonText: 'Reject',
                              ),
                              WideButton(
                                buttonWidth:
                                    ScreenConfig.screenSizeWidth * 0.42,
                                onPressed: () async {
                                  final userState =
                                      BlocProvider.of<UserBloc>(context).state;
                                  if (userState is UserLoggedIn) {
                                    await DriverCurrentJobHelper
                                        .acceptCurrentJob(
                                      context,
                                      currentOrder: state.allOrdersList[i],
                                      driverId: userState.user.id,
                                    );
                                  }
                                },
                                buttonText: 'Accept',
                              ),
                            ],
                          );
                        },
                      ),
                    );
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
              return SizedBox(
                height: ScreenConfig.screenSizeHeight * 0.7,
                child: Center(
                  child: RescueNowText(
                    'No Emergencies Found',
                    style: ScreenConfig.theme.textTheme.headlineSmall,
                  ),
                ),
              );
            }
          },
        )
      ],
    );
  }
}
