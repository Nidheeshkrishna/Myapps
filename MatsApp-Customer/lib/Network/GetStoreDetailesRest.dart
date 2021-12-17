import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:matsapp/Modeles/GetStoredetailesModel.dart';
import 'package:matsapp/utilities/UserData.dart';

import 'package:matsapp/utilities/urls.dart';

Future<GetStoredetailesModel> fetchStordetailes(int businessID) async {
  Map data = {
    'BusinessID': businessID,
    'mobile': await userData().getMobileNo(),
    'Town': await userData().getSelectedTown(),
  };
  final http.Response response = await http.post(
    Uri.parse(Urls.getStoreInfoUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(data),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    var responseJson = json.decode(response.body);
    print("responseJson products: $responseJson");
    return GetStoredetailesModel.fromMap(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load STORE detailes');
  }
}
