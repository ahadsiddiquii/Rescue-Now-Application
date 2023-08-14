import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../config/screen_config.dart';
import '../../generic_widgets/add_height.dart';
import '../../generic_widgets/buttons/wide_button.dart';
import '../../generic_widgets/initial_padding.dart';
import '../../generic_widgets/rescue_now_text_field.dart';
import '../../generic_widgets/text_widget.dart';
import '../../resources/localization/global_translation.dart';
import '../../resources/models/user.dart';
import '../../ui_config/decoration_constants.dart';
import '../otp_screen.dart';
import 'user_role_dropdown.dart';

class EnterPhoneNumberBody extends StatefulWidget {
  const EnterPhoneNumberBody({Key? key}) : super(key: key);

  @override
  State<EnterPhoneNumberBody> createState() => _EnterPhoneNumberBodyState();
}

class _EnterPhoneNumberBodyState extends State<EnterPhoneNumberBody> {
  final _mobileFormKey = GlobalKey<FormState>();
  bool disableButton = true;
  String phoneNumber = '';
  String _selectedItem = 'Patient';
  TextEditingController phoneNumberController = TextEditingController();

  bool showError = false;

  String? errorText;

  bool isSubmitting = false;

  void submit() {
    isSubmitting = true;

    if (_mobileFormKey.currentState!.validate()) {
      _mobileFormKey.currentState!.save();
      final String mobileNum = '0$phoneNumber';

      // ignore: always_specify_types
      final Map<String, dynamic> objectsToPass = {
        'userPhoneNumber': mobileNum,
        'userRole': UserRoles.userRolesDatabaseMap[_selectedItem],
      };
      Navigator.of(context)
          .pushNamed(OtpVerificationScreen.routeName, arguments: objectsToPass);
    }
  }

  Widget _buildOTPText() {
    return RescueNowText(
      'We will send you an OTP on your number for verification',
      needsTranslation: true,
      style: Theme.of(context).textTheme.headlineSmall!.copyWith(
            color: DecorationConstants.kGreySecondaryTextColor,
          ),
    );
  }

  Widget _buildProceedButton() {
    return WideButton(
      disableButton: disableButton,
      onPressed: () => submit(),
      buttonText: 'Proceed',
    );
  }

  @override
  Widget build(BuildContext context) {
    return InitScreen(
      child: Form(
        key: _mobileFormKey,
        child: Column(
          children: [
            Directionality(
              textDirection: TextDirection.ltr,
              child: RescueNowTextField(
                controller: phoneNumberController,
                label: 'Enter Mobile Number',
                hintText: '300 0000000',
                keyboadType: TextInputType.phone,
                isMobileField: true,
                onEditingComplete: () {
                  _mobileFormKey.currentState!.validate();
                },
                onChanged: (val) {
                  isSubmitting = false;
                  if (val.isNotEmpty &&
                      val.length == 10 &&
                      val.startsWith('3')) {
                    setState(() {
                      disableButton = false;
                    });
                  } else if (!disableButton) {
                    setState(() {
                      disableButton = true;
                    });
                  }
                },
                //onFieldSubmitted: (_) => submit(),
                onSaved: (val) => phoneNumber = val!.trim(),
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    setState(() {
                      showError = true;
                      errorText = translations.text('Enter you phone number');
                      return;
                    });
                  }
                  if (!(val!.startsWith('3') || val.length != 10)) {
                    setState(() {
                      showError = true;
                      errorText = translations.text('Enter a valid number');
                      return;
                    });
                  }
                  showError = false;
                  errorText = null;
                  return;
                },
                inputFormatters: [
                  LengthLimitingTextInputFormatter(10),
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^\d+(?:\d+)?$'),
                  ),
                ],
              ),
            ),
            ...[
              const AddHeight(0.02),
              if (showError == true && errorText != null)
                RescueNowText(
                  errorText!,
                  style: ScreenConfig.theme.textTheme.headlineSmall,
                ),
            ],
            const AddHeight(0.01),
            UserRoleDropdown(
              selectedItem: _selectedItem,
              onChange: (String? newValue) {
                setState(() {
                  _selectedItem = newValue!;
                });
              },
            ),
            const AddHeight(0.02),
            _buildOTPText(),
            const Spacer(),
            _buildProceedButton(),
          ],
        ),
      ),
    );
  }
}
