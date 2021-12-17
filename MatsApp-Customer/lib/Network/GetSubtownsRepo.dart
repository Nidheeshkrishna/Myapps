import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:matsapp/Modeles/LocationModels/GetSubTownsModel.dart';

import 'package:matsapp/utilities/urls.dart';

Future<GetSubTownsModel> getSubTowns(String town) async {
  final http.Response response = await http.post(
    Uri.parse(Urls.getSubTownsUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'Town': town,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    var responseJson = json.decode(response.body);
    print("responseJson : $responseJson");

    return GetSubTownsModel.fromMap(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load Subtowns Api');
  }
}
