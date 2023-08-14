import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../config/globals.dart';
import '../config/screen_config.dart';
import '../generic_widgets/add_height.dart';
import '../generic_widgets/buttons/wide_button.dart';
import '../generic_widgets/camera_helper/camera_helper.dart';
import '../generic_widgets/camera_helper/image_error_message.dart';
import '../generic_widgets/camera_helper/upload_image_container.dart';
import '../generic_widgets/circular_progress_indicator.dart';
import '../generic_widgets/custom_snackbar.dart';
import '../generic_widgets/initial_padding.dart';
import '../generic_widgets/rescue_now_appbar.dart';
import '../generic_widgets/rescue_now_text_field.dart';
import '../generic_widgets/text_field_label.dart';
import '../generic_widgets/text_widget.dart';
import '../resources/app_context_manager.dart';
import '../resources/blocs/master_blocs/user_resources/user_bloc.dart';
import '../resources/custom_exception_handler.dart';
import '../resources/localization/global_translation.dart';
import '../ui_config/decoration_constants.dart';
import 'register_driver_widgets/date_picker.dart';

class RegisterDriverScreen extends StatefulWidget {
  const RegisterDriverScreen({Key? key}) : super(key: key);
  static const String routeName = '/register_driver_screen';

  @override
  State<RegisterDriverScreen> createState() => _RegisterDriverScreenState();
}

class _RegisterDriverScreenState extends State<RegisterDriverScreen> {
  final GlobalKey<FormState> _driverRegistrationFormKey =
      GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  bool showProfileImageError = false;
  File? profilePic;

  TextEditingController cnicController = TextEditingController();
  TextEditingController expiryDateCnicController = TextEditingController();
  File? cnicFront, cnicBack;
  bool showCnicImageError = false;
  String? cnicF, cnicB;
  DateTime? expiryDate;

  TextEditingController licenseController = TextEditingController();
  TextEditingController expiryDateLicenseController = TextEditingController();
  File? licenseFront, licenseBack;
  bool showLicenseImageError = false;
  String? licenseF, licenseB;
  DateTime? licenseExpiryDate;

  String? userPhoneNumber;
  String? userRole;

  Future<String?> convertFileToBase64(File? image) async {
    String? imageBase64;
    if (image != null) {
      List<int> imageBytes = await image.readAsBytes();
      imageBase64 = base64Encode(imageBytes);
    }
    return imageBase64;
  }

  Future<void> submit() async {
    if (repo.profilePicture == null) {
      setState(() {
        showProfileImageError = true;
      });
    }
    if (repo.cnicFront == null) {
      setState(() {
        showCnicImageError = true;
      });
    }
    if (repo.licenseFront == null) {
      setState(() {
        showLicenseImageError = true;
      });
    }
    //show all image errors
    if (_driverRegistrationFormKey.currentState!.validate()) {
      _driverRegistrationFormKey.currentState!.save();

      if (userPhoneNumber != null && userRole != null) {
        // ignore: always_specify_types

        String? profileImage = await convertFileToBase64(profilePic);
        String? cnicFrontImage = await convertFileToBase64(cnicFront);
        // String? cnicBackImage = await convertFileToBase64(cnicBack);
        String? licenseFrontImage = await convertFileToBase64(licenseFront);
        // String? licenseBackImage = await convertFileToBase64(licenseBack);

        final Map<String, String> userData = {
          'profileImage': profileImage!,
          'fullName': fullNameController.text,
          'email': emailController.text,
          'cnicNumber': cnicController.text,
          'cnicExpiryDate': expiryDate!.toIso8601String(),
          'cnicImageFront': cnicFrontImage!,
          // 'cnicImageBack': cnicBackImage!,
          'licenseNumber': licenseController.text,
          'licenseExpiryDate': licenseExpiryDate!.toIso8601String(),
          'licenseFrontImage': licenseFrontImage!,
          // 'licenseBackImage': licenseBackImage!,
        };
        BlocProvider.of<UserBloc>(context).add(LoginOrRegister(
          phoneNumber: userPhoneNumber!,
          userRole: userRole!,
          userData: userData,
        ));
      } else {
        CustomSnackBar.snackBarTrigger(
          context: context,
          message: CustomExceptionHandler.getError500(),
        );
      }
    }
  }

