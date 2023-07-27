import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '../../ui_config/decoration_constants.dart';
import '../add_height.dart';
import '../bottom_sheets/rescue_now_bottom_modal_sheet.dart';
import '../buttons/wide_button.dart';
import 'image_upload_repository.dart';

enum ImageType {
  profilePic,
  CnicFront,
  CnicBack,
  LicenseFront,
  LicenseBack,
  VehicleFront,
  VehicleBack,
  RegistrationFront,
  RegistrationBack,
}

ImageUploadRepository repo = ImageUploadRepository();

showCameraModalSheet(
    BuildContext context, ImageType imgType, Function(File) updatePicture) {
  _imageSourceButtonFunction(ImageSource imgSrc) async {
    //var _provider = BlocProvider.of<ImageUploadBloc>(context);
    var isImageCorrect =
        await repo.captureImage(context, imgSrc, imgType, updatePicture);

    if (!isImageCorrect) {
      return;
    }

    //_provider.add(UploadImage(context, imgSrc, imgType));
  }

  return rescueNowModalBottomSheet(
      givePadding: true,
      context: context,
      widgets: [
        AddHeight(
          DecorationConstants.kWidgetSecondaryDistanceHeight,
        ),
        WideButton(
          onPressed: () {
            _imageSourceButtonFunction(ImageSource.camera);
          },
          buttonText: 'Take Picture',
          isBottomPadding: false,
        ),
        AddHeight(
          DecorationConstants.kWidgetSecondaryDistanceHeight,
        ),
        WideButton(
          onPressed: () {
            _imageSourceButtonFunction(ImageSource.gallery);
          },
          buttonText: 'Upload From Gallery',
          isTransparent: true,
        ),
      ]);
}
