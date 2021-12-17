import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:matsapp/Modeles/ChangeLocation/ChangeLocationModel.dart';


import 'package:matsapp/utilities/urls.dart';

Future<ChangeLocationModel> updateLocation({
  String state,
  String district,
  String town,
  String subTown,
  String mobile,
  String apikey,
}) async {
  Map data = {
    'state': state,
    'district': district,
    'Town': town,
    'subTown':subTown,
    'mobile': mobile,
    'api_key': apikey,
  };
  final http.Response response = await http.post(
    Uri.parse(Urls.updateLocation),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(data),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    var responseJson = json.decode(response.body);
    print("responseJson : $responseJson");
    return ChangeLocationModel.fromMap(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to  Load Location');
  }
}