  Widget _updateButton() {
    return BlocConsumer<UserBloc, UserState>(
      listener: (BuildContext context, UserState state) {
        if (state is UserLoggedIn) {
          Globals.mainScreenNavigationWhenNotLoggedIn(context);
        }
      },
      builder: (BuildContext context, UserState state) {
        if (state is UserLoading) {
          return const RescueNowCircularProgressIndicator();
        }
        return WideButton(
          onPressed: () => submit(),
          buttonText: 'Proceed',
        );
      },
    );
  }

  void updatePfp(File image) {
    setState(() {
      profilePic = image;
      showProfileImageError = false;
    });
  }

  Widget _profilePictureSection() {
    return InkWell(
      onTap: () {
        showCameraModalSheet(context, ImageType.profilePic, updatePfp);
      },
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor:
                profilePic != null ? Colors.transparent : Colors.grey.shade200,
            backgroundImage: profilePic != null
                ? FileImage(
                    File(
                      profilePic!.path,
                    ),
                  )
                : null,
            child: profilePic == null
                ? const Icon(
                    Icons.person_3_rounded,
                    color: DecorationConstants.kThemeColor,
                  )
                : null,
          ),
          const SizedBox(
            width: 14,
          ),
          RescueNowText(
            'Upload your picture',
            needsTranslation: true,
            style: ScreenConfig.theme.textTheme.titleLarge!.copyWith(
              color: DecorationConstants.kThemeColor,
            ),
          )
        ],
      ),
    );
  }

  updateCnicFront(File image) {
    setState(() {
      cnicFront = image;
      cnicF = null;
      showCnicImageError = false;
    });
  }

  updateCnicBack(File image) {
    setState(() {
      cnicBack = image;
      cnicB = null;
      showCnicImageError = false;
    });
  }

  Widget _buildUploadCnicSection() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UploadImageField(
          text: 'CNIC Front Image',
          imageType: ImageType.CnicFront,
          updateImage: updateCnicFront,
          image: cnicFront,
          imageString: cnicF,
        ),
        // UploadImageField(
        //   text: 'Back',
        //   imageType: ImageType.CnicBack,
        //   updateImage: updateCnicBack,
        //   image: cnicBack,
        //   imageString: cnicB,
        // ),
      ],
    );
  }

  updateLicenseFront(File? licFront) {
    setState(() {
      licenseFront = licFront;
      licenseF = null;
      showLicenseImageError = false;
    });
  }

  updateLicenseBack(File? licBack) {
    setState(() {
      licenseBack = licBack;
      licenseB = null;
      showLicenseImageError = false;
    });
  }

  Widget _buildUploadLicenseSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UploadImageField(
          text: 'License Front Image',
          imageType: ImageType.LicenseFront,
          updateImage: updateLicenseFront,
          image: licenseFront,
          imageString: licenseF,
        ),
        // UploadImageField(
        //   text: 'Back',
        //   imageType: ImageType.LicenseBack,
        //   updateImage: updateLicenseBack,
        //   image: licenseBack,
        //   imageString: licenseB,
        // ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    AppContextManager.setAppContext(context);
    final Map<String, dynamic> argumentsOfOtpScreen =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    userPhoneNumber = argumentsOfOtpScreen['userPhoneNumber'] as String;
    userRole = argumentsOfOtpScreen['userRole'] as String;
    return Scaffold(
      appBar: RescueNowAppBar(
        isHamburger: false,
        titleText: 'Register Driver',
        centerTitle: false,
        showBackButton: true,
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: InitScreen(
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Form(
                key: _driverRegistrationFormKey,
                child: Column(
                  children: [
                    _profilePictureSection(),
                    if (showProfileImageError)
                      AddHeight(
                          DecorationConstants.kWidgetSecondaryDistanceHeight -
                              0.01),
                    if (showProfileImageError) const ImageErrorMessage(),
                    const AddHeight(0.03),
                    RescueNowTextField(
                      controller: fullNameController,
                      label: 'Enter full name',
                      hintText: 'John Smith',
                      textCapitalization: TextCapitalization.words,
                      keyboadType: TextInputType.text,
                      validator: (String? val) {
                        if (val == null || val.isEmpty) {
                          return translations
                              .text('Please enter your first name');
                        }
                        if (val.length < 3) {
                          return translations
                              .text('Please enter a valid first name');
                        }

                        return null;
                      },
                    ),
                    const AddHeight(0.03),
                    RescueNowTextField(
                      controller: emailController,
                      label: 'Enter email',
                      hintText: 'abc@xyz.com',
                      keyboadType: TextInputType.emailAddress,
                      validator: (String? val) {
                        if (val == null || val.isEmpty) {
                          return translations.text('Please enter your email');
                        }
                        if (val.length < 3) {
                          return translations
                              .text('Please enter a valid email');
                        }
                        if (val.length > 3) {
                          const String emailRegex =
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                          final RegExp regex = RegExp(emailRegex);
                          final bool isCorrectFormat = regex.hasMatch(val);
                          if (!isCorrectFormat) {
                            return translations.text(
                                'Please enter an email with a correct format');
                          }
                        }

                        return null;
                      },
                    ),
                    const AddHeight(0.03),
                    RescueNowTextField(
                      isDirectionality: false,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return translations.text('CNIC number is required');

                          // 'CNIC number is required';
                        }
                        if (val.length < 13) {
                          return translations.text('Enter a valid CNIC number');
                        }
                        return null;
                      },
                      hintText: '42101000000000',
                      controller: cnicController,
                      label: 'Enter CNIC number',
                      keyboadType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(13),
                      ],
                    ),
                    const AddHeight(0.03),
                    RescueNowTextField(
                      isDirectionality: false,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return translations.text('Expiry date is required');
                        }
                        return null;
                      },
                      hintText: 'mm/dd/yyyy',
                      controller: expiryDateCnicController,
                      label: 'Enter CNIC expiry date',
                      onTap: () async {
                        // Below line stops keyboard from appearing
                        FocusScope.of(context).requestFocus(FocusNode());
                        final pickedDate = await rescueNowDatePicker(
                          context,
                          expiryDate,
                        );
                        if (pickedDate != null) {
                          expiryDate = pickedDate;
                          expiryDateCnicController.text =
                              DateFormat('dd-MM-yyyy').format(expiryDate!);
                        }
                      },
                    ),
                    const AddHeight(0.03),
                    TextFieldLabel(
                      labelText: 'Upload CNIC images',
                      onTap: () {},
                    ),
                    const AddHeight(0.02),
                    _buildUploadCnicSection(),
                    if (showCnicImageError) ...[
                      AddHeight(
                          DecorationConstants.kWidgetSecondaryDistanceHeight -
                              0.01),
                      const ImageErrorMessage(),
                    ],
                    const AddHeight(0.03),
                    RescueNowTextField(
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return translations
                              .text('License number is required');
                        }
                        if (val.length < 16) {
                          return translations
                              .text('Enter a valid license number');
                        }
                        return null;
                      },
                      hintText: '42101000000000',
                      controller: licenseController,
                      label: 'Enter license number',
                      keyboadType: TextInputType.number,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(19),
                      ],
                    ),
                    const AddHeight(0.03),
                    RescueNowTextField(
                      isDirectionality: false,
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return translations.text('Expiry date is required');
                        }

                        return null;
                      },
                      hintText: 'dd/mm/yyyy',
                      controller: expiryDateLicenseController,
                      label: 'Enter expiry date',
                      onTap: () async {
                        // Below line stops keyboard from appearing
                        FocusScope.of(context).requestFocus(FocusNode());
                        final pickedDate = await rescueNowDatePicker(
                          context,
                          expiryDate,
                        );
                        if (pickedDate != null) {
                          licenseExpiryDate = pickedDate;
                          expiryDateLicenseController.text =
                              DateFormat('dd-MM-yyyy').format(expiryDate!);
                        }
                      },
                    ),
                    const AddHeight(0.03),
                    TextFieldLabel(
                      labelText: 'Upload license images',
                      onTap: () {},
                    ),
                    const AddHeight(0.02),
                    _buildUploadLicenseSection(),
                    if (showLicenseImageError) const AddHeight(0.02),
                    if (showLicenseImageError) const ImageErrorMessage(),
                    const AddHeight(0.03),
                    const Spacer(),
                    _updateButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
