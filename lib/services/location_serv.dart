import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
  Future<String> getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Error', "Location services are disabled");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      Get.snackbar("error", "location permissions are denied");
      return "";
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
        "error",
        "location permissions are denied forever we cant request permissions",
      );
      return "";
    }

    final pos = await Geolocator.getCurrentPosition();
    final places = await placemarkFromCoordinates(pos.latitude, pos.longitude);

    final location =
        "${places.first.name}, ${places.first.locality}, ${places.first.country}";
    return location;
  }
}
