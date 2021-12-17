import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:matsapp/Modeles/SqlLiteTableDataModel.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class userData {
  List<UserInfo> user;

  DatabaseHelper dbHelper = new DatabaseHelper();

  SharedPreferences prefs;

  var homePageData;
  Future<String> get getApiKey async {
    user = await dbHelper.getAll();
    return user.first.apitoken;
  }

  Future<int> getUserId() async {
    user = await dbHelper.getAll();
    return user.first.userid;
  }

  Future<String> getMobileNo() async {
    user = await dbHelper.getAll();
    return user.first.mobilenumber;
  }

  Future<String> getSelectedTown() async {
    user = await dbHelper.getAll();
    return user.first.selectedTown;
  }

  Future<String> getLocation() async {
    user = await dbHelper.getAll();
    return user.first.location;
  }

  Future<String> getSelectedState() async {
    user = await dbHelper.getAll();
    return user.first.state;
  }

  Future<String> getSelectedDistrict() async {
    user = await dbHelper.getAll();
    return user.first.district;
  }

  Future<String> get getMyLatitude async {
    prefs = await SharedPreferences.getInstance();

    String lat = prefs.getString('LATITUDE') ?? "0";
    return lat;
  }

  Future get getHomeData async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Map<String, dynamic> map = json.decode(prefs.getString('key'));
    var m = json.decode(prefs.getString('key'));
    return m;
  }

  Future<String> get getMyLogitude async {
    prefs = await SharedPreferences.getInstance();

    String logi = prefs.getString('LONGITUDE') ?? "0";

    return logi;
  }

  // getStringFromSF() async {
  //   SharedPreferences prefs1 = await SharedPreferences.getInstance();
  //   var map = json.decode(prefs1.getString('key'));
  //   print("DJDDDJJDDJJDJDJJDJDJJDJD$map");
  //   return map;
  // }

  static var homedata;
  getStringFromSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Map<String, dynamic> map = json.decode(prefs.getString('key'));
    var m = json.decode(prefs.getString('key'));
    print("dataaas565666666666666666666666666666$m");
    return m;
  }
}

class FireBaseData {
  final String fireBToken;
  FireBaseData(this.fireBToken);

  // Using the getter
  // method to take input
  String get geekFireBaseToken {
    return fireBToken;
  }

  // set fireBaseToken(String token) {
  //   this.fireBToken = token;
  // }
}
