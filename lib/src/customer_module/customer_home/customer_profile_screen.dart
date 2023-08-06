import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../generic_widgets/add_height.dart';
import '../../generic_widgets/profile_menu_card.dart';
import '../../generic_widgets/rescue_divider.dart';
import '../../resources/app_context_manager.dart';
import '../../resources/blocs/master_blocs/user_resources/user_bloc.dart';
import '../../ui_config/decoration_constants.dart';
import 'customer_home_widgets/customer_home_appbar.dart';

class CustomerProfileScreen extends StatelessWidget {
  const CustomerProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppContextManager.setAppContext(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: const CustomerHomeAppBar(),
      body: Center(
        child: Column(
          children: [
            AddHeight(
              DecorationConstants.kWidgetDistanceHeight - 0.01,
            ),
            const RescueDivider(),
            ProfileMenuCard(
              title: 'Logout',
              icon: Icons.logout_sharp,
              onTap: () {
                BlocProvider.of<UserBloc>(context).add(LogoutUser());
              },
            ),
            const RescueDivider(),
          ],
        ),
      ),
    );
  }
}
