import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/screen_config.dart';
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
              Navigator.pop(context);
              // Restart.restartApp();
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
              Navigator.pop(context);
              // Restart.restartApp();
            },
            buttonText: 'Urdu',
          ),
        ],
      ),
    );
  }
}
