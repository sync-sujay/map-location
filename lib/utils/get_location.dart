import 'package:location/location.dart';

class GetLocation {
  Location location = Location();

  bool? serviceEnabled;
  PermissionStatus? permissionGranted;
  LocationData? locationData;

  getLocation() async {
    serviceEnabled = await location.serviceEnabled();

    if (!serviceEnabled!) {
      serviceEnabled = await location.requestService();

      if (!serviceEnabled!) {
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

    locationData = await location.getLocation();
    return locationData;
  }
}
