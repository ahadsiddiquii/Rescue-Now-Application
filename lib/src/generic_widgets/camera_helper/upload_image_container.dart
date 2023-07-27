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
  final String text;
  final ImageType imageType;
  final Function(File) updateImage;
  final File? image;
  final String? imageString;

  UploadImageField(
      {required this.updateImage,
      required this.imageType,
      required this.text,
      this.imageString,
      this.image,
      Key? key})
      : super(key: key);

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
                    radius: Radius.circular(6),
                    borderType: BorderType.RRect,
                    strokeWidth: 1,
                    padding: EdgeInsets.all(0.1),
                    color: DecorationConstants.kGreySecondaryTextColor,
                    dashPattern: [10, 10],
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 3),
                      alignment: Alignment.center,
                      width: ScreenConfig.screenSizeWidth * 0.43,
                      height: 125,
                      decoration: BoxDecoration(
                        color: DecorationConstants.kTextFieldBackgroundColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.touch_app_outlined,
                            color: DecorationConstants.kGreySecondaryTextColor,
                            size: 25,
                          ),
                          RescueNowText(
                            'Tap here to take a picture',
                            maxLines: 3,
                            style: ScreenConfig.theme.textTheme.headline5!
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
          style: ScreenConfig.theme.textTheme.headline5,
        ),
      ],
    );
  }
}
