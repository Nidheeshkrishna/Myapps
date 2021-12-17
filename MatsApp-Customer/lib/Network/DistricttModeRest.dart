import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:matsapp/Modeles/ChangeLocation/DistictModel.dart';

import 'package:matsapp/utilities/urls.dart';

Future<DistrictModel> getDistrict(String state) async {
  final http.Response response = await http.post(
    Uri.parse(Urls.getDistrictsUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'state': state,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.

    var responseJson = json.decode(response.body);
    print("responseJson : $responseJson");

    // var districts =
    //         .map<DistrictModel>((e) => DistrictModel.fromMap(e))
    //         .toList();

    return DistrictModel.fromMap(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load login Api');
  }
}
/*
Future<Result> getUseSelectedDistrict(
    String state, String district) async {
  final http.Response response = await http.post(
    Uri.parse(Urls.getDistrictsUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'state': state,
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.

    var responseJson = json.decode(response.body);
    print("responseJson : $responseJson");

    // var districts =
    //         .map<DistrictModel>((e) => DistrictModel.fromMap(e))
    //         .toList();

    return DistrictModel.fromMap(jsonDecode(response.body))
        .result
        .where((element) => element.disPkDistrict == district).first;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load login Api');
  }
}
*/