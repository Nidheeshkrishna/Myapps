import 'dart:async';
import 'dart:convert';

import 'dart:io';

// ignore: import_of_legacy_library_into_null_safe

import 'package:http/http.dart' as http;
import 'package:matsapp/Modeles/TopStoresModel.dart';
import 'package:matsapp/utilities/GetCurrentLocation.dart';
import 'package:matsapp/utilities/UserData.dart';
import 'package:matsapp/utilities/getMyLocaton.dart';
import 'package:matsapp/utilities/urls.dart';

Future<TopStoresModel> fetchTopStore(
    [String town,
    String mobile,
    String latitude,
    String longitude,
    String apikey,
    String searchKey]) async {
  // String r =  g.getApiKey,
  // String t = await g.getSelectedTown(),
  // String la = g.geLatitude;
  // String lo = await g.getLoggggg(),

  // print("data$r,$t,$la,$lo");

  try {
   // GetMylocation().getLocation();
    final http.Response response = await http.post(
      Uri.parse(Urls.getTop9StoresUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'Town': await userData().getSelectedTown(),
        'Mobile': await userData().getMobileNo(),
        'Latitude': await userData().getMyLatitude,
        'Longitude': await userData().getMyLogitude,
        'api_key': await userData().getApiKey,
        'SearchKey': searchKey
      }),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,

      //var responseJson = json.decode(response.body);
      //print("responseJson123 : $responseJson");
      //print("KLKLlkkk$setLocation().myLatitude");
      return TopStoresModel.fromMap(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load stores');
    }
  } on TimeoutException catch (_) {
    throw Exception('Time Out Exception');
  } on SocketException catch (_) {
    throw Exception('Socket Exception');
  }
}

enum TopStoreAction { fetch, load }

class TopstoreBloc {
  //     final String user;
  //  final int increaseAge;

  String apikey;

  String town;

  final _topstorestreamControllerResult =
      StreamController<List<List1>>.broadcast();
  StreamSink<List<List1>> get resultSink =>
      _topstorestreamControllerResult.sink;
  Stream<List<List1>> get resultStream =>
      _topstorestreamControllerResult.stream;

  final _topstorestreamController1 = StreamController<List<List1>>.broadcast();
  StreamSink<List<List1>> get list1Sink => _topstorestreamController1.sink;
  Stream<List<List1>> get list1Stream => _topstorestreamController1.stream;

  final _topstorestreamController2 = StreamController<List<List1>>.broadcast();
  StreamSink<List<List1>> get list2Sink => _topstorestreamController2.sink;
  Stream<List<List1>> get list2Stream2 => _topstorestreamController2.stream;

  final _eventstreamController = StreamController<TopStoreAction>();
  StreamSink<TopStoreAction> get eventSink => _eventstreamController.sink;
  Stream<TopStoreAction> get eventStream => _eventstreamController.stream;

  // getdata() async {
  //   GetCurrentLocation g = GetCurrentLocation();
  //   apikey = await g.getApiKey;
  //   town = await g.getSelectedTown();
  //   //mobile = await g.getMobileNo();
  // }

  TopstoreBloc() {
    eventStream.listen((event) async {
      if (event == TopStoreAction.fetch) {
        try {
          var news = await fetchTopStore();

          if (news.apiKeyStatus) {
            resultSink.add(news.result);
            list1Sink.add(news.list1);
            list2Sink.add(news.list2);
          } else {
            resultSink.addError("Something went wrong");
            list1Sink.addError("Something went wrong");
            list2Sink.addError("Something went wrong");
          }
        } on Exception catch (_) {
          resultSink.addError("Something went wrong");
          list1Sink.addError("Something went wrong");
          list2Sink.addError("Something went wrong");
        }
      } else {}
    });
  }

  void dispose() {
    _topstorestreamController1.close();
    _topstorestreamControllerResult.close();
    _topstorestreamController2.close();
    _eventstreamController.close();
  }
}
