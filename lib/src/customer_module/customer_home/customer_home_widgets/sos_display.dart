import 'package:flutter/material.dart';

import '../../../config/screen_config.dart';
import '../../../generic_widgets/text_widget.dart';
import '../../../ui_config/decoration_constants.dart';

class SosDisplay extends StatelessWidget {
  const SosDisplay({
    Key? key,
    this.onTap,
  }) : super(key: key);
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: CircleAvatar(
        radius: ScreenConfig.screenSizeWidth * 0.4,
        backgroundColor: Color.fromARGB(255, 248, 221, 221),
        child: CircleAvatar(
          radius: ScreenConfig.screenSizeWidth * 0.3,
          backgroundColor: Color.fromARGB(255, 233, 170, 169),
          child: Container(
            width: ScreenConfig.screenSizeWidth * 0.4,
            height: ScreenConfig.screenSizeWidth * 0.4,
            decoration: BoxDecoration(
              boxShadow: DecorationConstants.dropShadow,
              borderRadius: BorderRadius.circular(100),
              gradient: DecorationConstants.linearGradient,
            ),
            alignment: AlignmentDirectional.center,
            padding: EdgeInsets.only(
              top: ScreenConfig.screenSizeWidth * 0.05,
            ),
            child: RescueNowText(
              'SOS',
              style: Theme.of(context).textTheme.headline1?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
