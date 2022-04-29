import 'package:geolocator/geolocator.dart';

//this class inside funciton take a gps permission and longitude/latitude
class Location {
  double? latitude;
  double? longitude;

  Future<void> getCurrentLocation() async {
    await Geolocator.requestPermission();
    await Geolocator.checkPermission();

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      latitude = position.latitude;
      longitude = position.longitude;
      print("$latitude, $longitude");
    } catch (e) {
      print(e);
    }
  }
}
