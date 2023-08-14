// Flutter imports:
import 'package:flutter/material.dart';

import '../../config/screen_config.dart';
import '../../ui_config/decoration_constants.dart';
import '../text_widget.dart';

class ImageErrorMessage extends StatelessWidget {
  const ImageErrorMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: DecorationConstants.kTextFieldHorizontalContentPadding,
      ),
      child: RescueNowText(
        'Please upload image',
        needsTranslation: true,
        style: ScreenConfig.theme.textTheme.titleLarge!.copyWith(
          color: DecorationConstants.kRedColor,
        ),
      ),
    );
  }
}
