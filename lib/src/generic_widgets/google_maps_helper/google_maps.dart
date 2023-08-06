import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../config/screen_config.dart';

class GoogleMapsDisplay extends StatelessWidget {
  GoogleMapsDisplay({
    Key? key,
    required this.onMapCreated,
    required this.selectLocation,
    required this.pickedLocation,
  }) : super(key: key);

  Function(GoogleMapController) onMapCreated;
  Function(LatLng) selectLocation;
  LatLng? pickedLocation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ScreenConfig.screenSizeHeight * 0.4,
      child: GoogleMap(
        onMapCreated: onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: LatLng(34.1688, 73.2215),
          zoom: 10.0,
        ),
        onTap: selectLocation,
        markers: pickedLocation != null
            ? {
                Marker(
                    markerId: const MarkerId('pickedLocation'),
                    position: pickedLocation!)
              }
            : {},
      ),
    );
  }
}
