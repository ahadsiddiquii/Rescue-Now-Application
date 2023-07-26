import 'package:flutter/material.dart';

import '../config/screen_config.dart';
import '../ui_config/decoration_constants.dart';
import 'text_widget.dart';

void appBarCrossFunction(BuildContext context) {
  Navigator.pop(context);
}

class RescueNowAppBar extends StatefulWidget implements PreferredSizeWidget {
  const RescueNowAppBar(
      {required this.isHamburger,
      this.onTap,
      this.elevation,
      this.titleText,
      this.imagePath,
      this.showHomeButton,
      this.showRadioButton,
      this.centerTitle = true,
      this.leadingWidth,
      this.showBackButton = false,
      this.automaticallyImplyLeading = false,
      this.showActions = false,
      this.onBackTap,
      Key? key})
      : super(key: key);

  final VoidCallback? onTap;
  final String? titleText;
  final double? elevation;
  final bool isHamburger;
  final String? imagePath;
  final bool? showHomeButton;
  final bool? showRadioButton;
  final bool centerTitle;
  final double? leadingWidth;
  final bool showBackButton;
  final VoidCallback? onBackTap;
  final bool showActions;
  final bool automaticallyImplyLeading;

  @override
  State<RescueNowAppBar> createState() => _RescueNowAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _RescueNowAppBarState extends State<RescueNowAppBar> {
  Widget? titleDecision() {
    if (widget.titleText == null && widget.imagePath == null) {
      return null;
    }
    if (widget.titleText == null && widget.imagePath != null) {
      return Image.asset(
        widget.imagePath!,
        height: 36,
      );
    }
    return RescueNowText(
      widget.titleText!,
      style: ScreenConfig.theme.textTheme.headline2!.copyWith(
        fontWeight: FontWeight.w600,
      ),
      maxLines: 2,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leadingWidth: widget.leadingWidth,

      backgroundColor: DecorationConstants.kAppBarColor,
      title: titleDecision(),
      centerTitle: widget.centerTitle,
      //  showHomeButton != null || showHomeButton == false ? true : null,
      elevation: widget.elevation,
      actions: widget.showActions
          ? [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: widget.onTap != null
                        ? widget.onTap
                        : () {
                            appBarCrossFunction(context);
                          },
                    child: Icon(
                      widget.isHamburger
                          ? Icons.menu_rounded
                          : Icons.close_rounded,
                      color: Colors.grey.shade800,
                      size: 30,
                    )),
              ),
            ]
          : [],

      leading: widget.showBackButton
          ? Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: widget.onBackTap == null
                    ? () => Navigator.of(context).pop()
                    : widget.onBackTap,
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: DecorationConstants.kPrimaryTextColor,
                  size: 28,
                ),
              ),
            )
          : SizedBox(),
    );
  }
}
