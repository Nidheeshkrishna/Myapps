import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:matsapp/Modeles/ExclusiveDealsModel1.dart';
import 'package:matsapp/utilities/UserData.dart';
import 'package:matsapp/utilities/getMyLocaton.dart';
import 'package:matsapp/utilities/urls.dart';

Future<ExclusiveDealsModel1> fetchTopExclusiveDeals1(
    [String town,
    String mobile,
    String apiKey,
    String latitude,
    String longitude]) async {
  GetMylocation().getLocation();
  Map data = {
    'Town': await userData().getSelectedTown(),
    'mobile': await userData().getMobileNo(),
    'api_Key': await userData().getApiKey,
    'Latitude': await userData().getMyLatitude,
    'Longitude': await userData().getMyLogitude
  };
  try {
    final http.Response response = await http.post(
      Uri.parse(Urls.exclusivedealsUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      // var responseJson = json.decode(response.body);
      // print("responseJson exclusive: $responseJson");
      return ExclusiveDealsModel1.fromMap(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to load area');
    }
  } on TimeoutException catch (_) {
    throw Exception('Time Out Exception');
  } on SocketException catch (_) {
    throw Exception('Socket Exception');
  }
}

enum ExclusiveDealsAction { fetch, load }

class ExclusiveDealsBloc {
  //     final String user;
  //  final int increaseAge;

  String apikey;

  String town;

  final _exclusiveDealsstreamControllermain =
      StreamController<List<List1>>.broadcast();
  StreamSink<List<List1>> get mainSink =>
      _exclusiveDealsstreamControllermain.sink;
  Stream<List<List1>> get mainStream =>
      _exclusiveDealsstreamControllermain.stream;

  final _exclusiveDealsstreamController1 =
      StreamController<List<List1>>.broadcast();
  StreamSink<List<List1>> get list1Sink =>
      _exclusiveDealsstreamController1.sink;
  Stream<List<List1>> get list1Stream =>
      _exclusiveDealsstreamController1.stream;

  final _exclusiveDealsstreamController2 =
      StreamController<List<List1>>.broadcast();
  StreamSink<List<List1>> get list2Sink =>
      _exclusiveDealsstreamController2.sink;
  Stream<List<List1>> get list2Stream2 =>
      _exclusiveDealsstreamController2.stream;

  final _eventstreamController = StreamController<ExclusiveDealsAction>();
  StreamSink<ExclusiveDealsAction> get eventSink => _eventstreamController.sink;
  Stream<ExclusiveDealsAction> get eventStream => _eventstreamController.stream;

  // getdata() async {
  //   GetCurrentLocation g = GetCurrentLocation();
  //   apikey = await g.getApiKey;
  //   town = await g.getSelectedTown();
  //   //mobile = await g.getMobileNo();
  // }

  ExclusiveDealsBloc() {
    eventStream.listen((event) async {
      if (event == ExclusiveDealsAction.fetch) {
        try {
          var news = await fetchTopExclusiveDeals1();

          if (news.apiKeyStatus) {
            mainSink.add(news.result);
            list1Sink.add(news.list1);
            list2Sink.add(news.list2);
          } else {
            mainSink.addError("Something went wrong");
            list1Sink.addError("Something went wrong");
            list2Sink.addError("Something went wrong");
          }
        } on Exception catch (_) {
          mainSink.addError("Something went wrong");
          list1Sink.addError("Something went wrong");
          list2Sink.addError("Something went wrong");
        }
      } else {}
    });
  }

  void dispose() {
    _exclusiveDealsstreamControllermain.close();
    _exclusiveDealsstreamController1.close();
    _exclusiveDealsstreamController2.close();

    _eventstreamController.close();
  }
}
