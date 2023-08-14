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
import '../../generic_widgets/text_widget.dart';
import '../../resources/blocs/order_resources/order_bloc.dart';
import '../../resources/google_maps_helper.dart';
import '../../resources/models/hospital.dart';
import '../../ui_config/decoration_constants.dart';

class SelectLocation extends StatefulWidget {
  const SelectLocation({
    Key? key,
    required this.userId,
    required this.emergencyLevel,
    required this.stress,
    required this.hospital,
    required this.ambulanceSize,
    required this.ambulanceEquipped,
  }) : super(key: key);
  static const String routeName = '/select_location_screen';
  final String userId;
  final String emergencyLevel;
  final String stress;
  final Hospital hospital;
  final String ambulanceSize;
  final String ambulanceEquipped;

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
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
      BlocProvider.of<OrderBloc>(context).add(
        InsertNormalOrder(
          customerId: widget.userId,
          emergencyLevel: widget.emergencyLevel,
          stress: widget.stress,
          hospital: widget.hospital,
          ambulanceSize: widget.ambulanceSize,
          ambulanceEquipped: widget.ambulanceEquipped,
          currentLat: _pickedLocation!.latitude,
          currentLong: _pickedLocation!.longitude,
        ),
      );
    }
  }

  Widget _updateButton() {
    return BlocConsumer<OrderBloc, OrderState>(
      listener: (context, state) {
        if (state is OrderAdded) {
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      },
      builder: (context, state) {
        if (state is OrderLoading) {
          return const RescueNowCircularProgressIndicator();
        }
        return WideButton(
          onPressed: () => submit(),
          buttonText: 'Proceed',
        );
      },
    );
  }

  Future<void> getCurrentLocation() async {
    LatLng? userCurrentLocation =
        await GoogleMapsUserLocationHelper.getUserCurrentLocation();
    if (userCurrentLocation != null) {
      setState(() {
        _pickedLocation = userCurrentLocation;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: RescueNowAppBar(
        isHamburger: false,
        titleText: 'Emergency Location',
        showBackButton: true,
        onBackTap: () {
          Navigator.pop(context);
        },
      ),
      body: InitScreen(
        child: CustomScrollView(
          physics: const ClampingScrollPhysics(),
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(children: [
                GoogleMapsDisplay(
                  onMapCreated: _onMapCreated,
                  pickedLocation: _pickedLocation,
                  selectLocation: _selectLocation,
                ),
                AddHeight(DecorationConstants.kWidgetSecondaryDistanceHeight),
                if (mapError) ...[
                  AddHeight(DecorationConstants.kWidgetSecondaryDistanceHeight -
                      0.01),
                  const MapsErrorMessageDisplay(),
                ],
                AddHeight(DecorationConstants.kWidgetSecondaryDistanceHeight),
                RescueNowText(
                  'Your current location is already selected if you want to change your location please tap on the map to do so',
                  needsTranslation: true,
                  style: ScreenConfig.theme.textTheme.titleLarge!.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                ),
                AddHeight(DecorationConstants.kWidgetDistanceHeight),
                const Spacer(),
                _updateButton(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
