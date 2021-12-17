import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:matsapp/Modeles/SubscribePremiumModel.dart';
import 'package:matsapp/services/app_exceptions.dart';
import 'package:matsapp/utilities/UserData.dart';

import 'package:matsapp/utilities/urls.dart';

Future<SubscribePremiumModel> subscribePremium(
    int pkg_id, double amount) async {
  Map data = {
    'UserID': await userData().getUserId(),
    'PKG_ID': pkg_id,
    'mobile': await userData().getMobileNo(),
    'Amount': amount,
    'api_key': await userData().getApiKey,
  };
  http.Response response;
  try {
    response = await http.post(
      Uri.parse(Urls.subscribePremium),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
  } on SocketException {
    throw FetchDataException('No Internet connection');
  }
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    var responseJson = json.decode(response.body);
    print("responseJson products: $responseJson");
    return SubscribePremiumModel.fromMap(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load STORE detailes');
  }
}
