import 'package:geolocator/geolocator.dart';

class UserLocation {
  Future<Position> getCurrentLocation() async {
    bool servideEnabled = await Geolocator.isLocationServiceEnabled();
    if (!servideEnabled) {
      return Future.error('Location Services Are Disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are denied forever.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
