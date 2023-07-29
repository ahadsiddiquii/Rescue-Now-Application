import 'dart:io';

import 'package:flutter/material.dart';

import '../../config/screen_config.dart';
import '../../ui_config/decoration_constants.dart';
import '../text_widget.dart';

class WideButton extends StatelessWidget {
  const WideButton({
    required this.onPressed,
    required this.buttonText,
    this.buttonHeight,
    this.buttonWidth,
    this.isTransparent = false,
    this.disableButton = false,
    this.customColor = DecorationConstants.kThemeColor,
    this.isBottomPadding = true,
    Key? key,
  }) : super(key: key);
  final String buttonText;
  final VoidCallback onPressed;
  final bool isTransparent;
  final bool disableButton;
  final Color customColor;
  final double? buttonWidth;
  final double? buttonHeight;
  final bool isBottomPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: Platform.isIOS
              ? isBottomPadding
                  ? 15.0
                  : 0
              : 0),
      child: InkWell(
        splashColor: Colors.grey,
        borderRadius:
            BorderRadius.circular(DecorationConstants.kWideButtonBorderRadius),
        onTap: disableButton ? null : onPressed,
        child: Container(
          padding: EdgeInsets.zero,
          alignment: Alignment.center,
          height: buttonHeight != null
              ? buttonHeight
              : ScreenConfig.screenSizeHeight * 0.065,
          width:
              buttonWidth != null ? buttonWidth : ScreenConfig.screenSizeWidth,
          decoration: BoxDecoration(
            gradient: (!disableButton && !isTransparent)
                ? DecorationConstants.linearGradient
                : null,
            color: disableButton
                ? Colors.grey[400]
                : isTransparent
                    ? Colors.transparent
                    : customColor.withOpacity(0.9),
            borderRadius: BorderRadius.circular(
                DecorationConstants.kWideButtonBorderRadius),
            border: isTransparent
                ? Border.all(color: DecorationConstants.kThemeColor)
                : null,
          ),
          child: RescueNowText(
            buttonText,
            style: ScreenConfig.theme.textTheme.headline5!.copyWith(
              color: disableButton
                  ? Colors.white
                  : isTransparent
                      ? DecorationConstants.kThemeColor
                      : DecorationConstants.kButtonTextColor,
            ),
          ),
        ),
      ),
    );
  }
}
