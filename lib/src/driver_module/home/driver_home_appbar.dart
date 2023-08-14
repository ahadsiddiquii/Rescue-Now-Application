import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/screen_config.dart';
import '../../generic_widgets/add_height.dart';
import '../../generic_widgets/text_widget.dart';
import '../../resources/blocs/master_blocs/user_resources/user_bloc.dart';
import '../../ui_config/decoration_constants.dart';

void appBarCrossFunction(BuildContext context) {
  Navigator.pop(context);
}

class DriverHomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const DriverHomeAppBar(
      {this.onTap, this.elevation, this.leadingWidth, Key? key})
      : super(key: key);

  final VoidCallback? onTap;

  final double? elevation;

  final double? leadingWidth;

  @override
  State<DriverHomeAppBar> createState() => _DriverHomeAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 20);
}

class _DriverHomeAppBarState extends State<DriverHomeAppBar> {
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
        BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoggedIn && state.user.fullName != null) {
              return RescueNowText(
                state.user.fullName!.length > 20
                    ? '${state.user.fullName!.substring(0, 19)}...'
                    : state.user.fullName!,
                style: ScreenConfig.theme.textTheme.displayMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 2,
              );
            } else {
              return const SizedBox();
            }
          },
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
