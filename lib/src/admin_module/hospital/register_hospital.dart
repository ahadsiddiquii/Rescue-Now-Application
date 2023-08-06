import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../config/screen_config.dart';
import '../../generic_widgets/add_height.dart';
import '../../generic_widgets/buttons/wide_button.dart';
import '../../generic_widgets/circular_progress_indicator.dart';
import '../../generic_widgets/google_maps_helper/google_maps.dart';
import '../../generic_widgets/google_maps_helper/maps_error_message_display.dart';
import '../../generic_widgets/initial_padding.dart';
import '../../generic_widgets/rescue_now_appbar.dart';
import '../../generic_widgets/rescue_now_text_field.dart';
import '../../resources/blocs/hospital_resources/hospital_bloc.dart';
import '../../resources/blocs/retrieve_hospital_resources/retrieve_hospital_bloc.dart';
import '../../ui_config/decoration_constants.dart';

class RegisterHospitalScreen extends StatefulWidget {
  const RegisterHospitalScreen({Key? key}) : super(key: key);
  static const String routeName = '/register_hospital_screen';

  @override
  State<RegisterHospitalScreen> createState() => _RegisterHospitalScreenState();
}

class _RegisterHospitalScreenState extends State<RegisterHospitalScreen> {
  final GlobalKey<FormState> _hospitalRegistrationFormKey =
      GlobalKey<FormState>();

  TextEditingController placeNameController = TextEditingController();
  late GoogleMapController _mapController;
  LatLng? _pickedLocation;
  bool mapError = false;
  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _selectLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  Future<void> submit() async {
    //show all map errors
    if (_pickedLocation == null) {
      setState(() {
        mapError = true;
      });
    } else {
      setState(() {
        mapError = false;
      });
    }
    if (_hospitalRegistrationFormKey.currentState!.validate() &&
        mapError == false &&
        _pickedLocation != null) {
      _hospitalRegistrationFormKey.currentState!.save();

      BlocProvider.of<HospitalBloc>(context).add(AddHospital(
        placeName: placeNameController.text,
        placeLatitude: _pickedLocation!.latitude,
        placeLongitude: _pickedLocation!.longitude,
      ));
    }
  }

  Widget _updateButton() {
    return BlocConsumer<HospitalBloc, HospitalState>(
      listener: (context, state) {
        if (state is HospitalAdded) {
          BlocProvider.of<RetrieveHospitalBloc>(context).add(GetAllHospitals());
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        if (state is HospitalLoading) {
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
    return Scaffold(
      appBar: const RescueNowAppBar(
        titleText: 'Add Hospital',
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
                key: _hospitalRegistrationFormKey,
                child: Column(children: [
                  RescueNowTextField(
                    hintText: 'City Hospital',
                    label: 'Hospital Name',
                    isDirectionality: false,
                    textCapitalization: TextCapitalization.words,
                    controller: placeNameController,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Hospital name is required';
                      }

                      if (val.length < 6) {
                        return 'Enter a valid hospital name';
                      }

                      return null;
                    },
                  ),
                  AddHeight(DecorationConstants.kWidgetDistanceHeight),
                  GoogleMapsDisplay(
                    onMapCreated: _onMapCreated,
                    pickedLocation: _pickedLocation,
                    selectLocation: _selectLocation,
                  ),
                  AddHeight(DecorationConstants.kWidgetSecondaryDistanceHeight),
                  if (mapError) ...[
                    AddHeight(
                        DecorationConstants.kWidgetSecondaryDistanceHeight -
                            0.01),
                    const MapsErrorMessageDisplay(),
                  ],
                  AddHeight(DecorationConstants.kWidgetSecondaryDistanceHeight),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: WideButton(
                        buttonWidth: ScreenConfig.screenSizeWidth * 0.4,
                        buttonHeight: 30,
                        onPressed: () {
                          if (_pickedLocation != null) {
                            print(
                                'Picked Location: ${_pickedLocation!.latitude}, ${_pickedLocation!.longitude}');
                          } else {
                            print('No location selected yet');
                          }
                        },
                        buttonText: 'Select Location'),
                  ),
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
