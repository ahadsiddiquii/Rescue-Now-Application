import 'package:flutter/material.dart';

import '../../config/globals.dart';
import '../../config/screen_config.dart';
import '../../generic_widgets/add_height.dart';
import '../../generic_widgets/dialog_box/change_language_dialog_box.dart';
import '../../generic_widgets/text_widget.dart';
import '../../ui_config/decoration_constants.dart';
import '../ambulance/ambulance_list.dart';
import '../hospital/hospital_list.dart';
import 'admin_home_widgets.dart';

class AdminHomeDisplay extends StatelessWidget {
  const AdminHomeDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AddHeight(DecorationConstants.kWidgetDistanceHeight),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        needsTranslation: true,
                        textAlign: TextAlign.center,
                        style:
                            ScreenConfig.theme.textTheme.titleLarge?.copyWith(
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                        needsTranslation: true,
                        textAlign: TextAlign.center,
                        style:
                            ScreenConfig.theme.textTheme.titleLarge?.copyWith(
                          color: Colors.black,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              AdminDecoratedContainer(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const ChangeLanguageDialog();
                    },
                  );
                },
                backgroundColor: const Color.fromARGB(255, 252, 124, 107),
                child: SizedBox(
                  width: ScreenConfig.screenSizeWidth * 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: ScreenConfig.screenSizeHeight * 0.1,
                        width: ScreenConfig.screenSizeWidth * 0.3,
                        child: Image.asset(
                          '${DecorationConstants.imagePath}translation_image.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      AddHeight(DecorationConstants.kWidgetDistanceHeight),
                      RescueNowText(
                        'Change Language',
                        needsTranslation: true,
                        textAlign: TextAlign.center,
                        style:
                            ScreenConfig.theme.textTheme.titleLarge?.copyWith(
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AdminDecoratedContainer(
                onTap: () {
                  Globals.logout(
                    context,
                  );
                },
                backgroundColor: const Color.fromARGB(255, 247, 214, 193),
                child: SizedBox(
                  width: ScreenConfig.screenSizeWidth * 0.3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        child: Image.asset(
                          '${DecorationConstants.imagePath}logout_image.png',
                        ),
                      ),
                      AddHeight(DecorationConstants.kWidgetDistanceHeight),
                      RescueNowText(
                        'Logout',
                        needsTranslation: true,
                        textAlign: TextAlign.center,
                        style:
                            ScreenConfig.theme.textTheme.titleLarge?.copyWith(
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
        ],
      ),
    );
  }
}
