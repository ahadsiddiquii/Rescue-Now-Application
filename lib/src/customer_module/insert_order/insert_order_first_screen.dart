import 'package:flutter/material.dart';

import '../../generic_widgets/rescue_now_appbar.dart';

class InsertOrderFirstScreen extends StatelessWidget {
  const InsertOrderFirstScreen({Key? key}) : super(key: key);
  static const String routeName = '/insert_order_first_screen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: RescueNowAppBar(
        isHamburger: false,
      ),
    );
  }
}
