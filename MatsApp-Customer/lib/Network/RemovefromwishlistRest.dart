import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:matsapp/Modeles/RemoveTowishListModel.dart';
import 'package:matsapp/utilities/UserData.dart';

import 'package:matsapp/utilities/urls.dart';

Future<RemoveTowishListModel> fetchRemoveFromwishList(
     int wishListID) async {
  Map data = {
    'mobile': await userData().getMobileNo(),
    'wishListID': wishListID,
  };
  final http.Response response =
      await http.post(Uri.parse(Urls.removefromWishListUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(data));
  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    // var responseJson = json.decode(response.body);
    // print("responseJson remove : $responseJson");
    return RemoveTowishListModel.fromMap(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load Removefromwislist');
  }
}