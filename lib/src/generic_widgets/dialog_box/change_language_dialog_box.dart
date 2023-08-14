import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/screen_config.dart';
import '../../customer_module/customer_home/customer_main_screen.dart';
import '../../master_ui_module/main_screen/main_screen.dart';
import '../../resources/blocs/master_blocs/user_resources/user_provider_helper.dart';
import '../../resources/blocs/navigation_bar_resources/navigation_bar_bloc.dart';
import '../../resources/blocs/translation_resources/translation_bloc.dart';
import '../../resources/localization/global_translation.dart';
import '../add_height.dart';
import '../buttons/wide_button.dart';
import '../text_widget.dart';

class ChangeLanguageDialog extends StatelessWidget {
  const ChangeLanguageDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: RescueNowText(
        'Change Language',
        needsTranslation: true,
        style: ScreenConfig.theme.textTheme.displayMedium!.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          WideButton(
            onPressed: () {
              BlocProvider.of<TranslationBloc>(context).add(SwitchLanguage(
                  language: translations.getLocationCodeByName(
                languageName: 'English',
              )));

              Future.delayed(const Duration(milliseconds: 500), () {
                final userRole = UserProviderHelper.getRoleFromState(context);
                Navigator.pop(context);
                Navigator.of(context).popUntil((route) => route.isFirst);

                if (userRole == 'Customer') {
                  BlocProvider.of<NavigationBarBloc>(context)
                      .add(ChangeScreenInNavigationBar(
                    indexOfItem: 0,
                    role: 'Customer',
                  ));
                  Navigator.of(context).pushReplacementNamed(
                    CustomerMainScreen.routeName,
                  );
                } else {
                  BlocProvider.of<NavigationBarBloc>(context)
                      .add(ChangeScreenInNavigationBar(
                    indexOfItem: 0,
                    role: 'Driver',
                  ));
                  Navigator.of(context).pushReplacementNamed(
                    MainScreen.routeName,
                  );
                }
              });
            },
            buttonText: 'English',
          ),
          const AddHeight(0.01),
          WideButton(
            onPressed: () {
              BlocProvider.of<TranslationBloc>(context).add(SwitchLanguage(
                  language: translations.getLocationCodeByName(
                languageName: 'اردو',
              )));

              Future.delayed(const Duration(milliseconds: 500), () {
                final userRole = UserProviderHelper.getRoleFromState(context);
                Navigator.pop(context);
                Navigator.of(context).popUntil((route) => route.isFirst);

                if (userRole == 'Customer') {
                  BlocProvider.of<NavigationBarBloc>(context)
                      .add(ChangeScreenInNavigationBar(
                    indexOfItem: 0,
                    role: 'Customer',
                  ));
                  Navigator.of(context).pushReplacementNamed(
                    CustomerMainScreen.routeName,
                  );
                } else {
                  BlocProvider.of<NavigationBarBloc>(context)
                      .add(ChangeScreenInNavigationBar(
                    indexOfItem: 0,
                    role: 'Driver',
                  ));
                  Navigator.of(context).pushReplacementNamed(
                    MainScreen.routeName,
                  );
                }
              });
            },
            buttonText: 'Urdu',
          ),
        ],
      ),
    );
  }
}
