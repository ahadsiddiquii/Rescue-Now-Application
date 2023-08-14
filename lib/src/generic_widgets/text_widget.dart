import 'package:flutter/material.dart';

import '../resources/localization/global_translation.dart';

class RescueNowText extends StatelessWidget {
  const RescueNowText(this.text,
      {Key? key,
      this.style,
      this.textAlign,
      this.overflow,
      this.maxLines,
      this.forceStrutHeight = true,
      this.needsTranslation = false,
      this.softWrap})
      : super(key: key);
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool forceStrutHeight;
  final bool needsTranslation;
  final bool? softWrap;

  @override
  Widget build(BuildContext context) {
    return Text(
      needsTranslation ? translations.text(text) : text,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
      strutStyle: StrutStyle(
        forceStrutHeight: forceStrutHeight,
      ),
      style: style,
      softWrap: softWrap,
    );
  }
}
