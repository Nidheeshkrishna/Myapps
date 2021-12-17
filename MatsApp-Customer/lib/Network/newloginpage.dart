import 'package:matsapp/Modeles/Login/LoginModel.dart';

import 'package:matsapp/utilities/urls.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'package:matsapp/services/app_exceptions.dart';

Future<LoginModel> loginCustomer1(
    String username, String password, String deviceToken) async {
  var res;
  var response;
  try {
    response = await http
        .post(
          Uri.parse(Urls.loginUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'username': username,
            'password': password,
            'DeviceToken': deviceToken,
          }),
        )
        .timeout(const Duration(seconds: 60));
    print(response.statusCode);
    if (response.statusCode != 200) {
      res = {
        "success": false,
        "status": response.statusCode,
        "message": _returnResponse(response)
      };
    } else {
      res = response;
    }
  } on SocketException {
    throw FetchDataException('No Internet connection');
  // ignore: unused_catch_clause
  } on TimeoutException catch (e) {
    res = {
      "success": false,
      "status": response.statusCode,
      "message": "Connection timeout"
    };
  } on Error catch (e) {
    print('Error: $e');
  }

  return res;
}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
