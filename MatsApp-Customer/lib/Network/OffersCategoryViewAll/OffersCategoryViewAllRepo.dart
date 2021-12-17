import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:matsapp/Modeles/OffersModel/OffersCategoryViewAll.dart';

import 'package:matsapp/utilities/UserData.dart';
import 'package:matsapp/utilities/getMyLocaton.dart';
import 'package:matsapp/utilities/urls.dart';

Future<OffersCategoryViewAll> fetchOffersViewall(
  String headingID,
) async {
  //GetCurrentLocation().getCurrentLocation();
  GetMylocation().getLocation();

  final http.Response response = await http.post(
    Uri.parse(Urls.viewAllOfferPage),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'Town': await userData().getSelectedTown(),
      'Mobile': await userData().getMobileNo(),
      'api_Key': await userData().getApiKey,
      'Latitude': await userData().getMyLatitude,
      'Longitude': await userData().getMyLogitude,
      'headingID': headingID
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    // var responseJson = json.decode(response.body);
    // print("responseJson stores: $responseJson");

    return OffersCategoryViewAll.fromMap(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load storedeals Api');
  }
}
