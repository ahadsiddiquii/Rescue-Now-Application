import 'package:flutter/material.dart';

import '../../config/screen_config.dart';
import '../../generic_widgets/add_height.dart';
import '../../generic_widgets/text_widget.dart';
import '../../ui_config/decoration_constants.dart';
import '../ambulance/ambulance_list.dart';
import '../hospital/hospital_list.dart';
import 'admin_home_widgets.dart';

class AdminHomeDisplay extends StatelessWidget {
  const AdminHomeDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AdminDecoratedContainer(
              onTap: () {
                print('RACING');
              },
              animatedDecoration: true,
            ),
            AdminDecoratedContainer(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  AmbulanceListScreen.routeName,
                );
              },
              child: SizedBox(
                width: ScreenConfig.screenSizeWidth * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Image.asset(
                        '${DecorationConstants.imagePath}ambulance_image.png',
                      ),
                    ),
                    AddHeight(DecorationConstants.kWidgetDistanceHeight),
                    RescueNowText(
                      'Manage Ambulances',
                      textAlign: TextAlign.center,
                      style: ScreenConfig.theme.textTheme.titleLarge?.copyWith(
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        AddHeight(DecorationConstants.kWidgetDistanceHeight + 0.03),
        Row(
          children: [
            AdminDecoratedContainer(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  HospitalListScreen.routeName,
                );
              },
              backgroundColor: const Color.fromARGB(255, 212, 241, 213),
              child: SizedBox(
                width: ScreenConfig.screenSizeWidth * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Image.asset(
                        '${DecorationConstants.imagePath}hospital_image.png',
                      ),
                    ),
                    AddHeight(DecorationConstants.kWidgetDistanceHeight),
                    RescueNowText(
                      'Manage Hospitals',
                      textAlign: TextAlign.center,
                      style: ScreenConfig.theme.textTheme.titleLarge?.copyWith(
                        color: Colors.black,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}