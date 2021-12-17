import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:matsapp/Modeles/SearchOffersListModel.dart';
import 'package:matsapp/utilities/UserData.dart';
import 'package:matsapp/utilities/urls.dart';

Future<SearchListModel> fetchSearchOffers(
    String keyword, String location) async {
  Map data = {
    'Keyword': keyword,
    'Location': await userData().getSelectedTown(),
    'UserLatitude': await userData().getMyLatitude,
    'UserLongitude':  await userData().getMyLogitude,
    'UserID': await userData().getUserId()
  };
  final http.Response response = await http.post(
    Uri.parse(Urls.searchAppUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(data),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    var responseJson = json.decode(response.body);
    print("responseJson store search : $responseJson");
    return SearchListModel.fromMap(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to  Load Productin area');
  }
}
