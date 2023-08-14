// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'text_widget.dart';

class CustomSnackBar {
  CustomSnackBar._();

  static void snackBarTrigger({
    required BuildContext context,
    required String message,
  }) {
    try {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(_showSnackbar(
        message,
      ));
    } catch (e) {
      print(e);
    }
  }

  static SnackBar _showSnackbar(
    String text,
  ) {
    return SnackBar(
      content: RescueNowText(
        text,
        needsTranslation: true,
        textAlign: TextAlign.center,
      ),
      duration: const Duration(milliseconds: 2000),
      behavior: SnackBarBehavior.floating,
    );
  }
}
