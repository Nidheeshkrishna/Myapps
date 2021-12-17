import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:matsapp/Modeles/ProductListModel.dart';
import 'package:matsapp/utilities/UserData.dart';

import 'package:matsapp/utilities/urls.dart';

Future<ProductListModel> fetchTopProduct(int productID, String town) async {
  Map data = {
    'UserID': await userData().getUserId(),
    'ProductID': productID,
    'Town': town,
  };
  final http.Response response = await http.post(
    Uri.parse(Urls.getproductInfoUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(data),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    var responseJson = json.decode(response.body);
    print("responseJson product info : $responseJson");
    return ProductListModel.fromMap(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to  Load Productin area');
  }
}
