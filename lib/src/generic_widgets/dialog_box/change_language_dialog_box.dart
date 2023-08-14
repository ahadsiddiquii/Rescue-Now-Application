import 'package:flutter/material.dart';

import '../../config/screen_config.dart';
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
              // Handle English button press
              Navigator.of(context).pop(); // Close the dialog
            },
            buttonText: 'English',
          ),
          const AddHeight(0.01),
          WideButton(
            onPressed: () {
              // Handle Urdu button press
              Navigator.of(context).pop(); // Close the dialog
            },
            buttonText: 'Urdu',
          ),
        ],
      ),
    );
  }
}
