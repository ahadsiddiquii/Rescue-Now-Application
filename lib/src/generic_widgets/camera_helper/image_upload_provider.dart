// Flutter imports:
import 'package:flutter/material.dart';
// Package imports:
import 'package:image_picker/image_picker.dart';

// Project imports:

class ImageUploadProvider {
  Future<XFile?> pickImage(ImageSource source, BuildContext context) async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: source,
      );
      if (pickedFile != null) {
        // if (isImageLesserThanDefinedSize(pickedFile)) {
        return pickedFile;
        // } else {
        //   imageSizeErrorDialogBox(context);
        //   throw ('Image Size Error');
        // }
      }
      return null;
    } catch (e) {
      print(e);
      throw (e.toString());
    }
  }

  Future<XFile?> captureImage(
      BuildContext context, ImageSource imageSource) async {
    try {
      print("Inside cap image");
      final XFile? pickedImage = await pickImage(imageSource, context);
      Navigator.of(context).pop();

      if (pickedImage == null) {
        return null;
      } else {
        print("checking size");
        // if (isImageLesserThanDefinedSize(pickedImage)) {
        //   print("IMAGE SIZE FINE");
        return pickedImage;
        // } else {
        //   imageSizeErrorDialogBox(context);
        //   throw ('Image Size Error');
        // }
      }
    } catch (e) {
      throw (e);
    }
  }
}
