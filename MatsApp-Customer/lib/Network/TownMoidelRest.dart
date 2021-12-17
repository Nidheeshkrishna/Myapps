import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:matsapp/Modeles/ChangeLocation/TownModel.dart';


import 'package:matsapp/utilities/urls.dart';

Future<TownModel> getTowndata(String district) async {
  final http.Response response = await http.post(
    Uri.parse(Urls.getTownsUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'District': district,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    var responseJson = json.decode(response.body);
    print("responseJson : $responseJson");

    return TownModel.fromMap(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load login Api');
  }
}