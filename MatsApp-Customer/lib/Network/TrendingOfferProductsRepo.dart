import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:matsapp/Modeles/TrendingOfferProductsModel.dart';
import 'package:matsapp/utilities/UserData.dart';

import 'package:matsapp/utilities/urls.dart';

Future<TrendingOfferProductsModel> fetchStoreTrendingDeals(
    int offerID, String town) async {
  Map data = {
    'OfferID': offerID,
    'Town': await userData().getSelectedTown(),
    'UserID': await userData().getUserId(),
    'Mobile': await userData().getMobileNo(),
    'api_key': await userData().getApiKey
  };
  final http.Response response = await http.post(
    Uri.parse(Urls.trendingdealsInfoUrl),
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
    return TrendingOfferProductsModel.fromMap(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to  Load Productin area');
  }
}
