// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../ui_config/decoration_constants.dart';

class InitScreen extends StatelessWidget {
  const InitScreen({
    Key? key,
    required this.child,
    this.horizontalPadding = DecorationConstants.kInitScreenHorizontalPadding,
    this.verticalPadding = DecorationConstants.kInitScreenVerticalPadding,
  }) : super(key: key);

  final Widget child;
  final double horizontalPadding;
  final double verticalPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      child: child,
    );
  }
}
