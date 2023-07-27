import 'package:flutter/material.dart';

class RescueDivider extends StatelessWidget {
  const RescueDivider({this.thickeness = 1, Key? key}) : super(key: key);
  final double? thickeness;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFDFE1E9),
      height: thickeness,
      width: double.infinity,
    );
  }
}
