import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:matsapp/Modeles/WishlistModel.dart';
import 'package:matsapp/utilities/urls.dart';

Future<WishlistModel> fetchWishlist(
  String mobile,
  double latitude,
  double longitude,
) async {
  Map data = {'mobile': mobile, 'Latitude': latitude, 'Longitude': longitude};

  final http.Response response = await http.post(
    Uri.parse(Urls.getWishListOfUserUrl),

    // Urls.baseUrls + 'getWishListOfUser',
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
    return WishlistModel.fromMap(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load Addtowislist');
  }
}
