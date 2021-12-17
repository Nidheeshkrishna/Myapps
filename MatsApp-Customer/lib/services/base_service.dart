import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:matsapp/Modeles/SqlLiteTableDataModel.dart';
import 'package:matsapp/utilities/DatabaseHelper.dart';
import 'package:matsapp/utilities/urls.dart';

import 'app_exceptions.dart';

typedef onSuccess<T> = Function(T);
typedef onFailure = Function(AppException);

class BaseService {
  String selectedDistrict;
  DatabaseHelper dbHelper = new DatabaseHelper();

  BaseService();
  Future<String> get getApiKey async {
    DatabaseHelper dbHelper = new DatabaseHelper();
    List<UserInfo> user = await dbHelper.getAll();
    return user.first.apitoken;
  }

  Future<String> getMobileNo() async {
    DatabaseHelper dbHelper = new DatabaseHelper();
    List<UserInfo> user = await dbHelper.getAll();
    return user.first.mobilenumber;
  }

  Future<String> getSelectedTown() async {
    DatabaseHelper dbHelper = new DatabaseHelper();
    List<UserInfo> user = await dbHelper.getAll();
    return user.first.selectedTown;
  }

  Future<String> getSelectedState() async {
    List<UserInfo> user = await dbHelper.getAll();
    return user.first.state;
  }

  Future<String> getSelectedDistrict() async {
    List<UserInfo> user = await dbHelper.getAll();
    return user.first.district;
  }

  Future<int> getUserId() async {
    DatabaseHelper dbHelper = new DatabaseHelper();
    List<UserInfo> user = await dbHelper.getAll();
    return user.first.userid;
  }

  void postService({
    @required String service,
    @required Map<String, dynamic> params,
    @required onFailure onException,
    @required onSuccess<dynamic> onSuccess,
  }) async {
    String url = Urls.baseUrls + service + "?";

    final headers = {
      HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(params),
      );
      print("request : $url + ${jsonEncode(params)}");
      var result = _parseResponse(response);
      if (result is AppException) {
        onException(result);
      } else {
        onSuccess(result);
      }
    } on SocketException {
      onException(FetchDataException('No Internet connection'));
    }
  }

  void getService({
    @required String service,
    @required Map<String, dynamic> params,
    @required onFailure onException,
    @required onSuccess<dynamic> onSuccess,
  }) async {
    String url = Urls.baseUrls + service + "?";

    String formBody = "";
    params.forEach((key, value) => {
          formBody +=
              key + '=' + Uri.encodeQueryComponent(value.toString()) + '&'
        });

    final headers = {
      HttpHeaders.contentTypeHeader: "application/json; charset=UTF-8",
    };

    try {
      final response = await http.get(
        Uri.parse(url + formBody),
        headers: headers,
      );
      print("request : $url$formBody");

      var result = _parseResponse(response);
      if (result is AppException) {
        onException(result);
      } else {
        onSuccess(result);
      }
    } on SocketException {
      onException(FetchDataException('No Internet connection'));
    } catch (e) {
      onException(FetchDataException(e.toString()));
    }
  }

  dynamic _parseResponse(http.Response response) {
    print("response ${response.body}");
    switch (response.statusCode) {
      case 200:
        try {
          return json.decode(response.body.toString());
        } catch (e) {
          throw FetchDataException(
              'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
        }
        break;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  Future<Null> uploadImage({
    @required onFailure onException,
    @required onSuccess<dynamic> onSuccess,
    String service,
    String path,
    Map<String, dynamic> params,
  }) async {
    String url = Urls.baseUrls + service + "?";
    File image = File(path);
    print("upload request : " + params.toString());
    print("file path ${image.path}");
    String formBody = "";
    params.forEach((key, value) => {
          formBody +=
              key + '=' + Uri.encodeQueryComponent(value.toString()) + '&'
        });

    final imageUploadRequest = http.MultipartRequest(
      'GET',
      Uri.parse(url + formBody),
    );

    final file = await http.MultipartFile.fromPath('Image', image.path);
    // params.forEach((key, value) {
    //   imageUploadRequest.fields[key] = value;
    // });
    imageUploadRequest.files.add(file);

    print("Started uploading file ");
    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      print("Completed uploading file");
      onSuccess(_parseResponse(response));
    } catch (e) {
      print(e);
      onException(FetchDataException("Failed to upload image" + e ?? ""));
    }

    return null;
  }
}
