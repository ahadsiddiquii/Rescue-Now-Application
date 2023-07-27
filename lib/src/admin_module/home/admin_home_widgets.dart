import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../config/screen_config.dart';
import '../../ui_config/decoration_constants.dart';

class AdminDecoratedContainer extends StatelessWidget {
  const AdminDecoratedContainer({
    Key? key,
    this.animatedDecoration = false,
    this.child,
    required this.onTap,
  }) : super(key: key);
  final bool animatedDecoration;
  final Widget? child;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: ScreenConfig.screenSizeWidth * 0.4,
        height: ScreenConfig.screenSizeHeight * 0.3,
        alignment: Alignment.center,
        decoration: animatedDecoration
            ? BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Shadow color
                    spreadRadius: 2, // Spread radius of the shadow
                    blurRadius: 5, // Blur radius of the shadow
                    offset: Offset(3, 5), // Offset of the shadow
                  ),
                ],
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(
                      10), // Custom radius for the top-left corner
                  topRight: Radius.circular(
                      30), // Custom radius for the top-right corner
                  bottomLeft: Radius.circular(
                      50), // Custom radius for the bottom-left corner
                  bottomRight: Radius.circular(
                      20), // Custom radius for the bottom-right corner
                ),
              )
            : BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Shadow color
                    spreadRadius: 2, // Spread radius of the shadow
                    blurRadius: 5, // Blur radius of the shadow
                    offset: Offset(-3, 5), // Offset of the shadow
                  ),
                ],
                color: Colors.red.shade100,
                borderRadius: BorderRadius.all(
                  Radius.circular(10), // Custom radius for the top-left corner
                ),
              ),
        child: animatedDecoration
            ? LottieBuilder.asset(
                '${DecorationConstants.animationPath}car_moving.json',
                repeat: true,
              )
            : child ?? SizedBox(),
      ),
    );
  }
}
