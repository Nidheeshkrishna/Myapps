import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:matsapp/Modeles/PaymentModels/PaymentScccessModel.dart';

import 'package:matsapp/utilities/UserData.dart';
import 'package:matsapp/utilities/urls.dart';

Future<PaymentScccessModel> premiumPayment([
  int orderID,
  String razorID,
  int pkg_id,
  double amount,
]) async {
  Map data = {
    'UserID': await userData().getUserId(),
    'OrderID': orderID,
    'PKG_ID': pkg_id,
    'RazorID': razorID,
    'mobile': await userData().getMobileNo(),
    'Amount': amount,
    'api_key': await userData().getApiKey,
  };
  try {
    final http.Response response = await http.post(
      Uri.parse(Urls.premiumSubscriptionAfterPayment),
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
      return PaymentScccessModel.fromMap(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load login Api');
    }
  } on TimeoutException catch (_) {
    throw Exception('Something Went wrong');
  } on SocketException catch (_) {
    throw Exception('No Internet Connection');
  }
}
