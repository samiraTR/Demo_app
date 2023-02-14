import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

double? lat;

double? long;

String address = "";

class Location {
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  getLatLong() {
    Future<Position> data = _determinePosition();
    data.then((value) {
      lat = value.latitude;
      long = value.longitude;

      // print(lat);

      getAddress(value.latitude, value.longitude);
    }).catchError((error) {
      print("Error $error");
    });

    return [lat, long];
  }

  getAddress(lat, long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);

    address = placemarks[0].street! + " " + placemarks[0].country!;
  }
}
