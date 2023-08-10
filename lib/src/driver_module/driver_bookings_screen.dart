import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../resources/app_context_manager.dart';
import '../resources/blocs/driver_bookings_resources/driver_bookings_bloc.dart';
import '../resources/blocs/master_blocs/user_resources/user_provider_helper.dart';
import '../ui_config/decoration_constants.dart';
import 'driver_bookings_widgets/driver_bookings_tab_bar.dart';

class DriverBookingsScreen extends StatelessWidget {
  const DriverBookingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppContextManager.setAppContext(context);
    final String? userId = UserProviderHelper.getUserIdFromState(context);
    if (userId != null) {
      BlocProvider.of<DriverBookingsBloc>(context).add(
        GetAllDriverOrders(
          userid: userId,
        ),
      );
    }
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // appBar: RescueNowAppBar(
        //   titleText: 'Your Emergencies',
        //   isHamburger: false,
        //   backgroundColor: Colors.grey.shade100,
        // ),
        body: Center(
          child: Column(
            children: [
              TabBar(
                labelPadding:
                    EdgeInsets.symmetric(horizontal: 16.0), // Add padding
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    width: 2.0,
                    color: DecorationConstants.kThemeColor,
                  ),
                ),
                tabs: [
                  Tab(text: 'Active'),
                  Tab(text: 'Past'),
                ],
              ),
              DriverBookingsTabBarView(),
            ],
          ),
        ),
      ),
    );
  }
}
