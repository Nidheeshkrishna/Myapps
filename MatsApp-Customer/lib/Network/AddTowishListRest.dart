import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:matsapp/Modeles/AddTowishListModel.dart';
import 'package:matsapp/utilities/UserData.dart';
import 'package:matsapp/utilities/urls.dart';

Future<AddTowishListModel> fetchAddTowishList(
    String category, int categoryid) async {
  Map data = {
    'category': category,
    'categoryid': categoryid,
    'mobile': await userData().getMobileNo(),
  };
  final http.Response response = await http.post(
    Uri.parse(Urls.addtoWishListUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(data),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    var responseJson = json.decode(response.body);
    print("responseJson add: $responseJson");
    return AddTowishListModel.fromMap(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load Addtowislist');
  }
}

Future<AddTowishListModel> fetchAddTowishListProduct(
    String category, String couponid, String mobile) async {
  Map data = {
    'category': category,
    'categoryid': couponid,
    'mobile': await userData().getMobileNo(),
  };
  final http.Response response = await http.post(
    Uri.parse(Urls.addtoWishListUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(data),
  );
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    var responseJson = json.decode(response.body);
    print("responseJson add: $responseJson");
    return AddTowishListModel.fromMap(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load Addtowislist');
  }
}