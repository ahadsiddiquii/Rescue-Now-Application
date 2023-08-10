import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../generic_widgets/rescue_now_appbar.dart';
import '../../resources/app_context_manager.dart';
import '../../resources/blocs/customer_bookings/customer_bookings_bloc.dart';
import '../../resources/blocs/master_blocs/user_resources/user_provider_helper.dart';
import '../../ui_config/decoration_constants.dart';
import 'customer_bookings_widgets/customer_bookings_tab_bar_view.dart';

class CustomerBookingsScreen extends StatefulWidget {
  const CustomerBookingsScreen({Key? key}) : super(key: key);

  @override
  State<CustomerBookingsScreen> createState() => _CustomerBookingsScreenState();
}

class _CustomerBookingsScreenState extends State<CustomerBookingsScreen> {
  late Timer timer;

  @override
  void initState() {
    super.initState();
    AppContextManager.setAppContext(context);
    final String? userId = UserProviderHelper.getUserIdFromState(context);
    if (userId != null) {
      BlocProvider.of<CustomerBookingsBloc>(context).add(
        GetAllCustomerOrders(
          userid: userId,
        ),
      );
      timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        BlocProvider.of<CustomerBookingsBloc>(context).add(
          RefreshAllCustomerOrders(
            userid: userId,
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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: RescueNowAppBar(
          titleText: 'Your Emergencies',
          isHamburger: false,
          backgroundColor: Colors.grey.shade100,
        ),
        body: const Center(
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
                  Tab(text: 'Searching'),
                  Tab(text: 'Current'),
                  Tab(text: 'Past'),
                ],
              ),
              CustomerBookingsTabBarView(),
            ],
          ),
        ),
      ),
    );
  }
}
