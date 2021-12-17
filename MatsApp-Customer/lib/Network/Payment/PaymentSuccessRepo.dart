import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:matsapp/Modeles/PaymentModels/PaymentScccessModel.dart';

import 'package:matsapp/utilities/UserData.dart';
import 'package:matsapp/utilities/urls.dart';

Future<PaymentScccessModel> paymentProcess([
  int orderID,
  String razorID,
]) async {
  Map data = {
    'OrderID': orderID,
    'mobile': await userData().getMobileNo(),
    'UserID': await userData().getUserId(),
    'api_key': await userData().getApiKey,
    'RazorID': razorID,
  };
  try {
    final http.Response response = await http.post(
      Uri.parse(Urls.generateCouponsAfterPaymentUrl),
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
