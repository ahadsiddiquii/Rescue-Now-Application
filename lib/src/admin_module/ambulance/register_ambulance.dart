import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/custom_text_formatter.dart';
import '../../generic_widgets/add_height.dart';
import '../../generic_widgets/buttons/wide_button.dart';
import '../../generic_widgets/camera_helper/camera_helper.dart';
import '../../generic_widgets/camera_helper/image_error_message.dart';
import '../../generic_widgets/camera_helper/upload_image_container.dart';
import '../../generic_widgets/circular_progress_indicator.dart';
import '../../generic_widgets/drop_downs/drop_down_lists.dart';
import '../../generic_widgets/drop_downs/rescue_now_dropdown.dart';
import '../../generic_widgets/initial_padding.dart';
import '../../generic_widgets/rescue_now_appbar.dart';
import '../../generic_widgets/rescue_now_text_field.dart';
import '../../generic_widgets/text_field_label.dart';
import '../../resources/blocs/ambulance_resources/ambulance_bloc.dart';
import '../../resources/blocs/retrieve_ambulance_resources/retrieve_ambulances_bloc.dart';
import '../../resources/localization/global_translation.dart';
import '../../ui_config/decoration_constants.dart';

class RegisterAmbulanceScreen extends StatefulWidget {
  const RegisterAmbulanceScreen({Key? key}) : super(key: key);
  static const String routeName = '/register_ambulance_screen';

  @override
  State<RegisterAmbulanceScreen> createState() =>
      _RegisterAmbulanceScreenState();
}

class _RegisterAmbulanceScreenState extends State<RegisterAmbulanceScreen> {
  final GlobalKey<FormState> _ambulanceRegistrationFormKey =
      GlobalKey<FormState>();

  bool showVehicleImageError = false;
  bool showRegImageError = false;
  File? vehicleFront, vehicleBack, regFront, regBack;
  String? vehicleF, vehicleB, regF, regB;

  TextEditingController plateNumberController = TextEditingController();
  String _selectedEquippedValue = 'Equipped';
  String _selectedSizeValue = 'Big';
  Future<String?> convertFileToBase64(File? image) async {
    String? imageBase64;
    if (image != null) {
      List<int> imageBytes = await image.readAsBytes();
      imageBase64 = base64Encode(imageBytes);
    }
    return imageBase64;
  }

  Future<void> submit() async {
    if (vehicleFront == null) {
      setState(() {
        showVehicleImageError = true;
      });
    }
    if (regFront == null) {
      setState(() {
        showRegImageError = true;
      });
    }

    //show all image errors
    if (_ambulanceRegistrationFormKey.currentState!.validate() &&
        showVehicleImageError == false &&
        showRegImageError == false) {
      _ambulanceRegistrationFormKey.currentState!.save();

      // ignore: always_specify_types

      String? vehicleFrontImage = await convertFileToBase64(vehicleFront);
      String? regFrontImage = await convertFileToBase64(regFront);

      BlocProvider.of<AmbulanceBloc>(context).add(
        AddAmbulance(
          plateNumber: plateNumberController.text,
          vehicleImage: vehicleFrontImage!,
          registrationImage: regFrontImage!,
          equipped: _selectedEquippedValue,
          size: _selectedSizeValue,
        ),
      );
    }
  }

  Widget _updateButton() {
    return BlocConsumer<AmbulanceBloc, AmbulanceState>(
      listener: (context, state) {
        if (state is AmbulanceAdded) {
          BlocProvider.of<RetrieveAmbulancesBloc>(context)
              .add(GetAllAmbulances());
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        if (state is AmbulanceLoading) {
          return const RescueNowCircularProgressIndicator();
        }
        return WideButton(
          onPressed: () => submit(),
          buttonText: 'Proceed',
        );
      },
    );
  }

  void updateVehicleFront(File image) {
    setState(() {
      vehicleFront = image;
      vehicleF = null;
      showVehicleImageError = false;
    });
  }

  Widget _buildVehicleImageUploadSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UploadImageField(
          text: 'Vehicle front image with number plate',
          imageType: ImageType.VehicleFront,
          updateImage: updateVehicleFront,
          image: vehicleFront,
          imageString: vehicleF,
        ),
      ],
    );
  }

  void updateRegistrationFront(File image) {
    setState(() {
      regFront = image;
      regF = null;
      showRegImageError = false;
    });
  }

  Widget _buildRegistrationImageUploadSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UploadImageField(
          text: 'Vehicle registration card image',
          imageType: ImageType.RegistrationFront,
          updateImage: updateRegistrationFront,
          image: regFront,
          imageString: regF,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const RescueNowAppBar(
        titleText: 'Add Ambulance',
        isHamburger: false,
        showBackButton: true,
      ),
      body: InitScreen(
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Form(
                key: _ambulanceRegistrationFormKey,
                child: Column(children: [
                  RescueNowTextField(
                    hintText: 'ABC5351',
                    label: 'Registration number / Plate number',
                    isDirectionality: false,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                      LengthLimitingTextInputFormatter(7),
                    ],
                    controller: plateNumberController,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return translations
                            .text('Registration number is required');
                      }

                      if (val.length < 6) {
                        return translations
                            .text('Enter a valid registration number');
                      }

                      return null;
                    },
                  ),
                  AddHeight(DecorationConstants.kWidgetSecondaryDistanceHeight),
                  TextFieldLabel(
                    labelText: 'Ambulance Size',
                    onTap: () {},
                  ),
                  AddHeight(DecorationConstants.kWidgetSecondaryDistanceHeight),
                  RescueNowDropdown(
                    selectedItem: _selectedSizeValue,
                    onChange: (String? newValue) {
                      setState(() {
                        _selectedSizeValue = newValue!;
                      });
                    },
                    dropdownList: DropdownLists.ambulanceSizesList,
                  ),
                  AddHeight(DecorationConstants.kWidgetSecondaryDistanceHeight),
                  TextFieldLabel(
                    labelText: '${translations.text('Is Ambulance Equipped')}?',
                    needsTranslation: false,
                    onTap: () {},
                  ),
                  AddHeight(DecorationConstants.kWidgetSecondaryDistanceHeight),
                  RescueNowDropdown(
                    selectedItem: _selectedEquippedValue,
                    onChange: (String? newValue) {
                      setState(() {
                        _selectedEquippedValue = newValue!;
                      });
                    },
                    dropdownList: DropdownLists.ambulanceEquipmentList,
                  ),
                  AddHeight(DecorationConstants.kWidgetSecondaryDistanceHeight),
                  TextFieldLabel(
                    labelText: 'Vehicle Image',
                    onTap: () {},
                  ),
                  AddHeight(DecorationConstants.kWidgetSecondaryDistanceHeight),
                  _buildVehicleImageUploadSection(),
                  if (showVehicleImageError) ...[
                    AddHeight(
                        DecorationConstants.kWidgetSecondaryDistanceHeight -
                            0.01),
                    const ImageErrorMessage(),
                  ],
                  AddHeight(DecorationConstants.kWidgetSecondaryDistanceHeight),
                  TextFieldLabel(
                    labelText: 'Registration Image',
                    onTap: () {},
                  ),
                  AddHeight(DecorationConstants.kWidgetSecondaryDistanceHeight),
                  _buildRegistrationImageUploadSection(),
                  if (showRegImageError) ...[
                    AddHeight(
                        DecorationConstants.kWidgetSecondaryDistanceHeight -
                            0.01),
                    const ImageErrorMessage(),
                  ],
                  AddHeight(DecorationConstants.kWidgetDistanceHeight),
                  const Spacer(),
                  _updateButton(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
