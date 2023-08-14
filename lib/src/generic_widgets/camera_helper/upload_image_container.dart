import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../config/screen_config.dart';
import '../../ui_config/decoration_constants.dart';
import '../add_height.dart';
import '../text_widget.dart';
import 'camera_helper.dart';
import 'image_uploaded_container.dart';

class UploadImageField extends StatefulWidget {
  const UploadImageField(
      {required this.updateImage,
      required this.imageType,
      required this.text,
      this.imageString,
      this.image,
      Key? key})
      : super(key: key);
  final String text;
  final ImageType imageType;
  final Function(File) updateImage;
  final File? image;
  final String? imageString;

  @override
  State<UploadImageField> createState() => _UploadImageFieldState();
}

class _UploadImageFieldState extends State<UploadImageField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
            onTap: () {
              showCameraModalSheet(
                  context, widget.imageType, widget.updateImage);
            },
            child: widget.image == null && widget.imageString == null
                ? DottedBorder(
                    radius: const Radius.circular(6),
                    borderType: BorderType.RRect,
                    padding: const EdgeInsets.all(0.1),
                    color: DecorationConstants.kGreySecondaryTextColor,
                    dashPattern: const [10, 10],
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      alignment: Alignment.center,
                      width: ScreenConfig.screenSizeWidth * 0.43,
                      height: 125,
                      decoration: BoxDecoration(
                        color: DecorationConstants.kTextFieldBackgroundColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.touch_app_outlined,
                            color: DecorationConstants.kGreySecondaryTextColor,
                            size: 25,
                          ),
                          RescueNowText(
                            'Tap here to take a picture',
                            needsTranslation: true,
                            maxLines: 3,
                            style: ScreenConfig.theme.textTheme.headlineSmall!
                                .copyWith(
                              color:
                                  DecorationConstants.kGreySecondaryTextColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                : ImageUploadedContainer(
                    image: widget.image,
                    stringImage: widget.imageString,
                  )),
        AddHeight(DecorationConstants.kWidgetSecondaryDistanceHeight),
        RescueNowText(
          widget.text,
          needsTranslation: true,
          style: ScreenConfig.theme.textTheme.headlineSmall,
        ),
      ],
    );
  }
}
