import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:matsapp/Modeles/ShareCouponModel.dart';
import 'package:matsapp/utilities/UserData.dart';

import 'package:matsapp/utilities/urls.dart';

Future<ShareCouponModel> shareVoucherTomobile(
  String mobile,
  String mobileTobeshared,
  String userVoucherID,
) async {
  Map data = {
    'mobile': mobile,
    'mobile_tobeshared': mobileTobeshared,
    'api_key': await userData().getApiKey,
    'UserVoucherID': userVoucherID,
  };
  final http.Response response = await http.post(
    Uri.parse(Urls.shareVoucher),
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
    return ShareCouponModel.fromMap(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load shareVoucher api');
  }
}
