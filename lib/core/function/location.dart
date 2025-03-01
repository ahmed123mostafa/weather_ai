

import 'package:location/location.dart';

class GetLocation {
  static Future<String> getCurrentLocation() async {
    Location location = Location();
    LocationData? locationData;
    await RequestPermission.locationPermission(location: location);
    locationData = await location.getLocation();
    return '${locationData.latitude},${locationData.longitude}';
  }
}
class RequestPermission {
  static Future<void> locationPermission({
    required Location location,
  }) async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }
}