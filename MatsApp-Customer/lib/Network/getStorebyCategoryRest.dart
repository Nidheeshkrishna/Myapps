import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:matsapp/Modeles/GetAllStoresByCategoryModel.dart';
import 'package:matsapp/utilities/UserData.dart';
import 'package:matsapp/utilities/urls.dart';

Future<GetAllStoresByCategoryModel> fetchCategory([
  String town,
  String mobile,
  int category,
  String userLatitude,
  String userLongitude,
  String apikey,
]) async {
  Map data = {
    'Town': await userData().getSelectedTown(),
    'mobile': mobile,
    'Latitude': userLatitude,
    'Longitude': userLongitude,
    'Category': category,
    'api_key': apikey,
  };

  final http.Response response = await http.post(
    Uri.parse(Urls.getAllStoresByCategoryUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(data),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    var responseJson = json.decode(response.body);
    print("responseJson add: $responseJson");
    return GetAllStoresByCategoryModel.fromMap(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load Addtowislist');
  }
}

Future<GetAllStoresByCategoryModel> fetchCategory1(int category,
    [String searchKey]) async {
  Map data = {
    'Town': await userData().getSelectedTown(),
    'mobile': await userData().getMobileNo(),
    'UserLatitude': await userData().getMyLatitude,
    'UserLongitude': await userData().getMyLogitude,
    'Category': category,
    'api_key': await userData().getApiKey,
    'SearchKey': searchKey
  };

  final http.Response response = await http.post(
    Uri.parse(Urls.getAllStoresByCategoryUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(data),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    var responseJson = json.decode(response.body);
    print("responseJson add: $responseJson");
    return GetAllStoresByCategoryModel.fromMap(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load Addtowislist');
  }
}