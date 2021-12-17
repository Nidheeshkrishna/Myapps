import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:matsapp/Modeles/DealsOftheDayModel.dart';

import 'package:matsapp/utilities/UserData.dart';
import 'package:matsapp/utilities/getMyLocaton.dart';

import 'package:matsapp/utilities/urls.dart';

Future<DealsOftheDayModel> fetchDelsOftheDay(
    [String town,
    String mobile,
    String apiKey,
    String latitude,
    String longitude]) async {
  GetMylocation().getLocation();
  final http.Response response = await http.post(
    Uri.parse(Urls.dealsofDayUrl),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'Town': await userData().getSelectedTown(),
      'mobile': await userData().getMobileNo(),
      'api_Key': await userData().getApiKey,
      'Latitude': await userData().getMyLatitude,
      'Longitude': await userData().getMyLogitude
    }),
  );

  if (response.statusCode == 200) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    // var responseJson = json.decode(response.body);
    // print("responseJson deals of the day: $responseJson");

    return DealsOftheDayModel.fromMap(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to load storedeals Api');
  }
}

enum DealsoftedayAction { fetch, load }

class DealsofthedayBloc {
  //     final String user;
  //  final int increaseAge;

  String apikey;

  String town;

  final _dealsoftheDaystreamControllermain =
      StreamController<List<List1>>.broadcast();
  StreamSink<List<List1>> get mainSink =>
      _dealsoftheDaystreamControllermain.sink;
  Stream<List<List1>> get mainStream =>
      _dealsoftheDaystreamControllermain.stream;

  final _dealsoftheDaystreamController1 =
      StreamController<List<List1>>.broadcast();
  StreamSink<List<List1>> get list1Sink => _dealsoftheDaystreamController1.sink;
  Stream<List<List1>> get list1Stream => _dealsoftheDaystreamController1.stream;

  final _dealsoftheDaystreamController2 =
      StreamController<List<List1>>.broadcast();
  StreamSink<List<List1>> get list2Sink => _dealsoftheDaystreamController2.sink;
  Stream<List<List1>> get list2Stream2 =>
      _dealsoftheDaystreamController2.stream;

  final _eventstreamController = StreamController<DealsoftedayAction>();
  StreamSink<DealsoftedayAction> get eventSink => _eventstreamController.sink;
  Stream<DealsoftedayAction> get eventStream => _eventstreamController.stream;

  // getdata() async {
  //   GetCurrentLocation g = GetCurrentLocation();
  //   apikey = await g.getApiKey;
  //   town = await g.getSelectedTown();
  //   //mobile = await g.getMobileNo();
  // }

  DealsofthedayBloc() {
    eventStream.listen((event) async {
      if (event == DealsoftedayAction.fetch) {
        try {
          var news = await fetchDelsOftheDay();

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
    _dealsoftheDaystreamControllermain.close();
    _dealsoftheDaystreamController1.close();
    _dealsoftheDaystreamController2.close();

    _eventstreamController.close();
  }
}
