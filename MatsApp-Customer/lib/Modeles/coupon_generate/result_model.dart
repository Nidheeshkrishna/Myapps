import 'package:matsapp/utilities/app_json_parser.dart';

class ResultModel {
  String result;
  String statusMessage;

  ResultModel.fromJson(Map<String, dynamic> json)
      : result = AppJsonParser.goodString(json, 'result'),
        statusMessage = AppJsonParser.goodString(json, 'status');
}
