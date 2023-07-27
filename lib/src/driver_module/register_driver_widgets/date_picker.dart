import 'package:flutter/material.dart';

import '../../config/screen_config.dart';
import '../../ui_config/decoration_constants.dart';

Future<DateTime?> rescueNowDatePicker(
    BuildContext context, DateTime? initialDate) async {
  return await showDatePicker(
    context: context,
    initialDate: initialDate ?? DateTime.now(),
    firstDate: DateTime.now(),
    lastDate: DateTime(2099),
    initialEntryMode: DatePickerEntryMode.calendarOnly,
    builder: (context, child) {
      return Theme(
        data: ScreenConfig.theme.copyWith(
          primaryColor: DecorationConstants.kThemeColor,
          buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          colorScheme:
              ColorScheme.light(primary: DecorationConstants.kThemeColor)
                  .copyWith(
            secondary: DecorationConstants.kThemeColor,
          ),
        ),
        child: child!,
      );
    },
  );
}
