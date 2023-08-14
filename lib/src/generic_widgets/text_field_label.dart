import 'package:flutter/material.dart';

import '../config/screen_config.dart';
import '../ui_config/decoration_constants.dart';
import 'text_widget.dart';

class TextFieldLabel extends StatelessWidget {
  const TextFieldLabel(
      {this.onTap,
      this.showHelpme = false,
      required this.labelText,
      this.needsTranslation = true,
      Key? key})
      : super(key: key);
  final String labelText;
  final bool showHelpme;
  final VoidCallback? onTap;
  final bool needsTranslation;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RescueNowText(
          labelText,
          needsTranslation: needsTranslation,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        if (showHelpme && onTap != null)
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(
                DecorationConstants.kWideButtonBorderRadius),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 16,
                  width: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: DecorationConstants.kGreySecondaryTextColor,
                    ),
                  ),
                  child: Icon(
                    Icons.question_mark,
                    color: DecorationConstants.kGreySecondaryTextColor,
                    size: 10,
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                RescueNowText(
                  'Help Me',
                  style: ScreenConfig.theme.textTheme.titleLarge!.copyWith(
                    color: DecorationConstants.kGreySecondaryTextColor,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
