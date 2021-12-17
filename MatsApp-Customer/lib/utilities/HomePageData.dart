class HomePageData {
  var homeData;

  var homePageData;
  HomePageData([this.homeData]);

  String get gethomePageData => homePageData;
  // Using the setter method
  // to set the input
  set setLatitude(var homeData1) {
    this.homePageData = homeData1;
  }
}

class gethomedata {
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
