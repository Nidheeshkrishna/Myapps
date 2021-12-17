import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:matsapp/Modeles/Login/LoginExistCheckModel.dart';

import 'package:matsapp/services/app_exceptions.dart';
import 'package:matsapp/utilities/UserData.dart';
import 'package:matsapp/utilities/urls.dart';

Future<LoginExistCheckModel> loginExistCheck() async {
  http.Response response;
  //String deviceToken/f

  try {
    response = await http.post(
      Uri.parse(Urls.loginExist),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'Mobile': await userData().getMobileNo(),
        'api_key': await userData().getApiKey,
      }),
    );
  } on SocketException {
    throw FetchDataException('No Internet connection');
  }

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    var responseJson = json.decode(response.body);
    print("responseJson : $responseJson");
    return LoginExistCheckModel.fromMap(jsonDecode(response.body));
  } else {
    switch (response.statusCode) {
      case 400:
        return throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        return throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        return throw FetchDataException(' ${response.statusCode}');
    }
  }

  // If the server did not return a 201 CREATED response,
  // then throw an exception.
}
