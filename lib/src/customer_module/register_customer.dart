import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../config/globals.dart';
import '../generic_widgets/add_height.dart';
import '../generic_widgets/buttons/wide_button.dart';
import '../generic_widgets/circular_progress_indicator.dart';
import '../generic_widgets/custom_snackbar.dart';
import '../generic_widgets/initial_padding.dart';
import '../generic_widgets/rescue_now_appbar.dart';
import '../generic_widgets/rescue_now_text_field.dart';
import '../resources/app_context_manager.dart';
import '../resources/blocs/master_blocs/user_resources/user_bloc.dart';
import '../resources/custom_exception_handler.dart';

class RegisterCustomerScreen extends StatefulWidget {
  const RegisterCustomerScreen({Key? key}) : super(key: key);
  static const String routeName = '/register_customer_screen';

  @override
  State<RegisterCustomerScreen> createState() => _RegisterCustomerScreenState();
}

class _RegisterCustomerScreenState extends State<RegisterCustomerScreen> {
  final GlobalKey<FormState> _customerRegistrationFormKey =
      GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String? userPhoneNumber;
  String? userRole;

  void submit() {
    if (_customerRegistrationFormKey.currentState!.validate()) {
      _customerRegistrationFormKey.currentState!.save();

      if (userPhoneNumber != null && userRole != null) {
        // ignore: always_specify_types
        final Map<String, String> userData = {
          'fullName': fullNameController.text,
          'email': emailController.text,
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
          Globals.customerMainScreenNavigationWhenNotLoggedIn(context);
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
        titleText: 'Register Customer',
        centerTitle: false,
        showActions: false,
        showBackButton: true,
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: InitScreen(
        child: Form(
          key: _customerRegistrationFormKey,
          child: Column(
            children: [
              RescueNowTextField(
                controller: fullNameController,
                label: 'Enter full name',
                hintText: 'John Smith',
                textCapitalization: TextCapitalization.words,
                keyboadType: TextInputType.text,
                validator: (String? val) {
                  if (val == null || val.isEmpty) {
                    return 'Please enter your first name';
                  }
                  if (val.length < 3) {
                    return 'Please enter a valid first name';
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
                    return 'Please enter your email';
                  }
                  if (val.length < 3) {
                    return 'Please enter a valid email';
                  }
                  if (val.length > 3) {
                    const String emailRegex =
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                    RegExp regex = RegExp(emailRegex);
                    bool isCorrectFormat = regex.hasMatch(val);
                    if (!isCorrectFormat) {
                      return 'Please enter an email with a correct format';
                    }
                  }

                  return null;
                },
              ),
              const AddHeight(0.02),
              const Spacer(),
              _updateButton(),
            ],
          ),
        ),
      ),
    );
  }
}
