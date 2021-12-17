import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:matsapp/Modeles/notificationCountModel.dart';
import 'package:matsapp/utilities/urls.dart';

Future<NotificationCountModel> fetchNotificationsCount(
  String mobile,
  String apikey,
) async {
  final http.Response response = await http.post(
    Uri.parse(Urls.getNotificationCountUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'mobile': mobile,
      'api_Key': apikey,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    // var responseJson = json.decode(response.body);
    // print("responseJson stores: $responseJson");

    return NotificationCountModel.fromMap(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load Notification Count');
  }
}
