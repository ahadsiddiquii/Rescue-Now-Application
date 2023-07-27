// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:

import '../../config/screen_config.dart';
import '../../ui_config/decoration_constants.dart';

class ImageUploadedContainer extends StatelessWidget {
  final File? image;
  final String? stringImage;
  const ImageUploadedContainer({this.stringImage, this.image, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: ScreenConfig.screenSizeWidth * 0.43,
      height: 125,
      decoration: BoxDecoration(
        color: DecorationConstants.kTextFieldBackgroundColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: image != null
            ? Image.file(
                image!,
                fit: BoxFit.cover,
                width: ScreenConfig.screenSizeWidth * 0.43,
                height: 125,
              )
            : Image.network(
                stringImage!,
                fit: BoxFit.cover,
                width: ScreenConfig.screenSizeWidth * 0.43,
                height: 125,
              ),
      ),
    );
  }
}
