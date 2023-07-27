// Flutter imports:
import 'package:flutter/material.dart';

import '../config/screen_config.dart';

class AddHeight extends StatelessWidget {
  const AddHeight(this.perc, {Key? key}) : super(key: key);
  final double perc;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenConfig.screenSizeHeight * perc,
    );
  }
}
