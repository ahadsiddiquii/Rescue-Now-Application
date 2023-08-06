import 'dart:math';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapsUserLocationHelper {
  GoogleMapsUserLocationHelper._();
  static Future<LatLng?> getUserCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Handle the case where the user denied the permission
          print('Location permission denied');
          return null;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Handle the case where the user permanently denied the permission
        print('Location permission denied forever');
        return null;
      }

      final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      print('Current location: ${position.latitude}, ${position.longitude}');
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      print('Error: $e');
    }
    return null;
  }

  static double calculateDistance(
      double lat1, double lon1, double lat2, double lon2) {
    const p = 0.017453292519943295;
    const c = cos;
    final a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }
}
