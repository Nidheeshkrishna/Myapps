import 'dart:convert';
import 'dart:io';

import 'package:matsapp/Modeles/Login/LoginModel.dart';

import 'package:matsapp/utilities/urls.dart';

Future<LoginModel> loginCustomer1(
    String username, String password, String deviceToken) async {
  //String deviceToken/f
  HttpClient client = new HttpClient();
  client.badCertificateCallback =
      ((X509Certificate cert, String host, int port) => true);

  Map map = {
    'username': username,
    'password': password,
    'DeviceToken': deviceToken,
  };
  HttpClientRequest request = await client.postUrl(Uri.parse(Urls.loginUrl));

  request.headers.set('content-type', 'application/json');

  request.add(utf8.encode(json.encode(map)));

  HttpClientResponse response1 = await request.close();

  String reply = await response1.transform(utf8.decoder).join();
  return LoginModel.fromMap(jsonDecode(reply));

  // If the server did not return a 201 CREATED response,
  // then throw an exception.
}
