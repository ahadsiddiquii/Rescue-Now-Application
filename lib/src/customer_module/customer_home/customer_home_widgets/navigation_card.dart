import 'package:flutter/material.dart';

import '../../../config/screen_config.dart';
import '../../../generic_widgets/add_height.dart';
import '../../../generic_widgets/text_widget.dart';
import '../../../ui_config/decoration_constants.dart';

class NavigationCard extends StatelessWidget {
  const NavigationCard({
    Key? key,
    required this.title,
    required this.text,
    this.onTap,
  }) : super(key: key);
  final String title;
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: DecorationConstants.containerDecoration,
        margin: EdgeInsets.symmetric(
          horizontal: ScreenConfig.screenSizeWidth * 0.05,
        ),
        padding: EdgeInsets.symmetric(
          vertical: ScreenConfig.screenSizeHeight * 0.02,
          horizontal: ScreenConfig.screenSizeWidth * 0.03,
        ),
        width: ScreenConfig.screenSizeWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: ScreenConfig.screenSizeWidth * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RescueNowText(
                    title,
                    style: ScreenConfig.theme.textTheme.headlineSmall!.copyWith(
                      color: DecorationConstants.kPrimaryTextColor,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                  ),
                  const AddHeight(
                    0.01,
                  ),
                  RescueNowText(
                    text,
                    style: ScreenConfig.theme.textTheme.titleLarge!.copyWith(
                      color: DecorationConstants.kGreySecondaryTextColor,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
            )
          ],
        ),
      ),
    );
  }
}
