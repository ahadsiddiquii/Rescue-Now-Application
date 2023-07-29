import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../master_ui_module/navigation_bar/rescue_now_navigation_bar.dart';
import '../../resources/app_context_manager.dart';
import '../../resources/blocs/navigation_bar_resources/navigation_bar_bloc.dart';
import '../../resources/blocs/navigation_bar_resources/screens_in_botton_navigation_bars.dart';

class CustomerMainScreen extends StatelessWidget {
  const CustomerMainScreen({Key? key}) : super(key: key);
  static const String routeName = '/customer_main_screen';

  @override
  Widget build(BuildContext context) {
    AppContextManager.setAppContext(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: BlocBuilder<NavigationBarBloc, NavigationBarState>(
        builder: (context, state) {
          if (state is NavigationBarLoaded) {
            return ScreensInBottomBar
                .customerScreensInBottomBar[state.indexOfItem];
          } else {
            return const SizedBox();
          }
        },
      ),
      bottomNavigationBar: const RescueNowNavigationBar(
        role: 'Customer',
      ),
    );
  }
}
