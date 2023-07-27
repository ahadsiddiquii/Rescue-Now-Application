// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/cupertino.dart';
// Package imports:
import 'package:image_picker/image_picker.dart';

import 'camera_helper.dart';
import 'image_upload_provider.dart';

// Project imports:

class ImageUploadRepository {
  ImageUploadProvider _imageUploadProvider = ImageUploadProvider();
  File? _cnicFront,
      _cnicBack,
      _licenseFront,
      _licenseBack,
      _registrationFront,
      _registrationBack,
      _vehicleFront,
      _vehicleBack,
      _profilePicture;

  setProfilePicture(File image) {
    _profilePicture = image;
  }

  setCnicFront(File image) {
    _cnicFront = image;
  }

  setCnicBack(File image) {
    _cnicBack = image;
  }

  setLicenseFront(File image) {
    _licenseFront = image;
  }

  setLicenseBack(File image) {
    _licenseBack = image;
  }

  setVehicleFront(File image) {
    _vehicleFront = image;
  }

  setVehicleBack(File image) {
    _vehicleBack = image;
  }

  setRegistrationFront(File image) {
    _registrationFront = image;
  }

  setRegistrationBack(File image) {
    _registrationBack = image;
  }

  get imageUploadProvider => _imageUploadProvider;

  File? get cnicFront => _cnicFront;
  File? get cnicBack => _cnicBack;
  File? get licenseFront => _licenseFront;
  File? get licenseBack => _licenseBack;
  File? get vehicleFront => _vehicleFront;
  File? get vehicleBack => _vehicleBack;
  File? get registrationFront => _registrationFront;
  File? get registrationBack => _registrationBack;
  File? get profilePicture => _profilePicture;

  Future<bool> captureImage(BuildContext context, ImageSource imageSource,
      ImageType imageType, Function(File) updatePicture) async {
    try {
      print("Inside get image");
      XFile? image =
          await _imageUploadProvider.captureImage(context, imageSource);
      print("Inside get image2");
      if (image == null) {
        return false;
      }
      if (imageType == ImageType.profilePic) {
        repo.setProfilePicture(
          File(image.path),
        );
      }
      if (imageType == ImageType.CnicFront) {
        repo.setCnicFront(
          File(image.path),
        );
      }
      if (imageType == ImageType.CnicBack) {
        repo.setCnicBack(
          File(image.path),
        );
      }
      if (imageType == ImageType.LicenseFront) {
        repo.setLicenseFront(
          File(image.path),
        );
      }
      if (imageType == ImageType.LicenseBack) {
        repo.setLicenseBack(
          File(image.path),
        );
      }
      if (imageType == ImageType.VehicleFront) {
        repo.setVehicleFront(
          File(image.path),
        );
      }
      if (imageType == ImageType.VehicleBack) {
        repo.setVehicleBack(
          File(image.path),
        );
      }
      if (imageType == ImageType.RegistrationFront) {
        repo.setRegistrationFront(
          File(image.path),
        );
      }
      if (imageType == ImageType.RegistrationBack) {
        repo.setRegistrationBack(
          File(image.path),
        );
      }
      updatePicture(File(image.path));
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
