import 'dart:convert';

import 'package:http/http.dart';
import 'package:matsapp/Modeles/homePageModels/HomePageModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  Future<bool> landlord;

  static var prefnew;

  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key));
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

//   Future<HomePageModel> getSavedInfo() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     // Map<String, dynamic> jsonData =
//     //     json.decode(preferences.getString("homedata")) as Map<String, dynamic>;
//     // Map<String, dynamic> userMap =
//     //     jsonDecode(preferences.getString("homedata"));
// //Map valueMap = jsonDecode(preferences.getString("homedata"));

//     var jsonStr = preferences.getString("homedata");
//        HomePageModel user = HomePageModel.fromMap(jsonStr);

//     Map<String, dynamic> d = json.decode(jsonStr.trim());
//     List<HomePageModel> list = List<HomePageModel>.from(
//         d['jsonArrayName'].map((x) => HomePageModel.fromJson(x)));
//     // Map<String, dynamic> user = jsonDecode(jsonString);
//     Map<String, dynamic> userMap =
//         jsonDecode(preferences.getString("homedata"));
//     user = HomePageModel.fromMap(userMap);

//     return user;
//   }

  Future<void> saveUserInfo(response) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = await prefs.setString('homedata', jsonEncode(response));
    print(result);
    print(result);
  }

  void savePersons(List<HomePageModel> persons) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> personsEncoded =
        persons.map((person) => jsonEncode(person.toJson())).toList();
    await sharedPreferences.setStringList('accounts', personsEncoded);
  }

  Future<HomePageModel> getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> userMap;
    final String userStr = prefs.getString('homedata');
    if (userStr != null) {
      userMap = jsonDecode(userStr) as Map<String, dynamic>;
    }

    if (userMap != null) {
      final HomePageModel user = HomePageModel.fromMap(userMap);
      print(user);
      return user;
    }
    return null;
  }

  Future<bool> persistsomeDetails(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var somevariable = prefs.setString("value", value);
    print("Some Variables$somevariable");
    return somevariable;
  }

  Future<String> getsomepersistedDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("value") ?? {};
  }
}
