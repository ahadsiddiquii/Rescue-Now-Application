import 'package:flutter/material.dart';

import '../ui_config/decoration_constants.dart';

class RescueNowCircularProgressIndicator extends StatelessWidget {
  const RescueNowCircularProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Center(
          child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          DecorationConstants.kThemeColor,
        ),
      )),
    );
  }
}
