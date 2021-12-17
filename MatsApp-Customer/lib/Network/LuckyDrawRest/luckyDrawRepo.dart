import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:matsapp/Modeles/AllcategoryModel.dart';
import 'package:matsapp/Modeles/LuckyDrawModels/luckyDrawModel.dart';
import 'package:matsapp/services/app_exceptions.dart';
import 'package:matsapp/utilities/UserData.dart';
import 'package:matsapp/utilities/urls.dart';

Future<LuckyDrawModel> fetchLuckyDrawTickets1() async {
  Map param = {
    "UserID": await userData().getUserId(),
  };
  final http.Response response = await http.post(
    Uri.parse(Urls.getTicketData),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(param),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    // var responseJson = json.decode(response.body);
    // print("responseJson add: $responseJson");
    return LuckyDrawModel.fromMap(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load Addtowislist');
  }
}

Future<LuckyDrawModel> fetchLuckyDrawTickets() async {
  //print("Calling API: $url");
  //print("Calling parameters: $param");
  Map param = {
    "UserID": await userData().getUserId(),
  };
  var responseJson;
  try {
    final http.Response response = await http.post(
      Uri.parse(Urls.getTicketData),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(param),
    );
    responseJson = _response(response);
  } on SocketException {
    throw FetchDataException('No Internet connection');
  }

  return responseJson;
}

dynamic _response(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = LuckyDrawModel.fromMap(jsonDecode(response.body));
      return responseJson;
    case 400:
      throw BadRequestException(response.body.toString());
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode: ${response.statusCode}');
  }
}
