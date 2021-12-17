import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:matsapp/Modeles/homeTopBannerModel.dart';

import 'package:matsapp/utilities/urls.dart';

Future<TopBannerModel> fetchAdvertisementCatregory(String town, String pagetype,
    String position, String mobile, String apiKey, int categoryId) async {
  Map data = {
    'Town': town,
    'pagetype': pagetype,
    'Position': position,
    'mobile': mobile,
    'api_key': apiKey,
    'categoryID': categoryId,
  };
  final http.Response response = await http.post(
    Uri.parse(Urls.homeTopBannerUrl),
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
    return TopBannerModel.fromMap(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load STORE detailes');
  }
}
