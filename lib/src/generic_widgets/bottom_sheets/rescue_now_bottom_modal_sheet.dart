import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/screen_config.dart';
import '../../resources/blocs/master_blocs/user_resources/user_bloc.dart';
import '../../ui_config/decoration_constants.dart';

rescueNowModalBottomSheet({
  required BuildContext context,
  required List<Widget> widgets,
  bool givePadding = true,
  VoidCallback? processThenFunction,
}) {
  showModalBottomSheet(
      enableDrag: true,
      useRootNavigator: true,
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            DecorationConstants.kBottomModalSheetBorderRadius,
          ),
          topRight: Radius.circular(
            DecorationConstants.kBottomModalSheetBorderRadius,
          ),
        ),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: givePadding
                ? DecorationConstants.kInitScreenHorizontalPadding
                : 0,
            vertical: DecorationConstants.kInitScreenVerticalPadding,
          ),
          child: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  width: givePadding
                      ? ScreenConfig.screenSizeWidth -
                          (DecorationConstants.kInitScreenHorizontalPadding * 2)
                      : ScreenConfig.screenSizeWidth,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 30,
                        child: Center(
                          child: Container(
                            width: 40,
                            height: 6,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color:
                                  DecorationConstants.kGreySecondaryTextColor,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: givePadding
                            ? ScreenConfig.screenSizeWidth -
                                (DecorationConstants
                                        .kInitScreenHorizontalPadding *
                                    2)
                            : ScreenConfig.screenSizeWidth,
                        padding: EdgeInsets.symmetric(
                          horizontal: givePadding
                              ? 0
                              : DecorationConstants
                                  .kInitScreenHorizontalPadding,
                        ),
                        alignment: AlignmentDirectional.centerEnd,
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.close_rounded,
                            color: Colors.grey.shade800,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ...widgets,
              ],
            ),
          ),
        );
      }).then(
    (value) {
      if (processThenFunction != null) processThenFunction();
    },
  );
}

class RescueNowBottomModalContainer extends StatefulWidget {
  final BuildContext context;
  final List<Widget> widgets;
  final bool givePadding = true;
  RescueNowBottomModalContainer({
    Key? key,
    required this.context,
    required this.widgets,
    bool givePadding = true,
  }) : super(key: key);

  @override
  State<RescueNowBottomModalContainer> createState() =>
      _RescueNowBottomModalContainerState();
}

class _RescueNowBottomModalContainerState
    extends State<RescueNowBottomModalContainer> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoggedIn || state is UserLoading) {
          return Container(
            padding: EdgeInsets.symmetric(
              horizontal: widget.givePadding
                  ? DecorationConstants.kInitScreenHorizontalPadding
                  : 0,
              vertical: DecorationConstants.kInitScreenVerticalPadding,
            ),
            child: SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        color: Colors.black,
                        width: ScreenConfig.screenSizeWidth * 0.40,
                        //child: Spacer(),
                      ),
                      Container(
                        width: ScreenConfig.screenSizeWidth * 0.48,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 40,
                              height: 6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:
                                    DecorationConstants.kGreySecondaryTextColor,
                              ),
                            ),
                            InkWell(
                              customBorder: const CircleBorder(),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                Icons.close_rounded,
                                color: Colors.grey.shade800,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  // if (state is UserLoading)
                  //   Container(
                  //       color: Colors.transparent,
                  //       height: ScreenConfig.screenSizeHeight * 0.2,
                  //       child: GenericLoadeIconLoader()),
                  if (state is UserLoggedIn) ...widget.widgets,
                ],
              ),
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}

rescueNowNoPleaseProceedBottomSheet({
  required BuildContext context,
  required List<Widget> widgets,
  bool givePadding = true,
}) {
  showModalBottomSheet(
      enableDrag: true,
      useRootNavigator: true,
      isDismissible: false,
      isScrollControlled: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(
            DecorationConstants.kBottomModalSheetBorderRadius,
          ),
          topRight: Radius.circular(
            DecorationConstants.kBottomModalSheetBorderRadius,
          ),
        ),
      ),
      builder: (context) {
        return RescueNowBottomModalContainer(
          context: context,
          widgets: widgets,
          givePadding: givePadding,
        );
      });
}
