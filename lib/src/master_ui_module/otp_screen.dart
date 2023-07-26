import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../config/screen_config.dart';
import '../generic_widgets/add_height.dart';
import '../generic_widgets/buttons/wide_button.dart';
import '../generic_widgets/circular_progress_indicator.dart';
import '../generic_widgets/custom_snackbar.dart';
import '../generic_widgets/initial_padding.dart';
import '../generic_widgets/rescue_now_appbar.dart';
import '../generic_widgets/text_widget.dart';
import '../resources/blocs/master_blocs/user_resources/user_bloc.dart';
import '../ui_config/decoration_constants.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({Key? key}) : super(key: key);
  static const String routeName = '/otp_screen';

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  String? otpCode;

  late TextEditingController otpController;
  bool hasError = false;

  String userPhoneNumber = '03000000000';
  String userRole = 'Customer';
  bool disableButton = true;
  //bloc variables for this screen
  var thisScreenMainState;
  late UserBloc thisScreenMainBloc;

  @override
  void initState() {
    super.initState();
    thisScreenMainBloc = BlocProvider.of<UserBloc>(context);
    thisScreenMainState = thisScreenMainBloc.state;
    otpController = TextEditingController();
  }

  Widget _buildEnterOTPtext() {
    return RescueNowText(
      'To complete verification please enter the 4 digit activation code',
      style: Theme.of(context).textTheme.headline5!,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildOTPText() {
    return RescueNowText(
      'We have sent an OTP verification code to the number $userPhoneNumber',
      forceStrutHeight: false,
      style: Theme.of(context).textTheme.headline5!.copyWith(
            color: DecorationConstants.kGreySecondaryTextColor,
          ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildProceedButton() {
    var state = BlocProvider.of<UserBloc>(context).state;

    if (state is UserLoading) {
      return RescueNowCircularProgressIndicator();
    }

    return WideButton(
      disableButton: disableButton,
      onPressed: () => onPressed(),
      buttonText: 'Proceed',
    );
  }

  void onPressed() {
    if (otpController.text == '2090') {
      BlocProvider.of<UserBloc>(context).add(
        LoginOrRegister(
          phoneNumber: userPhoneNumber,
          userRole: userRole,
        ),
      );
    } else {
      CustomSnackBar.snackBarTrigger(
        context: context,
        message: 'Invalid OTP',
      );
    }
  }

  Widget _buildOTPTextFields() {
    return SizedBox(
      width: ScreenConfig.screenSizeWidth * 0.65,
      child: PinCodeTextField(
        backgroundColor: Colors.transparent,
        autoDismissKeyboard: true,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        appContext: context,
        length: 4,
        obscureText: false,
        animationType: AnimationType.fade,
        inputFormatters: [
          LengthLimitingTextInputFormatter(4),
          FilteringTextInputFormatter.allow(
            RegExp(r'^\d+(?:\d+)?$'),
          ),
        ],
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          activeColor: DecorationConstants.kTextFieldBackgroundColor,
          inactiveColor: DecorationConstants.kTextFieldBackgroundColor,
          borderRadius: BorderRadius.circular(6),
          fieldHeight: 48,
          fieldWidth: 48,
          selectedColor: DecorationConstants.kTextFieldBackgroundColor,
          activeFillColor: DecorationConstants.kTextFieldBackgroundColor,
          selectedFillColor: DecorationConstants.kTextFieldBackgroundColor,
          inactiveFillColor: DecorationConstants.kTextFieldBackgroundColor,
        ),
        cursorColor: Colors.black,
        animationDuration: Duration(milliseconds: 300),
        enableActiveFill: true,
        controller: otpController,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value!.length != 4) {}
          return null;
        },
        onCompleted: (value) {
          if (value.length == 4) {
            setState(() {
              disableButton = false;
            });
            return;
          }
          disableButton = true;
        },
        onChanged: (value) {
          print(value);
          if (value.length == 4) {
            setState(() {
              disableButton = false;
            });
          }
        },
        beforeTextPaste: (text) {
          print("Allowing to paste $text");
          if (double.tryParse(text!) != null)
            return true;
          else {
            return false;
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> argumentsOfOtpScreen =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    userPhoneNumber = argumentsOfOtpScreen['userPhoneNumber'] as String;
    userRole = argumentsOfOtpScreen['userRole'] as String;

    return Scaffold(
        appBar: RescueNowAppBar(
          isHamburger: false,
          titleText: 'Otp Verification',
          centerTitle: false,
          showActions: false,
          showBackButton: true,
          onTap: () {
            Navigator.pop(context);
          },
        ),
        body: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            // print('THE STATE ON LISTENERR');
            // print(state);
            // if (state is UserLoggedIn) {
            //   // final userStatusState = getUserStatusStates(state.user);
            //   // if (isToggleButtonEnabled(userStatusState)) {
            //   //Todo: set when login
            //   // LoadeAppBarStatus().setAppBarStatus(true);
            //   // }
            //   popUntilHomeScreen(context);
            // } else if (state is UserEnterDetails) {
            //   Navigator.of(context)
            //       .pushReplacementNamed(DriverDetailsScreen.route);
            // } else if (state is UserVerificationError) {
            //   CustomSnackBar.snackBarTrigger(
            //     context: context,
            //     message: state.error,
            //     needsTranslation: false,
            //   );
            // }
          },
          builder: (context, state) {
            return InitScreen(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildOTPText(),
                  const AddHeight(0.05),
                  _buildEnterOTPtext(),
                  const AddHeight(0.02),
                  _buildOTPTextFields(),
                  const Spacer(),
                  _buildProceedButton(),
                ],
              ),
            );
          },
        ));
  }
}
