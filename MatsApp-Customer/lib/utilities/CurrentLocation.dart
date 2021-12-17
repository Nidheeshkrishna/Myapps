class CurrentLocation {
  //Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  // Future<Placemark> getCurrentLocation() {
  //   geolocator
  //       .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
  //       .then((Position position) {
  //     getAddressFromLatLng();
  //   }).catchError((e) {
  //     print(e);
  //   });
  // }

  // Future getAddressFromLatLng() async {
  //   try {
  //     List<Placemark> p = await geolocator.placemarkFromCoordinates(
  //         _currentPosition.latitude, _currentPosition.longitude);

  //     Placemark place = p[0];

  //     _currentAddress = "${place.locality}";

  //     return place;
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
