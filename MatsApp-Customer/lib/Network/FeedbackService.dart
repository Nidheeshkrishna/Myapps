import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:matsapp/services/app_exceptions.dart';
import 'package:matsapp/utilities/urls.dart';

Future<dynamic> saveCustomerFeedback(
  String district,
  String mobile,
  String apikey,
  String userID,
  String town,
  String message,
  String userType,
  String rating,
) async {
  // http.Response response;

  try {
    Map<String, String> requestBody = <String, String>{
      'mobile': mobile,
      'api_key': apikey,
      'UserID': userID,
      'District': district,
      'Town': town,
      'Message': message,
      'UserType': userType,
      'Rating': rating,
    };
    Map<String, String> headers = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    var uri = Uri.parse(Urls.baseUrls + "SaveCustomerFeedback");
    var request = http.MultipartRequest('POST', uri)
      ..headers.addAll(headers)
      ..fields.addAll(requestBody);
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    // return jsonDecode(respStr);
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      var responseJson = json.decode(respStr);
      print("responseJson : $responseJson");
      return jsonDecode(respStr);
    } else {
      switch (response.statusCode) {
        case 400:
          return throw BadRequestException(respStr.toString());
        case 401:
        case 403:
          return throw UnauthorisedException(respStr.toString());
        case 500:
        default:
          return throw FetchDataException(' ${response.statusCode}');
      }
    }
  } on SocketException {
    throw FetchDataException('No Internet connection');
  }

  // If the server did not return a 201 CREATED response,
  // then throw an exception.
}
