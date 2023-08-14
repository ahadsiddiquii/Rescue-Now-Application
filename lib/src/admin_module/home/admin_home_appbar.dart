import 'package:flutter/material.dart';

import '../../config/screen_config.dart';
import '../../generic_widgets/add_height.dart';
import '../../generic_widgets/text_widget.dart';
import '../../ui_config/decoration_constants.dart';

void appBarCrossFunction(BuildContext context) {
  Navigator.pop(context);
}

class AdminHomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const AdminHomeAppBar(
      {this.onTap, this.elevation, this.leadingWidth, Key? key})
      : super(key: key);

  final VoidCallback? onTap;

  final double? elevation;

  final double? leadingWidth;

  @override
  State<AdminHomeAppBar> createState() => _AdminHomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);
}

class _AdminHomeAppBarState extends State<AdminHomeAppBar> {
  Widget titleDecision() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AddHeight(DecorationConstants.kWidgetDistanceHeight),
        RescueNowText(
          'Welcome',
          needsTranslation: true,
          style: ScreenConfig.theme.textTheme.titleLarge!.copyWith(
            color: DecorationConstants.kGreySecondaryTextColor,
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
        ),
        AddHeight(DecorationConstants.kWidgetDistanceHeight - 0.01),
        RescueNowText(
          'Admin',
          style: ScreenConfig.theme.textTheme.displayMedium!.copyWith(
            fontWeight: FontWeight.w600,
          ),
          maxLines: 2,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: kToolbarHeight + 20,
      automaticallyImplyLeading: false,
      leadingWidth: 0,
      backgroundColor: Colors.transparent,
      title: titleDecision(),
      centerTitle: false,
      elevation: widget.elevation,
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            top: 12.0,
            right: 15.0,
            left: 15.0,
          ),
          child: CircleAvatar(
            radius: ScreenConfig.screenSizeWidth * 0.05,
            backgroundColor: DecorationConstants.kThemeSecondaryColor,
            child: Image.asset(
              '${DecorationConstants.iconsPath}profile_generic_icon.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}
