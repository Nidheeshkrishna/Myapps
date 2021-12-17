import 'dart:async';
import 'dart:convert';
import 'dart:io';

// ignore: import_of_legacy_library_into_null_safe

import 'package:http/http.dart' as http;
import 'package:matsapp/Modeles/TownVerifiy/TownVerifiyModel.dart';
import 'package:matsapp/utilities/UserData.dart';
import 'package:matsapp/utilities/urls.dart';

Future<TownVerifiyModel> townverifiyservice() async {
  // String r =  g.getApiKey,
  // String t = await g.getSelectedTown(),
  // String la = g.geLatitude;
  // String lo = await g.getLoggggg(),

  // print("data$r,$t,$la,$lo");
  Map data = {
    'UserID': await userData().getUserId(),
    'Mobile': await userData().getMobileNo(),
    'api_key': await userData().getApiKey,
  };
  try {
    // GetMylocation().getLocation();
    final http.Response response = await http.post(
      Uri.parse(Urls.townverifiyUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,

      //var responseJson = json.decode(response.body);
      //print("responseJson123 : $responseJson");
      //print("KLKLlkkk$setLocation().myLatitude");
      return TownVerifiyModel.fromMap(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load stores');
    }
  } on TimeoutException catch (_) {
    throw Exception('Time Out Exception');
  } on SocketException catch (_) {
    throw Exception('Socket Exception');
  }
}
