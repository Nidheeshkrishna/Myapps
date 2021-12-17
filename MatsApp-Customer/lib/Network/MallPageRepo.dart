import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:matsapp/Modeles/Mallpage/MallPageModel.dart';
import 'package:matsapp/utilities/UserData.dart';
import 'package:matsapp/utilities/urls.dart';

Future<MallPageModel> fetchMallInfo(
  int businessID,
) async {
  Map data = {
    'businessID': businessID,
    'mobile': await userData().getMobileNo(),
    'userlat': await userData().getMyLatitude,
    'userlong': await userData().getMyLogitude,
  };

  final http.Response response = await http.post(
    Uri.parse(Urls.getMallInfoUrl),
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
    return MallPageModel.fromMap(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to  Load Productin area');
  }
}