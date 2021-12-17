import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:matsapp/Modeles/Greetings/GreetingsModel.dart';

import 'package:matsapp/utilities/UserData.dart';
import 'package:matsapp/utilities/urls.dart';

Future<GreetingsModel> fetchGreetings() async {
  final http.Response response = await http.post(
    Uri.parse(Urls.getGreetingsNotificationUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'Mobile': await userData().getMobileNo(),
      'api_Key': await userData().getApiKey,
      'AppType': "CUSTOMER",
      'Town': await userData().getSelectedTown(),
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    // var responseJson = json.decode(response.body);
    // print("responseJson : $responseJson");

    return GreetingsModel.fromMap(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load login Api');
  }
}
