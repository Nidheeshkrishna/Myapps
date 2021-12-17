import 'package:geolocator/geolocator.dart';
import 'package:matsapp/Modeles/SqlLiteTableDataModel.dart';

class GetCurrentLocation {
  List<UserInfo> user;
  // Creating a field
  String geekName;
  String userLat, userLog;

  Position _currentPosition;

  String userLatitude;

  String userLogitude;

  Future<Position> getCurrentLocation() async => Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.best,
              forceAndroidLocationManager: true)
          .then((Position position) {
        _currentPosition = position;

        userLatitude = '${position.latitude}';
        userLogitude = '${position.longitude}';
        setLocation s = setLocation();
        s.setLatitude = userLatitude;
        s.setLogitude = userLogitude;

        print('${position.latitude}');
        print('${position.longitude}');
        //print(' ${position.}');
        return _currentPosition;
      }).catchError((e) {
        print(e);
      });

  Future<String> get getMyLatitude async {
    String lat = '${_currentPosition.latitude}';

    return lat;
  }

  Future<String> get getMyLogitude async {
    String logi = '${_currentPosition.longitude}';

    return logi;
  }
}

class setLocation {
  // final String lat;
  // final String log;
  String userlatitude;
  String userLogitude;

  // String get myValue => _myValue;

  // set myValue(String value) {
  //   _myValue = value;
  // }
  //setLocation(this.lat, this.log);
  String get myLatitude => this.userlatitude;
  // Using the setter method
  // to set the input
  set setLatitude(String lat) {
    this.userlatitude = lat;
  }

  set setLogitude(String log) {
    this.userLogitude = log;
  }

  String get myLogitude => this.userLogitude;
  // Using the setter method
  // to set the input

  void add() {}
  Future<String> get getMyLatitude async {
    String lat = this.userlatitude;
    return lat;
  }

  Future<String> get getMyLogitude async {
    String logi = this.userLogitude;
    return logi;
  }
}
