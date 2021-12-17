import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:matsapp/Modeles/CompleteRegistrationModel.dart';
import 'package:matsapp/utilities/urls.dart';

Future<CompleteRegistrationModel> customerCompleteRegistration(
    String mobile,
    String password,
    String state,
    String district,
    String town,
    String subTown,
    String deviceid) async {
  try {
    final http.Response response = await http.post(
      Uri.parse(Urls.completeRegistrationUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'mobile': mobile,
        'password': password,
        'state': state,
        'district': district,
        'town': town,
        'DeviceToken': deviceid,
        'subTown': subTown
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      var responseJson = json.decode(response.body);
      print("responseJson : $responseJson");
      return CompleteRegistrationModel.fromMap(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load login Api');
    }
  } on TimeoutException catch (_) {
    throw Exception('Something Went wrong');
  } on SocketException catch (_) {
    throw Exception('No Internet Connection');
  }
}
