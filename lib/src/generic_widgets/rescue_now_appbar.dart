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
      this.backgroundColor = Colors.white,
      this.needsTranslation = true,
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
  final Color backgroundColor;
  final bool needsTranslation;

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
      needsTranslation: widget.needsTranslation,
      forceStrutHeight: false,
      style: ScreenConfig.theme.textTheme.displayMedium!.copyWith(
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

      backgroundColor: widget.backgroundColor,
      title: titleDecision(),
      centerTitle: widget.centerTitle,
      //  showHomeButton != null || showHomeButton == false ? true : null,
      elevation: widget.elevation,
      actions: widget.showActions
          ? [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: widget.onTap ??
                        () {
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
                onTap: widget.onBackTap ?? () => Navigator.of(context).pop(),
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: DecorationConstants.kPrimaryTextColor,
                  size: 28,
                ),
              ),
            )
          : const SizedBox(),
    );
  }
}
