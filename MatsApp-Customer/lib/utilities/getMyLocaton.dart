import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetMylocation {
  String userLatitude;

  String userLogitude;

  String la;

  String lg;

  SharedPreferences prefs;

  getLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;
    //location.enableBackgroundMode(enable: true);
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    // var lcp = _locationData.latitude;
    // var lgp = _locationData.longitude;
    // SetLocation s = SetLocation();
    // la = userLatitude;
    // lg = userLogitude;
    // print("Latitudssss:$lcp");
    // print("Logitudeess:$lgp");
    prefs = await SharedPreferences.getInstance();

// set value
    if (prefs.getString('LATITUDE') != null &&
        prefs.getString('LONGITUDE') != null) {
      prefs.remove("LATITUDE");
      prefs.remove("LONGITUDE");
      prefs.setString('LATITUDE', '${_locationData.latitude}');
      prefs.setString('LONGITUDE', '${_locationData.longitude}');
    } else {
      prefs.setString('LATITUDE', '${_locationData.latitude}');
      prefs.setString('LONGITUDE', '${_locationData.longitude}');
    }

    //location.enableBackgroundMode(enable: true);
    // location.onLocationChanged.listen((LocationData currentLocation) {
    //   // Use current location
    //   la = '${currentLocation.latitude}';
    //   lg = '${currentLocation.longitude}';
    //   print("L:$la,g:$lg");
    //   if (prefs != null) {
    //     prefs.remove("LATITUDE");
    //     prefs.remove("LONGITUDE");

    //     prefs.setString('LATITUDE', '${currentLocation.latitude}');
    //     prefs.setString('LONGITUDE', '${currentLocation.longitude}');
    //   }
    // });
  }
}

class SetLocation {
  // final String lat;
  // final String log;
  String userlatitude;
  String userLogitude;

  String get myLatitude => this.userlatitude;

  set setLatitude(String lat) {
    this.userlatitude = lat;
  }

  set setLogitude(String log) {
    this.userlatitude = log;
  }

  String get myLogitude => this.userLogitude;

  void add() {}
}
