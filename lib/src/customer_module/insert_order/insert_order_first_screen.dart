import 'package:flutter/material.dart';

import '../../config/screen_config.dart';
import '../../generic_widgets/add_height.dart';
import '../../generic_widgets/rescue_now_appbar.dart';
import '../../generic_widgets/text_widget.dart';
import '../../ui_config/decoration_constants.dart';
import 'select_hospital.dart';

class InsertOrderFirstScreen extends StatelessWidget {
  const InsertOrderFirstScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);
  static const String routeName = '/insert_order_first_screen';
  final String userId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RescueNowAppBar(
        isHamburger: false,
        titleText: 'Select Condition',
        showBackButton: true,
        onBackTap: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _TileOfCategories(
              title:
                  "An immediate response is required, it's a life threatening condition, such as cardiac or respiratory arrest etc",
              emergencyLevel: 'MAX',
              userId: userId,
            ),
            const AddHeight(0.01),
            _TileOfCategories(
              title:
                  'A serious condition, such as stroke or chest pain, required rapid assessment and/or urgent transport',
              emergencyLevel: 'HIGH',
              userId: userId,
            ),
            const AddHeight(0.01),
            _TileOfCategories(
              title:
                  'An urgent problem, such as an uncomplicated diabetic issue, which requires treatment and transport to an acute setting',
              emergencyLevel: 'MEDIUM',
              userId: userId,
            ),
            const AddHeight(0.01),
            _TileOfCategories(
              title:
                  'A non-urgent problem, such as stable clinical cases, which requires transportation to a hospital ward or clinic',
              emergencyLevel: 'LOW',
              userId: userId,
            ),
            const AddHeight(0.01),
          ],
        ),
      ),
    );
  }
}

class _TileOfCategories extends StatelessWidget {
  const _TileOfCategories({
    Key? key,
    required this.title,
    required this.emergencyLevel,
    required this.userId,
  }) : super(key: key);
  final String title;
  final String emergencyLevel;
  final String userId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SelectHospital(
              userId: userId,
              emergencyLevel: emergencyLevel,
              stress: title,
            ),
          ),
        );
      },
      child: Container(
        decoration: DecorationConstants.containerDecorationCondition,
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
                  ),
                  const AddHeight(
                    0.01,
                  ),
                  RescueNowText(
                    'Emergency level: $emergencyLevel',
                    style: ScreenConfig.theme.textTheme.titleLarge!.copyWith(
                      color: DecorationConstants.kRedColor,
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
