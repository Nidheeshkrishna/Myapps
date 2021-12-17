import 'dart:async';
import 'dart:convert';

import 'dart:io';

// ignore: import_of_legacy_library_into_null_safe

import 'package:http/http.dart' as http;
import 'package:matsapp/Modeles/homePageModels/HomePageModel.dart';
import 'package:matsapp/services/app_exceptions.dart';
import 'package:matsapp/utilities/UserData.dart';
import 'package:matsapp/utilities/getMyLocaton.dart';
import 'package:matsapp/utilities/urls.dart';

int zz = 0;
Future<HomePageModel> fetchHomeData([
  String town,
  String mobile,
  String latitude,
  String longitude,
  String apikey,
]) async {
  // print("data$r,$t,$la,$lo");
  zz++;
  print("homeapi:$zz");

  try {
    GetMylocation().getLocation();

    var bodyParams = jsonEncode(<String, String>{
      'Town': await userData().getSelectedTown(),
      'Mobile': await userData().getMobileNo(),
      'Latitude': await userData().getMyLatitude,
      'Longitude': await userData().getMyLogitude,
      'api_key': await userData().getApiKey,
    });

    final http.Response response = await http.post(
      Uri.parse(Urls.homeUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: bodyParams,
    );
    // sharedPref.persistsomeDetails(response.body);

// Function to get the JSON String

    print("$bodyParams");
    if (response.statusCode == 200) {
      return HomePageModel.fromMap(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load stores');
    }
  } on TimeoutException {
    throw FetchDataException('Time Out Exception');
  } on SocketException {
    throw FetchDataException('No Internet connection');
  }
}
